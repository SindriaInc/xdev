# Xdev

Xdev is the first cloud native distro made for developers.

You can run Xdev everywhere you have docker daemon running.

For more info please follow the documentation [here](docs/main.md).

---

## Demo

Demo link: [http://demo-xdev.sindria.org:8080](http://demo-xdev.sindria.org:8080)

Password: `sindria`

---

Web Mode

![xdev](docs/screenshots/web.png)

Legacy Mode

![xdev](docs/screenshots/legacy.png)

## Use case

- Cloud environment on docker node or k8s cluster.
- Local environment using Docker Desktop on Windows/OSX.
- Local environment on Gnu/Linux host without X11.
- Testing environment for clean run and destroy any software such as DE, WM and stuff like that.

## Tutorial

- Move terminal to workspace 3: `ALT + SHIFT + 3`

- Open browser on workspace 1: `ALT + D` -> type: firefox-developer -> `ENTER`

- Move to workspace 2: `ALT + 2`

- Open PhpStorm: `ALT + D` -> type: phpstorm -> `ENTER`

- Move to workspace 3: `ALT + 3`

- Close window: `ALT + SHIFT + Q`

## Information

With xdev you have complete linux workstation ready out of the box with the following contents:

- Terminator
- Oh My Zsh
- Flux
- Git Sindria
- Tmate
- Asciinema
- Pandoc
- Docker
- Docker Compose
- Kubectl
- Lens
- Telegram Desktop
- Discord
- Firefox Developer
- Google Chrome
- Sublime Text
- Visual Studio Code
- Mysql WorkBench
- DataGrip
- PhpStorm
- PyCharm
- IntelliJ Idea
- WebStorm
- RubyMine
- GoLand
- Clion

## Requirements

- Docker CE
- Docker Compose

## Setup

[comment]: <> (### Quick install)

[comment]: <> (- Run: `docker-compose -f https://raw.githubusercontent.com/SindriaInc/xdev/master/deployment/docker-compose.example.yml --env-file https://raw.githubusercontent.com/SindriaInc/xdev/master/deployment/.env.example up -d`)

### Standard install

- On your host make a directory: `mkdir -p xdev-example`
- Move into it: `cd xdev-example`
- Go to under deployments [folder](https://github.com/SindriaInc/xdev/tree/master/deployments)
- Setup file env: `cp .env.example .env`
- Setup Docker Compose `cp docker-compose.example.yml docker-compose.yml`
- Run: `docker-compose up -d`

N.B. If you got an error check out others deployments mode, such as host mode and subnet mode.

# License

This software is release open source under [GPL](https://github.com/SindriaInc/xdev/blob/master/LICENSE) license.