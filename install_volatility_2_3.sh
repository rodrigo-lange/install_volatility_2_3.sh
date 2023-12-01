# RODAR COMO ROOT - instalar na pasta /root
cd /root

echo '=========================================='
echo ' Install system dependencies'
echo '=========================================='
apt update
apt autoremove -y
apt install -y build-essential git libdistorm3-dev yara libraw1394-11 libcapstone-dev capstone-tool tzdata dwarfdump linux-headers-$(uname -r) dwarf2json linux-image-$(uname -r)-dbg

echo '=========================================='
echo ' Install pip for Python 2'
echo '=========================================='
apt install -y python2 python2.7-dev libpython2-dev
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
python2 get-pip.py
python2 -m pip install -U setuptools wheel

echo '=========================================='
echo ' Install Volatility 2 and its Python dependencies'
echo '=========================================='
python2 -m pip install -U distorm3 yara pycrypto pycryptodome pillow openpyxl ujson pytz ipython capstone
#python2 -m pip install yara
ln -s /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so /usr/lib/libyara.so
git clone https://github.com/volatilityfoundation/volatility.git
mv volatility /opt/.
cd /opt/volatility
python2 setup.py build
python2 setup.py install
mv /usr/local/bin/vol.py /usr/local/bin/vol2.py
cd /root
#chmod +x /opt/volatility/vol.py
## Para executar diretamente pelo Python2
#sed -i 's\#!/usr/bin/env python\#!/usr/bin/env python2\' /opt/volatility/vol.py
## Renomeia vol.py para vol2.py para diferenciar versão 2 e 3
#mv /opt/volatility/vol.py /opt/volatility/vol.py
## Cria link
#ln -s /opt/volatility/vol.py /usr/bin/vol2.py 

echo '=========================================='
echo ' Install pip for Python 3'
echo '=========================================='
apt install -y python3 python3-dev libpython3-dev python3-pip python3-setuptools python3-wheel

echo '=========================================='
echo ' Install Volatility 3 and its Python dependencies'
echo '=========================================='
python3 -m pip install -U distorm3 yara pycryptodome pillow openpyxl ujson pytz ipython capstone
git clone https://github.com/volatilityfoundation/volatility3.git
mv volatility3 /opt/.
cd /opt/volatility3
python3 setup.py build
python3 setup.py install
ln -s /opt/volatility3/vol.py /usr/bin/vol3.py

echo '=========================================='
echo ' Create Volatility 2 profile'
echo '=========================================='
cd /opt/volatility/tools/linux/
# Gambiarra pois o arquivo module.c não tem a licença definida
# fonte: https://github.com/volatilityfoundation/volatility/issues/807
echo 'MODULE_LICENSE("GPL");' >> module.c
# Build the profile 
make
zip $(lsb_release -i -s)_$(uname -r)_profile.zip ./module.dwarf /usr/lib/debug/boot/System.map-$(uname -r)
# Copy the new profile
cp $(lsb_release -i -s)_*.zip /opt/volatility/volatility/plugins/linux/.

echo '=========================================='
echo ' Install Volatility 3 Symbol Tables Packs for Windows, Linux and MacOS'
echo '=========================================='
cd /opt/volatility3/volatility3/symbols
wget https://downloads.volatilityfoundation.org/volatility3/symbols/windows.zip
wget https://downloads.volatilityfoundation.org/volatility3/symbols/mac.zip
wget https://downloads.volatilityfoundation.org/volatility3/symbols/linux.zip

echo '=========================================='
echo ' Volatility 2 and 3 installed'
echo '=========================================='
