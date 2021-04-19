# QOPTER Build script
# 
# built for Ubuntu 20.04
#

A="PT09PT09PT09PT09PT09PS0tKy0tPT09PT09PT09PT09PT09PT0KICAgICAgICAgICAgICAgICB+fH4gICAgICAgICAgICAgICAgICAgICAgICAsLX5+LS4KICAgICAgICAgX19fXy9+fn5+fn5+PT09PT09LT0gICAgICAgICAgICAgIDogIC9+PiA6CiAgICAgICAvJ35+fHx+fCB8PT0gPT0gfC0tIH4tX19fX19fX19fX19fX19fXy8gIC8KICAgICBfL198X198fF98IHx8X3x8X3x8ICAgICBVIFMgQVJNWSAgICAgICAgICA8CiAgICgtK3wgICAgfCAgICB8X19fX19ffCAgICAgX19fLS0tLS1gYGBgYGBgXF9fXAogICAgYC0rLl9fX19fIF9fX19fX19fX19fIF8tfgogICB+LV9fX19fX19ffHxfX19fX19fX19ffHxfX19fXw"
B="Jy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tJwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8fCAgICAgICAgICAgICAgICAgICAgCiAgICAgICAgICAgICAgICAgICAgICAgICBfX19fX1lZX19fX18KICAgICAgICAgICAgICAgICAgICAgICAuJ0BAQEBAQEBAQEBAQCcuCiAgICAgICAgICAgICAgICAgICAgICAvLy8gICAgIHx8ICAgICBcXFwKICAgICAgICAgICAgICAgICAgICAgLy8vICAgICAgfHwgICAgICBcXFwKICAgICAgICAgICAgICAgICAgICAgfHwgIF9fXyAgfHwgIF9PXyAgfHwKICAgICAgICAgICAuLV8tLiAgICAgfHwgfCAgIHwgfHwgfHwgfHwgICAgIC4tXy0uCiAgICAgICAgIC4nZCh4KWInLiAgIHxBJy5fWV98X3x8X3xfWV8uJ0F8ICAgLidkKHgpYicuCiAgICAgICAgIHwoeClPKHgpfC0tLXxAQEBAQEBAQEBAQEBAQEBAQEB8LS0tfCh4KU8oeCl8CiAgICAgICAgIHwoeClPKHgpfD09PXxAQEBAQEBAQHh4eEBAQEBAQEB8PT09fCh4KU8oeCl8CiAgICAgICAgICcuZyh4KVAuJyAgICd8Z0BAQEBAeHgleHhAQEBAcHwnICAgJy5nKHgpUC4nCiAgICAgICAgICAgJy0tLScgICAgICAgJy5nQEBAQHh4eEBAQEBwJyAgICAgICAnLS0tJwogICAgICAgICAgICAgICAgICAgICAgPT09Jy5nQEBAQEBAQHAuJz09PQogICAgICAgICAgICAgICAgICAgICAvLyAgICAgXFhfb19YLyAgICAgXFwKICAgICAgICAgICAgICAgICAgICAoXykgICAgICAgICAgICAgICAgIChfKQ=="
C=($A $B)
i=$[ ($RANDOM % 2) ]
base64 -d <<<"${C[$i]}"
echo ""
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
