#!/usr/bin/env bash
cd "$(dirname "$0")"

chmod a+x ./LaunchUtils/ScriptCaller.sh

screen -S Terraria -L -Logfile ${DATA_DIR}/masterLog.0 -d -m ./LaunchUtils/ScriptCaller.sh -config serverconfig.txt -server -tmlsavedirectory $DATA_DIR/data -modpath $DATA_DIR/mods -world $DATA_DIR/data/Worlds/WHAL.wld -autocreate 1 -worldname WHAL -seed WHALSeed -difficulty 1 &

sleep 2
tail -f ${DATA_DIR}/masterLog.0
