# docker-nezha-mailserver

## HOW TO USE

### build

```bash
git clone https://github.com/Matry-X/docker-artalk-ext.git#mail-server
cd docker-artalk-ext
docker build -t your-tag .
```

### run

```bash
docker run -d \
  -e CLIENT_HOST='nezha.example.com:443' \
  -e CLIENT_SECRET='dcba****zyxw' \
  -e UUID='xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' \
  -e SERVER_ARRD="frp.example.com" \
  -e SERVER_PORT="6666" \
  -e USER_ID="xxxx" \
  -e USER_TOKEN="xxxx" \
  -e SMTP_PORT_SSL="465" \
  -e SMTP_PORT_TLS="587" \
  -e IMAP_PORT="993" \
  -e TZ="Asia/Shanghai" \
  -e CRON_MIN="*/120" \
  --name "rss-mail-server" \
  your-tag:latest
```

## INSPIRATION

[FreshRSS/FreshRSS](https://github.com/FreshRSS/FreshRSS)  
[stalwartlabs/mail-server](https://github.com/stalwartlabs/mail-server)  
[fatedier/frp](https://github.com/fatedier/frp)  
[nezhahq/agent](https://github.com/nezhahq/agent)  
