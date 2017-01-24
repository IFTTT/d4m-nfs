#!/bin/bash

# check that screen has not already been setup
if ! $(screen -ls |grep d4m > /dev/null 2>&1); then
    echo "[d4m-nfs] Setup 'screen' to work properly with the D4M tty, while at it name it 'd4m'."
    screen -AmdS d4m ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty

    echo "[d4m-nfs] Run Moby VM d4m-nfs setup script."
    screen -S d4m -p 0 -X stuff "/d4m-nfs/d4m-mount-nfs.sh
"

    echo -n "[d4m-nfs] Waiting until d4m-nfs setup is done."
    while [ ! -e /tmp/d4m-done ]; do
        echo -n "."
        sleep .25
    done
    echo ""

    rm /tmp/d4m-done
fi
