@echo off

echo v0.0.3-0-g6375bc3-master              ^
    > "%SRC_DIR%\TVIPS-TOOLS-VERSION-FILE"
del "%SRC_DIR%\VERSION"

cmake -G "MinGW Makefiles" %CMAKE_ARGS%                               ^
    -DCMAKE_C_FLAGS:STRING="%CFLAGS% -D_POSIX_C_SOURCE=200809L -Wall" ^
    -DCMAKE_COLOR_MAKEFILE:BOOL=OFF                                   ^
    -DCMAKE_CXX_FLAGS:STRING="%CXXFLAGS% -Wall"                       ^
    "%SRC_DIR%"
if errorlevel 1 exit /b 1

cmake --build .
if errorlevel 1 exit /b 1

cmake --build . --target man
if errorlevel 1 exit /b 1

cmake --install . --prefix "%PREFIX%"
if errorlevel 1 exit /b 1

install -D -m 644                      ^
    "%SRC_DIR%\README"                 ^
    "%PREFIX%\share\%PKG_NAME%\README"
if errorlevel 1 exit /b 1
