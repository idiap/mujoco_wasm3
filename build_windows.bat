rem This script requires that the Emscripten SDK has been set up in the directory above this one.
rem Follow the instructions here: https://emscripten.org/docs/getting_started/downloads.html

rmdir /s /q build
call ../emsdk/emsdk activate latest
mkdir build
cd build
call emcmake cmake ..
cd ..
call python src/parse_mjxmacro.py build/_deps/mujoco-src
cd build
call emmake make
cd ../dist
pause