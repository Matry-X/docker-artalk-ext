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
  --name "mail-server" \
  your-tag:latest
```

## INSPIRATION

[stalwartlabs/mail-server](https://github.com/stalwartlabs/mail-server)  
[fatedier/frp](https://github.com/fatedier/frp)  
[nezhahq/agent](https://github.com/nezhahq/agent)  
