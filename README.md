# docker-nezha-freeshrss

## HOW TO USE

### build

```bash
git clone https://github.com/Matry-X/docker-artalk-ext.git#freshrss
cd docker-artalk-ext
docker build -t your-tag .
```

### run

```bash
docker run -d \
  -e CLIENT_HOST='nezha.example.com:443' \
  -e CLIENT_SECRET='dcba****zyxw' \
  -e UUID='xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' \
  -e TZ="Asia/Shanghai" \
  -e CRON_MIN="*/120" \
  --name "freshrss" \
  your-tag:latest
```

## INSPIRATION

[FreshRSS/FreshRSS](https://github.com/FreshRSS/FreshRSS)  
[nezhahq/agent](https://github.com/nezhahq/agent)  
