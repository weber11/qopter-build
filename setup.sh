# QOPTER Build script
# 
# built for Ubuntu 20.04
#

echo "**** INSTALLING UPDATES ****"

sudo apt update
sudo apt install openssh-server python2 curl locate python3-pip
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py
sudo apt reinstall python3-pip

echo "**** DONE WITH APT ****"

scp -T 'qopter@50.19.106.107:Nessus* ptf*' ./

echo "**** INSTALLING NESSUS ****"
sudo dpkg -i Nessus*
cd ../

echo "**** INSTALLING PTF ****"
git clone https://github.com/trustedsec/ptf
cp qopter-build/ptf_custom_list.txt ./ptf/modules/custom_list/list.txt
cd ptf
sudo ./ptf <<EOF
use modules/custom_list/list/install_update_all
yes
EOF
cd ../
sudo pip3 install pycryptodome
git clone https://github.com/trustedsec/tap
cd tap
sudo ./setup.py

echo "If you didn't get some disastrous error, we should be done. Nessus should be started, but it needs final setup (username and license key).  Tap should have launched... if not, stop the tap service, kill the process manually and restart."
