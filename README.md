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
"ext:<filename>.dat:<scope>"
```

### Example
```json
{
  "type": "field",
  "domain": [
    "ext:custom.dat:custom"
  ],
  "network": "TCP,UDP",
  "balancerTag": "Balancer"
}
```

Replace:
- `<filename>` with your actual file name
- `<scope>` with your desired routing scope
