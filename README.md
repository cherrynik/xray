[![Build and Deploy](https://github.com/cherrynik/xray/actions/workflows/main.yml/badge.svg)](https://github.com/cherrynik/xray/actions/workflows/main.yml)

# Installation and Configuration Guide

## Installation Steps

1. Copy your compiled file to the x-ui binary directory:
   ```bash
   sudo cp your-file /usr/local/x-ui/bin/
   ```

2. Verify file permissions:
   ```bash
   ls -alr /usr/local/x-ui/bin/
   ```

3. If needed, set the correct file permissions:
   ```bash
   sudo chown <user>:<uid> /usr/local/x-ui/bin/your-file
   ```

## Configuration

In your routing settings, use the following format:
```json
"ext:geosite.dat:general"
```

### Example
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

Replace:
- `<filename>` with your actual file name
- `<scope>` with your desired routing scope

https://github.com/Skrill0/AntiFilter-Domains
https://github.com/Skrill0/AntiFilter-IP
