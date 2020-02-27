# Xdev

A complete GUI dev environment docker image with all software you needed.

# Usage

## Configuration

- Setup file env: `cp .env.example .env`
- Setup Docker Compose `cp docker-compose.example.yml docker-compose.yml`

## Without DE
 
- Bootstrap environment: `docker-compose up -d`

### With DE

- Enter in TTY mode: `CTRL + ALT + F3`
- Export a new display: `export DISPLAY=:1`
- Bootstrap environment: `docker-compose up -d`