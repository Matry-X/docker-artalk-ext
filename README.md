# docker-nezha-linkwarden

## HOW TO USE

### build

```bash
git clone https://github.com/Matry-X/docker-artalk-ext.git#linkwarden
cd docker-artalk-ext
nano .env # or vi .env, edit .env
docker build -t your-tag .
```

### run

```bash
docker run -d \
  -e CLIENT_HOST='nezha.example.com:443' \
  -e CLIENT_SECRET='dcba****zyxw' \
  -e UUID='xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' \
  -e DATABASE_URL="postgresql://postgres:passwrord@postgres:5432/postgres" \
  --env-file .env \
  --name "linkwarden" \
  your-tag:latest
```

## INSPIRATION

[linkwarden/linkwarden](https://github.com/linkwarden/linkwarden)  
[nezhahq/agent](https://github.com/nezhahq/agent)  
