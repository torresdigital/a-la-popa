#!/bin/bash
## La Popa és Nuestra !
## informand sobre a instalação


#this functio send the error mesage to user if his not use the sudo command
if [ "$(whoami)" != "root" ]
then
  echo
    echo -e " 🔴 use sudo to run this script "
  echo
  exit 1
fi

echo
echo

sleep 2

echo -e "🇪🇸 Este script instalará Sopa Spades en tu PC 🍜 "

echo

sleep 2

echo -e "🇺🇸 This scrip will isntall Sopa Spades on you PC 🍜 "

echo

sleep 2

echo -e "🇧🇷 Este script irá instalar o Sopa Spades em seu PC 🍜 "

echo

sleep 1

echo -e "🇪🇸 Eliminando el directorio antiguo para reinstalar el juego"

echo

sleep 1

echo -e "🇺🇸 Removing the old directory to reinstall the Game"

echo 

sleep 1

echo -ne "🇧🇷 Removendo o antigo diretório para reinstalar o Jogo"

echo
echo 

echo -e " sudo rm -rf /usr/local/share/games/openspades
echo -e " && " 
echo -e " sudo rm -rf /usr/local/share/games/sopaspades "

echo
echo

sudo rm -rf /usr/local/share/games/openspades && 
sudo rm -rf /usr/local/share/games/sopaspades && \

echo
echo

## informando sobre as dependências

sleep 1

echo -e " 🇪🇸 Instalando las dependencias "

echo

sleep 1

echo -e " 🇺🇸 Installing the dependencies "

echo

sleep 1

echo -e " 🇧🇷 Instalando as dependências "

echo
echo

sleep 1

echo " sudo apt-get install "

   echo    " pkg-config libglew-dev"
sleep 1
   echo    " libcurl3-openssl-dev" 
sleep 1
   echo    " libsdl2-dev"
sleep 1
   echo    " libsdl2-image-dev"
sleep 1
   echo    " libalut-dev"
sleep 1
   echo    " xdg-utils libfreetype6-dev"
sleep 1
   echo    " libopus-dev"
sleep 1
   echo    " libopusfile-dev"
sleep 1
   echo    " cmake imagemagick"
sleep 1
   echo    " libjpeg-dev"
sleep 1
   echo    " libxinerama-dev
sleep 1
   echo    " libxft-dev "
sleep 1

echo
echo

sleep 1

 sudo apt-get install pkg-config libglew-dev libcurl3-openssl-dev libsdl2-dev
     libsdl2-image-dev libalut-dev xdg-utils libfreetype6-dev libopus-dev
     libopusfile-dev cmake imagemagick
     libjpeg-dev libxinerama-dev libxft-dev && \

## Clonando os repositórios

sleep 1
echo -e " 🇪🇸 Clonando el repositorio y instalando"
echo
sleep 1
echo -e " 🇺🇸 Cloning the repository and installing"
echo
sleep 1
echo -e " 🇧🇷 Clonando o repositório e instalando"

echo
echo

sleep 1

echo -e " sudo rm -Rf sopaspades && sudo rm -Rf openspades"
echo -e " &&"
echo -e " git clone https://github.com/atorresbr/sopaspades.git && cd sopaspades"

echo
echo

sleep 1

echo
echo

   sudo rm -Rf sopaspades && sudo rm -Rf openspades && \
   git clone https://github.com/atorresbr/sopaspades.git && cd sopaspades && \

echo
echo   

sleep 1
echo -e " 🇪🇸 instalando"
echo
sleep 1
echo -e " 🇺🇸 installing"
echo
sleep 1
echo -e " 🇧🇷 instalando"
echo

echo
echo

sleep 1

echo -e " mkdir sopaspades.mk && cd sopaspades.mk && 
sleep 1
echo -e "cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo && \"
sleep 1
echo -e "make && sudo make install"
sleep 1

echo
echo

   mkdir sopaspades.mk && cd sopaspades.mk && cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo && \
   make && sudo make install && \

echo
echo

sleep 1
echo -e " 🇪🇸 comenzando el Juego"
echo
sleep 1
echo -e " 🇺🇸 starting the Game"
echo
sleep 1
echo -e " 🇧🇷 iniciando o Jogo"
echo

sleep 1

 echo " openspades"

exit

openspades

  echo
  echo

  echo -e " 😘 🇪🇸 Comparte este script Compartilhe este Script ! "
  echo
  sleep 1
  echo -e " 😘 🇺🇸 Share this Script ! "
  echo
  sleep 1
  echo -e " 😘 🇧🇷 Compartilhe este Script ! "
  echo

  echo
  echo

