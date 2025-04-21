#!/bin/bash

# === CONFIGURATION ====================
GAME_USER=$(logname)
APP_ID_ATS="2239530"
APP_ID_ETS="1948160"
# ======================================

# === Highlight function ===============
print_banner() {
  echo ""
  echo -e "\033[1;36m=============================="
  echo -e "$1"
  echo -e "==============================\033[0m"
}
# ======================================

print_banner "ATS/ETS2 Dedicated Server Installer"

echo "Choose the game to install:"
echo "1) American Truck Simulator (ATS)"
echo "2) Euro Truck Simulator 2 (ETS2)"
read -p "Enter 1 or 2: " escolha

if [[ "$escolha" == "1" ]]; then
  JOGO="ats"
  APP_ID="$APP_ID_ATS"
  BASE_DIR="/home/$GAME_USER/ats_server"
elif [[ "$escolha" == "2" ]]; then
  JOGO="ets"
  APP_ID="$APP_ID_ETS"
  BASE_DIR="/home/$GAME_USER/ets_server"
else
  echo -e "\033[1;31mInvalid option. Aborting.\033[0m"
  exit 1
fi

print_banner "Selected game: $JOGO"
echo "Installing as user: $GAME_USER"
echo "Installation path: $BASE_DIR"

# Install dependencies
print_banner "Installing dependencies..."
sudo apt update
sudo apt install -y lib32gcc-s1 curl tar unzip gcc

# Create directories
print_banner "Creating installation directories..."
mkdir -p "$BASE_DIR/steamcmd"
cd "$BASE_DIR"

# Check if SteamCMD is already installed
if [ -f "$BASE_DIR/steamcmd/steamcmd.sh" ]; then
  print_banner "SteamCMD is already installed. Skipping download."
else
  print_banner "Downloading SteamCMD..."
  curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" -o steamcmd.tar.gz
  tar -xzf steamcmd.tar.gz -C "$BASE_DIR/steamcmd"
  rm steamcmd.tar.gz
fi

# Fix directory permissions (if the script was run as root)
sudo chown -R "$GAME_USER":"$GAME_USER" "$BASE_DIR"

# Install the dedicated game server
print_banner "Installing $JOGO dedicated server..."
sudo -u "$GAME_USER" "$BASE_DIR/steamcmd/steamcmd.sh" +force_install_dir "$BASE_DIR/dedicated_server" +login anonymous +app_update "$APP_ID" validate +quit

# Create start script
print_banner "Creating start script..."
cat <<EOF > "$BASE_DIR/start_server.sh"
#!/bin/bash
cd "$BASE_DIR/dedicated_server/bin/linux_x64"
./server_launch.sh
EOF

chmod +x "$BASE_DIR/start_server.sh"

print_banner "✅ $JOGO server installation completed!"
echo -e "\033[1;32mTo start the server, run:\033[0m"
echo "$BASE_DIR/start_server.sh"
