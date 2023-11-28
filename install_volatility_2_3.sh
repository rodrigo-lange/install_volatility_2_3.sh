# RODAR COMO ROOT - instalar na pasta /root
cd

# Install system dependencies
sudo apt install -y build-essential git libdistorm3-dev yara libraw1394-11 libcapstone-dev capstone-tool tzdata

# Install pip for Python 2
sudo apt install -y python2 python2.7-dev libpython2-dev
curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py
sudo python2 get-pip.py
sudo python2 -m pip install -U setuptools wheel

# Install Volatility 2 and its Python dependencies
python2 -m pip install -U distorm3 yara pycryptodome pillow openpyxl ujson pytz ipython capstone
sudo python2 -m pip install yara
sudo ln -s /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so /usr/lib/libyara.so

# Baixa a pasta e instala
git clone https://github.com/volatilityfoundation/volatility.git
chmod +x volatility/vol.py
# Executa com Python2
sed -i 's\#!/usr/bin/env python\#!/usr/bin/env python2\g' volatility/vol.py
sudo mv volatility /opt
sudo ln -s /opt/volatility/vol.py /usr/bin/vol2.py
sudo ln -s /opt/volatility/vol.py /usr/bin/volatility2

# Install pip for Python 3
sudo apt install -y python3 python3-dev libpython3-dev python3-pip python3-setuptools python3-wheel

# Install Volatility 3 and its Python dependencies
python3 -m pip install -U distorm3 yara pycryptodome pillow openpyxl ujson pytz ipython capstone
cd /opt
git clone https://github.com/volatilityfoundation/volatility3.git
chmod +x volatility3/vol.py
sudo ln -s /opt/volatility3/vol.py /usr/bin/vol3.py
sudo ln -s /opt/volatility3/vol.py /usr/bin/volatility3
