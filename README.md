# X-Ray GeoSite Generator

[![Build and Deploy](https://github.com/cherrynik/xray/actions/workflows/main.yml/badge.svg)](https://github.com/cherrynik/xray/actions/workflows/main.yml)

This project automatically generates and deploys geosite.dat files for X-UI using GitHub Actions.

## Setup Instructions

1. Fork this repository to your GitHub account

2. Set up a self-hosted GitHub Actions runner on your server:
   - Go to your repository settings
   - Navigate to Actions > Runners
   - Click "New self-hosted runner"
   - Follow the instructions to install and configure the runner on your server

3. The runner will automatically:
   - Build the geosite.dat file from your input lists
   - Deploy it to `/usr/local/x-ui/bin/`
   - Restart the x-ui service

## Configuration

In your X-UI routing settings, use the following format:
```json
"ext:geosite.dat:general"
```

### Example Configuration
```json
{
  "type": "field",
  "domain": [
    "ext:geosite.dat:general"
  ],
  "network": "TCP,UDP",
  "balancerTag": "Balancer"
}
```

## Input Files

Place your domain lists in the `input` directory. The generator supports:
- Domain lists (one per line)
- Comments (lines starting with #)
- Multiple files (each will be processed separately)

## Sources

Code sourced from:
- [AntiFilter-Domains](https://github.com/Skrill0/AntiFilter-Domains)
- [AntiFilter-IP](https://github.com/Skrill0/AntiFilter-IP)

