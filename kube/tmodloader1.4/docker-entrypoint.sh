cd "$(dirname "$0")"

chmod a+x ./LaunchUtils/ScriptCaller.sh
# forward our parent process id to the child in case ScriptCaller needs to kill the parent to break free of steam's process lifetime tracker (reaper)

PPID=$PPID ./LaunchUtils/ScriptCaller.sh -config serverconfig.txt -server -tmlsavedirectory $DATA_DIR/data -modpath $DATA_DIR/mods -world $DATA_DIR/data/Worlds/WHAL.wld -autocreate 1 -worldname WHAL -seed WHALSeed -difficulty 1
