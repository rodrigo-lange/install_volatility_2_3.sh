# Script to install LMG (https://github.com/halpomeranz/lmg/blob/master/INSTALL):
apt install linux-headers-$(uname -r) linux-image-$(uname -r)-dbg dwarfdump
wget https://github.com/halpomeranz/lmg/raw/master/lmg
chmod +x ./lmg
mkdir avml
cd avml
wget -O avml-$(uname -m) https://github.com/microsoft/avml/releases/download/v0.13.0/avml
wget -O avml-convert-$(uname -m) https://github.com/microsoft/avml/releases/download/v0.13.0/avml-convert
chmod +x *
cd ..
git clone https://github.com/504ensicsLabs/LiME.git
cd LiME/src
wget https://raw.githubusercontent.com/halpomeranz/lmg/master/lime-Makefile.patch
patch < lime-Makefile.patch
cd ../..
wget https://github.com/halpomeranz/lmg/raw/master/static-dwarfdump.tgz
tar zxf static-dwarfdump.tgz
git clone https://github.com/volatilityfoundation/volatility.git
echo 'MODULE_LICENSE("GPL");' >> volatility/tools/linux/module.c
