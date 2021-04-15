# QOPTER Build script
# 
# built for Ubuntu 20.04
#
sudo apt update
sudo apt install openssh-server python2 curl locate python3-pip
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py
scp -T 'qopter@50.19.106.107:Nessus* ptf*' ./
cd ../
git clone https://github.com/trustedsec/ptf
cp qopter-build/ptf_custom_list.txt ./ptf/modules/custom_list/list.txt
cd ptf
sudo ./ptf <<EOF
use modules/custom_list/list/install_update_all
yes
EOF
sudo dpkg -i Nessus*
cd ../
sudo pip3 install pcryptodome
git clone https://github.com/trustedsec/tap
cd tap
sudo ./setup.py

echo "If you didn't get some disastrous error, we should be done. Nessus should be started, but it needs final setup (username and license key).  Tap should have launched... if not, stop the tap service, kill the process manually and restart."
