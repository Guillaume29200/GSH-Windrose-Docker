#!/bin/bash
/opt/steam/steamcmd.sh +login anonymous \
+force_install_dir /opt/games/server \
+app_update $GSH_STEAM_APP_ID validate +quit
