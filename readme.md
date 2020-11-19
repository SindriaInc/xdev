# Xdev

A complete GUI dev workstation environment docker image with all the software you need.

![xdev](docs/screenshots/w3.png)

## Information

With xdev you can run linux workstation everywhere you have docker daemon ready out of the box with the following contents:

- Fedora 32
- Oh My Zsh
- Git Sindria
- Tmate
- Asciinema
- Pandoc
- Docker
- Docker Compose
- Kubectl
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

- Go to under deployment folder
- Setup file env: `cp .env.example .env`
- Setup Docker Compose `cp docker-compose.example.yml docker-compose.yml`
- Run: `docker-compose up -d`

# License

This software is release open source under [GPL](https://github.com/SindriaInc/xdev/blob/master/LICENSE) license.