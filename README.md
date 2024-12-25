# docker-artalk-ext

## CONTAINER

1. artalk with keyword filtering, ip2region
2. nezha agent

## HOW TO USE

### build

```bash
git clone https://github.com/Matry-X/docker-artalk-ext.git
cd docker-artalk-ext
docker build -t your-tag .
```

### run

```bash
docker run -d \
  -e CLIENT_HOST='nezha.example.com:443' \
  -e CLIENT_SECRET='dcba****zyxw' \
  -e UUID='xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' \
  -e APP_KEY='abcd****wxyz' \
  -e SITE_DEFAULT='Default Artalk' \
  -e SITE_URL='artalk.example.com' \
  -e PG_NAME='database' \
  -e PG_HOST='pgsql.example.com' \
  -e PG_PORT='12345' \
  -e PG_USER='user' \
  -e PG_PASSWORD='my-password' \
  -e ADMIN_EMAIL='admin@example.com' \
  -e ADMIN_PASSWORD='$2a$10$pGBH****iucW' \ # Bcrypt
  --name "artalk-ext" \
  your-tag:latest
```

## INSPIRATION

[ArtalkJS/Artalk](https://github.com/ArtalkJS/Artalk)  
[lionsoul2014/ip2region](https://github.com/lionsoul2014/ip2region)  
[kirklin/go-swd](https://github.com/kirklin/go-swd)  
[nezhahq/agent](https://github.com/nezhahq/agent)  
