#!/usr/bin/env bash

cd "$(dirname "$0")"

chmod a+x ./LaunchUtils/ScriptCaller.sh

echo "Starting Terraria Server..."
screen -S Terraria -L -Logfile ${DATA_DIR}/masterLog.0 -d -m ./LaunchUtils/ScriptCaller.sh -config serverconfig.txt -server -tmlsavedirectory $DATA_DIR/data -modpath $DATA_DIR/mods $@ &

sleep 2
tail -f ${DATA_DIR}/masterLog.0
