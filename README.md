# qopter-build
Scripts and configuration to deploy a qopter

## QOPTER
The QOPTER is a small form-factor field-deployable device running ubuntu 20 that gets shipped to a client location where it is connected to the network for internal testing. The hardware platform is the System76 Meerkat, with the i7 processor, 16GB of RAM and a 240GB SSD.

## Accounts
There is one account on the QOPTER that is used for inbound ssh console connections. That account is pilot.  Pilot is a member of the sudo group and is created during the build process of the qopter. The pilot account on each QOPTER has its own unique password. 

## Initial Setup
NOTE: System76 Meerkat with Ubuntu 20.04 ship with a boot into a GUI, without sshd. Instructions for walking through the setup:
1. Connect a USB keyboard, mouse, and HDMI monitor.
2. At the initial welcome screen click next
3. Specify your keyboard and click next
4. Optionally, select your wifi network, and supply the key.  Click next.
5. On the “privacy” screen click next.
6. On the time zone screen, ensure it is Mountain Time and click next.
7. On the connect your online accounts screen, click skip.
8. On the about screen, specify account username of “pilot” and click next.
9. Supply credentials for the “pilot” account, and click next.
10. Once fully booted, log in as pilot and open a terminal window.


In the terminal window:
~~~
pilot@system76-pc:~$ sudo hostnamectl set-hostname [HOSTNAME]
pilot@system76-pc:~$ sudo apt install git
pilot@system76-pc:~$ git clone https://github.com/weber11/qopter-build
pilot@system76-pc:~$ cd qopter-build
~~~

The setup script will require you to have the following information:
sudo password for the pilot account.
* The address of the QATCHER (50.19.106.107)
* The password for qopter@50.19.106.107
* The hosthame set in the step above.
* The port that will listen locally for ssh connections on the QATCHER 
* The port that will listen locally for ssh connections on the QATCHER 

`pilot@system76-pc:~$ ./setup.sh`

If prompted for wireshark user access, choose “yes”, you wish for unprivileged users to capture packets.

## TAP install:
The script clones the tap github repo and runs setup. There are a number of things that require specific details, so this step is entirely interactive.  Prompts should be answered per the below.
```
Do you want to install TAP? [y/n]: y
Do you want to keep TAP updated? (requires internet) [y/n]: n
Choice 1: Use SSH keys, Choice 2: Use password (1,2)[1]: 1
Enter the remote IP or hostname for SSH connect (remote external server): 50.19.106.107
Enter the PORT to the reverse SSH connect (remote external SSH port)[22]: 22
Enter the LOCAL port that will be on the remote SSH box [10003]: [NEXT AVAILABLE PORT]
Enter the LOCAL port that will be used for the SOCKS HTTP proxy [10004]: [NEXT AVAILABLE PORT+10000]
Enter URL to text file of commands (ex. https://yourwebsite.com/commands.txt): [ENTER]
Enter the username for the REMOTE account to log into the EXTERNAL server: qopter
Enter your password for the remote SSH server: [PASSWORD]
Do you want to log everything? yes or no [yes] yes
What customer are you deploying this to: [HOSTNAME]
Would you like to start TAP now? [y/n]: :y
Do you want to install all PTF modules now? [yes] [no] : no
```
