# RODAR COMO ROOT - instalar na pasta /root
cd /root

echo '=========================================='
echo ' Install system dependencies'
echo '=========================================='
sudo apt update
sudo apt install -y build-essential git libdistorm3-dev yara libraw1394-11 libcapstone-dev capstone-tool tzdata dwarfdump linux-headers-$(uname -r)

echo '=========================================='
echo ' Install pip for Python 2'
echo '=========================================='
sudo apt install -y python2 python2.7-dev libpython2-dev
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py
sudo python2 -m pip install -U setuptools wheel

echo '=========================================='
echo ' Install Volatility 2 and its Python dependencies'
echo '=========================================='
python2 -m pip install -U distorm3 yara pycryptodome pillow openpyxl ujson pytz ipython capstone
sudo python2 -m pip install yara
sudo ln -s /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so /usr/lib/libyara.so

echo '=========================================='
echo ' Clone Volatility 2'
echo '=========================================='
git clone https://github.com/volatilityfoundation/volatility.git
chmod +x volatility/vol.py
# Executa com Python2
sed -i 's\#!/usr/bin/env python\#!/usr/bin/env python2\g' volatility/vol.py
sudo mv volatility /opt
sudo ln -s /opt/volatility/vol.py /usr/bin/vol2.py
sudo ln -s /opt/volatility/vol.py /usr/bin/volatility2

echo '=========================================='
echo ' Install pip for Python 3'
echo '=========================================='
sudo apt install -y python3 python3-dev libpython3-dev python3-pip python3-setuptools python3-wheel

echo '=========================================='
echo ' Install Volatility 3 and its Python dependencies'
echo '=========================================='
python3 -m pip install -U distorm3 yara pycryptodome pillow openpyxl ujson pytz ipython capstone
cd /opt
git clone https://github.com/volatilityfoundation/volatility3.git
chmod +x volatility3/vol.py
sudo ln -s /opt/volatility3/vol.py /usr/bin/vol3.py
sudo ln -s /opt/volatility3/vol.py /usr/bin/volatility3

echo '=========================================='
echo ' Install Volatility 3 Symbol Tables Packs for Windows, Linux and MacOS'
echo '=========================================='
cd /opt/volatility3/volatility3/symbols
wget https://downloads.volatilityfoundation.org/volatility3/symbols/windows.zip
wget https://downloads.volatilityfoundation.org/volatility3/symbols/mac.zip
wget https://downloads.volatilityfoundation.org/volatility3/symbols/linux.zip

echo '=========================================='
echo ' Create Volatility 2 profile'
echo '=========================================='
cd /opt/volatility/tools/linux/
# Gambiarra pois o arquivo module.c não tem a licença definida
# fonte: https://github.com/volatilityfoundation/volatility/issues/807
echo 'MODULE_LICENSE("GPL");' >> /opt/volatility/tools/linux/module.c
# Build the profile 
# make -C /lib/modules/$(uname -r)/build/ CONFIG_DEBUG_INFO=y M=$PWD modules
make
# dwarfdump -di ./module.o > ~/dwarf
# zip Debian-$(uname -r).zip module.dwarf /boot/System.map-$(uname -r)
zip $(lsb_release -i -s)_$(uname -r)_profile.zip ./module.dwarf /boot/System.map-$(uname -r)
# Copy the new profile
cp $(lsb_release -i -s)_*.zip /opt/volatility/volatility/plugins/overlays/linux/.


echo '=========================================='
echo ' Volatility 2 and 3 installed'
echo '=========================================='
