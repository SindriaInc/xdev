# Xdev

A complete GUI dev environment docker image with all the software you need. 

Visit [GitHub](https://github.com/SindriaInc/xdev) Page.

# Information

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
- GoLand
- Clion
- DataGrip

# Requirements

- Docker CE
- Docker Compose
- Xorg

# Usage

## Configuration

- Setup file env: `cp .env.example .env`
- Setup Docker Compose `cp docker-compose.example.yml docker-compose.yml`

### Without DE
 
- Bootstrap environment: `docker-compose up -d`

### With DE

- Enter in TTY mode: `CTRL + ALT + F3`
- Export a new display: `export DISPLAY=:1`
- Bootstrap environment: `docker-compose up -d`

# License

This software is release open source under [GPL](https://github.com/SindriaInc/xdev/LICENSE) license.