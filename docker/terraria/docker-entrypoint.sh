#!/usr/bin/env bash

cd "$(dirname "$0")"


# Update Mods
if [ -d "${DATA_DIR}/steam" ]; then
  # Check for an install.txt file in the mods folder
  if [ -f "${DATA_DIR}/steam/install.txt" ]; then
    # Check if any mods have been uninstalled, remove any that are not in the install.txt file
    for mod in $(ls ${DATA_DIR}/steam/steamapps/workshop/content/1281930); do
      if ! grep -q $mod "${DATA_DIR}/steam/install.txt"; then
        echo "Removing mod: $mod"
        rm -rf "${DATA_DIR}/steam/steamapps/workshop/content/1281930/$mod"
      fi
    done

    # Read the file and install mods using steamcmd
    cmd="steamcmd +force_install_dir /${DATA_DIR}/steam +login anonymous"
    for mod in $(cat "${DATA_DIR}/steam/install.txt"); do
      cmd+=" +workshop_download_item 1281930 $mod"
    done
    cmd+=" +quit"
    echo "Installing mods..."
    $cmd
  fi

  enabled=""
  # Copy each mod from steamapps folder to the mods folder
  for mod in $(find "${DATA_DIR}/steam/steamapps/workshop/content/1281930" -type d -name "*" -mindepth 1 -maxdepth 1); do
    pushd $mod
    # Get first folder sorted by date
    mod_folder=$(ls -ad [^a-zA-Z]* | sort -t'.' -k1,1nr -k2,2nr | head -n 1)
    cp $mod_folder/* ${DATA_DIR}/mods

    # Keep track of enabled mods
    enabled+="$(ls $mod_folder/*.tmod | xargs -n 1 basename | sed 's/.tmod//') "
    echo "Enabled mods: $enabled"
    popd
  done

  # Create enabled.json file with only echo to avoid using jq since we don't have it in the image
  pushd ${DATA_DIR}/mods
  echo "[" > enabled.json
  for mod in $enabled; do
    echo "Enabling mod: $mod"
    echo "  \"${mod%.*}\"," >> enabled.json
  done
  # Remove last comma
  sed -i '$s/,$//' enabled.json
  echo "]" >> enabled.json
  popd
fi

chmod a+x ./LaunchUtils/ScriptCaller.sh

echo "Starting Terraria Server..."
screen -S Terraria -L -Logfile ${DATA_DIR}/masterLog.0 -d -m ./LaunchUtils/ScriptCaller.sh -config serverconfig.txt -server -tmlsavedirectory $DATA_DIR/data -modpath $DATA_DIR/mods $@ &

sleep 2
tail -f ${DATA_DIR}/masterLog.0
