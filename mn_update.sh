#!/bin/bash

TMP_FOLDER=$(mktemp -d)
CONFIG_FILE='SpectreSecurityCoin.conf'
CONFIGFOLDER='/root/.SpectreSecurityCoin'
COIN_DAEMON='SpectreSecurityCoind'
COIN_CLI='SpectreSecurityCoind'
COIN_PATH='/usr/local/bin/'
COIN_REPO='https://github.com/SpectreSecurityCoin/SpectreSecurityCoin.git'
COIN_TGZ='https://github.com/SpectreSecurityCoin/SpectreSecurityCoin/releases/download/v1.0.1.6-1/SpectreSecurityCoind.tar.gz'
COIN_BOOTSTRAP='https://bootstrap.spectresecurity.io/boot_strap.tar.gz'
COIN_ZIP=$(echo $COIN_TGZ | awk -F'/' '{print $NF}')
SENTINEL_REPO='N/A'
COIN_NAME='SpectreSecurityCoin'
COIN_PORT=13338
RPC_PORT=13337

NODEIP=$(curl -s4 icanhazip.com)

BLUE="\033[0;34m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m" 
PURPLE="\033[0;35m"
RED='\033[0;31m'
GREEN="\033[0;32m"
NC='\033[0m'
MAG='\e[1;35m'

purgeOldInstallation() {
    echo -e "${GREEN}Searching and removing old $COIN_NAME Daemon{NC}"
    #kill wallet daemon
    sudo killall SpectreSecurityCoind > /dev/null 2>&1
    cd $CONFIGFOLDER >/dev/null 2>&1
    rm -rf *.pid *.lock blk*.dat tx* database >/dev/null 2>&1
    #remove binaries and SpectreSecurityCoin utilities
    cd /usr/local/bin && sudo rm SpectreSecurityCoind > /dev/null 2>&1 && cd
    echo -e "${GREEN}* Done${NONE}";
}


function download_node() {
  echo -e "${GREEN}Downloading and Installing VPS $COIN_NAME Daemon${NC}"
  cd $TMP_FOLDER >/dev/null 2>&1
  wget -q $COIN_TGZ
  compile_error
  tar xvzf $COIN_ZIP >/dev/null 2>&1
  chmod +x $COIN_DAEMON $COIN_CLI
  cp $COIN_DAEMON $COIN_CLI $COIN_PATH
  cd ~ >/dev/null 2>&1
  rm -rf $TMP_FOLDER >/dev/null 2>&1
  clear
}

function download_bootstrap() {
  echo -e "${GREEN}Downloading and Installing $COIN_NAME BootStrap${NC}"
  cd $TMP_FOLDER >/dev/null 2>&1
  rm -rf boot* >/dev/null 2>&1
  wget -q $COIN_BOOTSTRAP
  cd $CONFIGFOLDER >/dev/null 2>&1
  rm -rf blk* database* txindex* peers.dat
  cd $TMP_FOLDER >/dev/null 2>&1
  tar xvzf $COIN_BOOTSTRAP >/dev/null 2>&1
  cp -Rv cache/* $CONFIGFOLDER >/dev/null 2>&1
  cd ~ >/dev/null 2>&1
  rm -rf $TMP_FOLDER >/dev/null 2>&1
  clear
 
}


function enable_firewall() {
  echo -e "Installing and setting up firewall to allow ingress on port ${GREEN}$COIN_PORT${NC}"
  ufw allow $COIN_PORT/tcp comment "$COIN_NAME MN port" >/dev/null
  ufw allow ssh comment "SSH" >/dev/null 2>&1
  ufw limit ssh/tcp >/dev/null 2>&1
  ufw default allow outgoing >/dev/null 2>&1
  echo "y" | ufw enable >/dev/null 2>&1
}


function compile_error() {
if [ "$?" -gt "0" ];
 then
  echo -e "${RED}Failed to compile $COIN_NAME. Please investigate.${NC}"
  exit 1
fi
}


function checks() {
if [[ $(lsb_release -d) != *16.04* ]]; then
  echo -e "${RED}You are not running Ubuntu 16.04. Installation is cancelled.${NC}"
  exit 1
fi

if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}$0 must be run as root.${NC}"
   exit 1
fi

if [ -n "$(pidof $COIN_DAEMON)" ] || [ -e "$COIN_DAEMOM" ] ; then
  echo -e "${RED}$COIN_NAME is already installed.${NC}"
  exit 1
fi
}

function get_ip() {
  declare -a NODE_IPS
  for ips in $(netstat -i | awk '!/Kernel|Iface|lo/ {print $1," "}')
  do
    NODE_IPS+=($(curl --interface $ips --connect-timeout 2 -s4 icanhazip.com))
  done

  if [ ${#NODE_IPS[@]} -gt 1 ]
    then
      echo -e "${GREEN}More than one IP. Please type 0 to use the first IP, 1 for the second and so on...${NC}"
      INDEX=0
      for ip in "${NODE_IPS[@]}"
      do
        echo ${INDEX} $ip
        let INDEX=${INDEX}+1
      done
      read -e choose_ip
      NODEIP=${NODE_IPS[$choose_ip]}
  else
    NODEIP=${NODE_IPS[0]}
  fi
}

function important_information() {
 echo
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${PURPLE}SpectreSecurityCoin Website. https://www.spectresecurity.io${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${GREEN}$COIN_NAME Masternode is up and running listening on port${NC}${PURPLE}$COIN_PORT${NC}."
 echo -e "${GREEN}Configuration file is:${NC}${RED}$CONFIGFOLDER/$CONFIG_FILE${NC}"
 echo -e "${GREEN}Start:${NC}${RED}systemctl start $COIN_NAME.service${NC}"
 echo -e "${GREEN}Stop:${NC}${RED}systemctl stop $COIN_NAME.service${NC}"
 echo -e "${GREEN}VPS_IP:${NC}${GREEN}$NODEIP:$COIN_PORT${NC}"
 echo -e "${BLUE}================================================================================================================================"
 echo -e "${CYAN}Follow twitter to stay updated.  https://twitter.com/CoinSpectre${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${CYAN}Ensure Node is fully SYNCED with BLOCKCHAIN.${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${GREEN}Usage Commands.${NC}"
 echo -e "${GREEN}SpectreSecurityCoind masternode status${NC}"
 echo -e "${GREEN}SpectreSecurityCoind getinfo.${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${RED}Donations always excepted gratefully.${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 echo -e "${YELLOW}XSPC: SbmP4YU1DkamHMcJkTU3Rv52ZnJrcvg7XP${NC}"
 echo -e "${BLUE}================================================================================================================================${NC}"
 
 }

function setup_node() {
  enable_firewall
  download_bootstrap
  systemctl start $COIN_NAME.service
  important_information
}

##### Main #####
clear

purgeOldInstallation
checks
download_node
setup_node
