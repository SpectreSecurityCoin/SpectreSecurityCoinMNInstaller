![Coin-Logo](http://media.spectresecurity.io/images/spectre/SpectreSecurityCoin-256.png)
# SpectreSecurityCoin Masternode Setup Guide (Ubuntu 16.04)
This guide will assist you in setting up a SpectreSecurityCoin Masternode on a Linux Server running Ubuntu 16.04. (Use at your own risk)

If you require further assistance contact the support team @ [Discord](https://discord.io/SpectreSecurityCoin)
***
## Requirements
1) **25,000 SpectreSecurityCoin.**
2) **A Vultr VPS running Linux Ubuntu 16.04.**
3) **A Windows local wallet.**
4) **An SSH client such as [Bitvise](https://dl.bitvise.com/BvSshClient-Inst.exe)**
***
## Contents
* **Section A**: Creating the VPS within [Vultr](https://www.vultr.com/).
* **Section B**: Downloading and installing Bitvise.
* **Section C**: Connecting to the VPS and installing the MN script via Bitvise.
* **Section D**: Preparing the local wallet.
* **Section E**: Connecting & Starting the masternode.
***

## Section A: Creating the VPS within [Vultr](https://www.vultr.com/) 
***Step 1***
* Register at [Vultr](https://www.vultr.com/)
***

***Step 2***
* After you have added funds to your account go [here](https://my.vultr.com/deploy/) to create your Server
***

***Step 3*** 
* Choose a server location (preferably somewhere close to you)
![Location](https://i.imgur.com/kQ5vKEV.png)
***

***Step 4***
* Choose a server type: Ubuntu 16.04
![OS](https://i.imgur.com/aSMqHUK.png)
***

***Step 5***
* Choose a server size: $5/mo will be fine 
![OS](https://i.imgur.com/UoGoHcM.png)
***

***Step 6*** 
* Set a Server Hostname & Label (name it whatever you want)
![Hostname](https://i.imgur.com/uu0rvOr.png)
***

***Step 7***
* Click "Deploy now"

![Deploy](https://i.imgur.com/4qpYuH0.png)
***


## Section B: Downloading and installing BitVise. 

***Step 1***
* Download Bitvise [here](https://dl.bitvise.com/BvSshClient-Inst.exe)
***

***Step 2***
* Select the correct installer depending upon your operating system. Then follow the install instructions. 

![Bitvise-Installer](https://i.imgur.com/yF3694G.png)
***


## Section C: Connecting to the VPS & Installing the MN script via Bitvise.

***Step 1***
* Copy your VPS IP (you can find this by going to the server tab within Vultr and clicking on your server. 
![Vultr](https://i.imgur.com/q3KvEr8.png)
***

***Step 2***
* Open the bitvise application and fill in the "Hostname" box with the IP of your VPS.
![Bitvise-Installer](https://i.imgur.com/PI3w6bB.png)
***

***Step 3***
* Copy the root password from the VULTR server page.
![RootPass](https://i.imgur.com/8LfD93h.png)
***

***Step 4***
* Type "root" as the login/username.
![Root](https://i.imgur.com/brzKtOn.png)
***

***Step 5*** 
* Paste the password into the Bitvise terminal by right clicking (it will not show the password so just press enter)
![RootPassEnter](https://i.imgur.com/ENwnIWh.png)
***

***Step 6*** 
* Once you have clicked open it will open a security alert (click yes).  
***

***Step 7***
* Paste the code below into the Bitvise terminal then press enter (it will just go to a new line)
![RootPassEnter](https://i.imgur.com/K6xlnav.png)

`wget -q https://raw.githubusercontent.com/SpectreSecurityCoin/SpectreSecurityCoinMNInstaller/master/mn_setup.sh`
***

***Step 8***
* Paste the code below into the Bitvise terminal then press enter

`bash mn_setup.sh`

![Bash](https://i.imgur.com/myvmKTE.png)

***

***Step 9***
* Sit back and wait for the install (this will take 10-20 mins)
***

***Step 10***
* When prompted to enter your Gen key - press enter

![installing](https://i.imgur.com/sLvWd1S.png)
***

***Step 11***
* You will now see all of the relavant information for your server.
* Keep this terminal open as we will need the info for the wallet setup.
![installing](https://i.imgur.com/Q87LcnW.png)
***

## Section D: Preparing the Local wallet

***Step 1***
* Download and install the SpectreSecurityCoin wallet [here](https://github.com/SpectreSecurityCoin/SpectreSecurityCoin/releases)
***

***Step 2***
* Send EXACLY 25,000 XSPC to a receive address within your wallet.
***

***Step 3***
* Create a text document to temporarily store information that you will need. 
***

***step 4***
* Go to the console within the wallet 

![console](https://i.imgur.com/2H8BHZw.png)
***

***Step 5***
* Type the commands below and press enter

`masternode genkey`

![Masternode-genkey](https://i.imgur.com/WplwoJh.png)

`masternode outputs` 

![Masternode-outputs](https://i.imgur.com/GD7Ro1m.png)
***

***Step 6***
* Copy your Masternode Genkey.
* Copy the long key (this is your transaction ID) and the 1 or 2 at the end (this is your output index)
* Paste these into the text document you created earlier as you will need them in the next step.
***

# Section E: Connecting & Starting the masternode 

***Step 1***
* Now Click on the Masternodes Tab, Click my masternodes and Click on create
![Create](https://i.imgur.com/5VXwhs3.png)
***

***Step 2***

* Fill in the form. 
* For `Alias` type something like "MN01" **don't use spaces**
* The `Address` is the IP and port of your server (this will be in the Bitvise terminal that you still have open).
* The `PrivKey` is your masternode Gen key (This is also in the Bitvise terminal that you have open).
* The `TxHash` is the transaction ID/long key that you copied to the text file.
* The `Output Index` is the 0 or 1 that you copied to your text file.
* The `Reward Address` You can leave Blank.
* The `Reward %` You can leave this Blank. 

Click "Ok"
***

***Step 3***
* Close out of the wallet and reopen Wallet
*Click on the Masternodes tab "My masternodes"
* Click update than start all in the masternodes tab
***

***step 4***
* Check the status of your masternode within the VPS by using the command below:

`SpectreSecurityCoind masternode status`


`SpectreSecurityCoind getinfo`

*You should see ***status 9***

If you do, congratulations! You have now setup a masternode. If you do not, please contact support and they will assist you.  
***


