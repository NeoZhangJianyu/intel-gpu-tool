echo "This tool helps install Intel client GPU driver in Ubuntu by one click"
echo "If you run it in private network, please check the proxy and no_proxy in ENV variables"
echo " "

echo "download intel-graphics.key ..."
wget -qO - https://repositories.intel.com/gpu/intel-graphics.key | \
  sudo gpg --yes --dearmor --output /usr/share/keyrings/intel-graphics.gpg

echo "update apt source list ..."
echo "deb [arch=amd64,i386 signed-by=/usr/share/keyrings/intel-graphics.gpg] https://repositories.intel.com/gpu/ubuntu jammy unified" | \
  sudo tee /etc/apt/sources.list.d/intel-gpu-jammy.list

echo "apt update ..."
sudo apt update

echo "install driver packages ..."
sudo apt-get install -y libze-intel-gpu1 libze1 intel-opencl-icd clinfo
sudo apt-get install -y libze-dev intel-ocloc
sudo apt-get install -y intel-level-zero-gpu-raytracing

echo "check device ..."
clinfo | grep "Device Name"

echo "add user in render group ..."
sudo gpasswd -a ${USER} render
newgrp render