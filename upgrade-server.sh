#!/bin/bash

server_url=$1
echo $server_url

if [[ ! -n "$server_url" ]]; then
  echo "Server URL argument not passed."
  exit 1
fi

mkdir -p ~/Downloads/upgrade-terraria
cd ~/Downloads/upgrade-terraria

curl -O $server_url

if [[ $? != 0 ]]; then
  echo "Unable to download zip"
  exit 1
fi

zip_name=${server_url##*/}
src_dir=/opt/
srv_dir=/srv/
tmp_name="terraria.server.tmp"

echo "${tmp_name}.zip" $tmp_name
rm -f "${tmp_name}.zip" $tmp_name
mv ${zip_name} "${tmp_name}.zip"

unzip -o "${tmp_name}.zip" -d $tmp_name

versioned_dir_name=$(ls -d terraria.server.tmp/* | tr ' ' '\n' | tail -n 1)

echo $versioned_dir_name


<<TEST
  228  sudo curl -O https://terraria.org/system/dedicated_servers/archives/000/000/037/original/terraria-server-1403.zip?1590018631
  229  ls -al
  230  mv 'terraria-server-1403.zip?1590018631' terraria-server-1403.zip
  231  lwd
  232  ls
  233  ls -al
  234  rm -rf terraria.bkp/
  235  mv terraria terraria.bkp
  236  sudo unzip terraria-server-1402.zip
  237  pwd
  238  ls
  239  sudo unzip terraria-server-1403.zip
  240  ls -al
  241  ls -al 1403
  242  ls -al 1403/Linux/
  243  ls -al 1401
  244  mv 1403/Linux/ terraria
  245  cd terraria
  246  history
  247  ls -al
  248  cp ../terraria.bkp/serverconfig.txt ./
  249  ls -al
  250  ls -al ../
  251  ls -al ../terraria.bkp/
  252  history | grep chmod
  253  sudo chmod +x TerrariaServer.bin.x86_64
  254  ls -al
  255  history
  256  sudo systemctl start terraria
  257  sudo systemctl status terraria
  258  ls
  259  pwd
  260  ?
  261  help
  262  ls
  263  ASD
  264  ls -a
  265  history
TEST
