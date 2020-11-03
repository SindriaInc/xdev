# Xdev

A complete GUI dev workstation environment docker image with all the software you need.

![xdev](docs/screenshots/w3.png)

## Information

With xdev you can run linux workstation everywhere you have docker daemon ready out of the box with the following contents:

- Fedora 31
- Oh My Zsh
- Docker
- Docker Compose
- Telegram Desktop
- Firefox Developer
- Terminator
- Flux
- Sublime Text
- Mysql WorkBench
- PhpStorm
- PyCharm
- IntelliJ Idea
- WebStorm
- RubyMine
- GoLand
- Clion
- DataGrip
- I3 WM

## Requirements

- Docker CE
- Docker Compose
- Xorg

## Setup

- Goto under deployment folder
- Setup file env: `cp .env.example .env`
- Setup Docker Compose `cp docker-compose.example.yml docker-compose.yml`
- Run: `docker-compose up -d`

# License

This software is release open source under [GPL](https://github.com/SindriaInc/xdev/blob/master/LICENSE) license.