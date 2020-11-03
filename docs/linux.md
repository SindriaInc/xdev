### Without DE

- Setup Xauthority: `xhost +` 

- Bootstrap environment: `docker-compose up -d`

### With DE

- Enter in TTY mode: `CTRL + ALT + F3`

- Export a new display: `export DISPLAY=:1`

- Bootstrap environment: `docker-compose up -d`

# Cloud Gnu/Linux Host 

## Requirements

- Docker CE
- Docker Compose
- X11Forward yes 

## Configuration

- Setup file env: `cp .env.example .env`

- Setup Docker Compose `cp docker-compose.example.yml docker-compose.yml`

- Bootstrap environment: `docker-compose up -d`


# Windows Host

## Requirements

- Docker Desktop For Windows 
- Vcxsrv X Server

## Configuration

- Install Vcxsrv: `choco install vcxsrv` or download from [here](https://netix.dl.sourceforge.net/project/vcxsrv/vcxsrv/1.20.6.0/vcxsrv-64.1.20.6.0.installer.exe)

Then run Xlaunch from the start menu and follow the initial configuration steps:

![vcxsrv1](docs/screenshots/vcxsrv1.png)

![vcxsrv2](docs/screenshots/vcxsrv2.png)

![vcxsrv3](docs/screenshots/vcxsrv3.png)

![vcxsrv4](docs/screenshots/vcxsrv4.png)

Make sure to save to configuration file before you click finish!
Save it to one of the following locations:

- `%appdata%\Xming`
- `%userprofile%\Desktop`
- `%userprofile%`

### Via PowerShell

- Setup Display: `set-variable -name DISPLAY -value <ip-address>:0.0` 

    eg. `set-variable -name DISPLAY -value 192.168.1.100:0.0`

- Setup file env: `cp .env.example .env` (eg. XDEV_DISPLAY=192.168.1.100:0.0)

- Setup Docker Compose `cp docker-compose.windows.yml docker-compose.yml`

- Bootstrap environment: `docker-compose up -d`