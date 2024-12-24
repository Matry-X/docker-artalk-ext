FROM artalk/artalk-go:latest

RUN apk update && \
    apk add git unzip wget && \
    apk cache clean

WORKDIR /data

RUN wget -q https://github.com/lionsoul2014/ip2region/raw/master/data/ip2region.xdb && \
    git clone https://github.com/kirklin/go-swd && \
    mv ./go-swd/pkg/dictionary/default ./dict && \
    rm -rf ./go-swd

WORKDIR /

RUN wget -q https://github.com/ZingerLittleBee/server_bee-backend/releases/download/v2.3.0/serverbee-web-x86_64-unknown-linux-musl.zip && \
    unzip serverbee-web-x86_64-unknown-linux-musl.zip && rm serverbee-web-x86_64-unknown-linux-musl.zip && \
    wget -q https://github.com/cloudflare/cloudflared/releases/download/2024.12.2/cloudflared-linux-amd64 && \
    mv cloudflared-linux-amd64 cloudflared

COPY artalk.yml /data
COPY entrypoint.sh .

RUN chmod +x entrypoint.sh serverbee-web cloudflared

EXPOSE 3000

CMD []
ENTRYPOINT [ "./entrypoint.sh" ]