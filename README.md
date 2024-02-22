# 🍜 SOPA SPADES !

## - A Beautiful OpenSpades Client to SOPA Servers (( SOPA‼️ 😋 SOUP !!)) 

![SOPA!](https://repository-images.githubusercontent.com/564385628/bf3842ec-ccf9-44e5-ad6a-2b1a4272909a)


[OpenSpades Website](https://openspades.yvt.jp) — [Community](https://buildandshoot.com)

<!-- **Important**: If you have previously installed OpenSpades or any modified version of OpenSpades, you have to uninstall it manually by `sudo rm -rf /usr/local/share/games/openspades` or `sudo rm -rf /usr/local/share/games/sopaspades` before installing a new one. -->

 ## Limpar e Instalar / Limpiar y instalar / Clean and Install 

🇪🇸 **Importante**: 

Si ya tiene una instalación antigua en su PC con Linux, debe eliminarla usando este comando a continuación. Copie el comando en los dos pequeños cuadrados de la izquierda, péguelo en su terminal con el botón derecho del mouse y presione ENTER.

🇧🇷 **Importante**: 

Se você já tem uma instalação antiga no seu PC com Linux, você precisa remover, usando este comando abaixo. Copie o comando nos dois pequenos quadradinhos à esquerda, e cole no seu terminal com o botão direiro do Mouse, e aperte ENTER.

🇺🇸 **Important**:

 If you have previously installed OpenSpades or any modified version of OpenSpades on you PC. Just copy the comando bellow on the two little squares on left, and use right click to past the command in you terminal and press ENTER.


O Comando / The Command 👇
```
sudo rm -rf /usr/local/share/games/openspades && \
sudo rm -rf /usr/local/share/games/sopaspades
```

## What is this?
synSpades is a modified version of OpenSpades, with changes by Doctor Dank, including a bigger color palette thanks to Liza & other smaller changes such as macros (Totally didn't steal the macros from [this dude](https://www.github.com/yusufcardinal/openspades)).

## How do I use the macros?
Write `/syn_macro_` in chat and it'll essentially explain itself to you. There's currently only a macro for the P key & the Mouse Button 4 & 5 keys.
If someone can, please implement a macro menu where you can set macro keys yourself, as right now you have to add lines to the code to have another bind.

## How to Build/Install?

### On Linux

#### Building and installing from source
GCC 4.9 / Clang 3.2 or later is recommended because OpenSpades relies on C++11 features heavily.

1. Install the following dependencies:

   *On Debian-derived distributions*:
   ```
   sudo apt-get install pkg-config libglew-dev libcurl3-openssl-dev libsdl2-dev \
     libsdl2-image-dev libalut-dev xdg-utils libfreetype6-dev libopus-dev \
     libopusfile-dev cmake imagemagick \
     libjpeg-dev libxinerama-dev libxft-dev
   ```
   
   *On Fedora or other RHEL-derived distributions*:
   ```
   sudo dnf install pkgconf-pkg-config glew-devel openssl-devel libcurl-devel SDL2-devel SDL2_image-devel \
     freealut-devel xdg-utils freetype-devel opus-devel opusfile-devel \
     libjpeg-devel libXinerama-devel libXft-devel cmake ImageMagick
   ```

   *On other distributions*:
   Install corresponding packages from your repository (or compile from source).

2. Clone the synSpades repository:

   ```bash
   git clone https://github.com/c-um/synSpades.git && cd synSpades
   ```

3. Run the following one liner:

   ```
   mkdir synspades.mk && cd synspades.mk && cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo && make
   ```

4. Install synSpades (optional but recommended):

   `sudo make install`

   **Important**: If you have previously installed OpenSpades or any modified version of OpenSpades, you have to uninstall it manually by `sudo rm -rf /usr/local/share/games/openspades` before installing a new one.

5. Launch:

   `openspades` (if installed) or `cd $REPO_DIRECTORY/synspades.mk; bin/OpenSpades` and enjoy


### Windows
Windows is currently not supported, if anyone wants to go through the pain of building it for Windows, you're more than welcome to.
If you have built for Windows please send me it on Discord: synth#0420 (I am going to lose the custom tag soon though)

### macOS
Same goes for Windows. Although I've yet to meet anyone playing OpenSpades or B&S on macOS


### Network usage during building

OpenSpades' build process automatically downloads prebuilt game assets and libraries as needed. Specifically:

- `pak000-Nonfree.pak` and `font-uniform.pak` from <https://github.com/yvt/openspades-paks>. Can be disabled by passing `-D OPENSPADES_NONFREE_RESOURCES=NO` to CMake.
- The prebuilt binaries of YSRSpades (audio engine) from <https://github.com/yvt/openspades-media>. Can be disabled by passing `-D OPENSPADES_YSR=NO` to CMake.

In addition, vcpkg (sort of package manager only used for Windows and macOS builds) [collects and sends telemetry data to Microsoft](https://vcpkg.readthedocs.io/en/latest/about/privacy/). You can opt out of this behavior by passing `-disableMetrics` option when running `vcpkg/bootstrap-vcpkg.sh` command.


## Troubleshooting
Spoiler alert: You're on your own here.


## Licensing
Please see the file named LICENSE.
