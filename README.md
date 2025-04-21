# 🚚 ATS/ETS2 Dedicated Server Installer

This repository provides a **Bash script** that automates the installation of a dedicated server for:

- 🛣️ American Truck Simulator (ATS)
- 🛤️ Euro Truck Simulator 2 (ETS2)

It installs **SteamCMD**, downloads the dedicated server files, creates the necessary directories, and generates a launch script.

---

## 📥 How to Use

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/ats-ets2-server-installer.git
cd ats-ets2-server-installer
```

### 2. Make the Script Executable

```bash
chmod +x install_ats_ets_server.sh
```

### 3. Run the Installer

```bash
./install_ats_ets_server.sh
```

You will be prompted to choose:
- `1` for **American Truck Simulator**
- `2` for **Euro Truck Simulator 2**

The script will:
- Install required dependencies
- Download SteamCMD
- Install the dedicated server
- Create a launch script at:  
  `/home/your-user/ats_server/start_server.sh` or `/home/your-user/ets_server/start_server.sh`

---

## ⚙️ Configuration

Once installed, you need to **configure your server** before running it.

### 1. Locate `server_config.sii`

The configuration file will be located at:

```bash
/home/your-user/ats_server/dedicated_server/server_config.sii
```

or

```bash
/home/your-user/ets_server/dedicated_server/server_config.sii
```

### 2. Edit the Configuration File

Use your favorite text editor:

```bash
nano ~/ats_server/dedicated_server/server_config.sii
```

Typical fields to customize:

```sii
SiiNunit
{
server_config : _nameless.123 {
  server_name: "My Truck Server"
  welcome_message: "Welcome to our server!"
  password: ""
  max_players: 8
  ...
}
}
```

- `server_name`: the name displayed on the server list
- `password`: leave empty for a public server
- `max_players`: number of allowed players

### 3. Port Forwarding (Router/Firewall)

Make sure the following ports are open:

| Protocol | Port  | Description              |
|----------|-------|--------------------------|
| UDP      | 27015 | Game data                |
| TCP/UDP  | 27016 | Steam server browser     |

---

## ▶️ Starting the Server

After configuration:

```bash
~/ats_server/start_server.sh
```

Or for ETS2:

```bash
~/ets_server/start_server.sh
```

You should see the dedicated server console open. The server is now live and players can connect!

---

## 🧪 Notes

- Tested on **Ubuntu 20.04+**
- Run the script with a **non-root user**
- Script supports **installation and update detection**

---

## 📜 License

This project is licensed under the MIT License.
