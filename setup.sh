# QOPTER Build script
# 
# built for Ubuntu 20.04
#
sudo apt update all
sudo apt install openssh-server python2 curl locate git
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py
scp qopter@50.19.106.107:Nessus* ./
scp qopter@50.19.106.107:ptf* ./
git clone https://github.com/trustedsec/ptf
cp ptf_custom_list.txt ./ptf/modules/custom_list/list.txt
sudo ./ptf/ptf <<EOF
use modules/custom_list/list/install_update_all
yes
EOF
sudo dpkg -i Nessus*
git clone https://github.com/trustedsec/tap
sudo ./tap/setup.py

echo "If you didn't get some disastrous error, we should be done. Nessus should be started, but it needs final setup (username and license key).  Tap should have launched... if not, stop the tap service, kill the process manually and restart."
