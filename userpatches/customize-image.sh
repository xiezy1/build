#!/bin/bash
set -e

echo "[Armbian Custom] Installing dependencies..."
apt-get update
apt-get install -y git build-essential cmake pkg-config yasm \
                   libdrm-dev libx264-dev libvpx-dev

# ---- Build libmpp ----
echo "[Armbian Custom] Building Rockchip libmpp..."
cd /usr/local/src
git clone --depth=1 https://github.com/rockchip-linux/mpp
cd mpp
mkdir build && cd build
cmake ..
make -j$(nproc)
make install

# ---- Build ffmpeg-rockchip ----
echo "[Armbian Custom] Building ffmpeg-rockchip..."
cd /usr/local/src
git clone --depth=1 https://github.com/rockchip-linux/ffmpeg -b release/4.4
cd ffmpeg
./configure --enable-rkmpp --enable-libdrm --enable-gpl \
            --enable-libx264 --enable-libvpx --prefix=/usr/local
make -j$(nproc)
make install


# # ---- Build Rockchip RGA ----
# echo "[Armbian Custom] Building Rockchip RGA..."
# cd /usr/local/src
# git clone --depth=1 https://github.com/rockchip-linux/rga.git
# cd rga
# mkdir build && cd build
# cmake ..
# make -j$(nproc)
# make install

ldconfig
