FROM lightningnetwork/btcd-alpine

RUN mkdir -p "/root/.btcd"

RUN apk add --no-cache bash
COPY ./btcd.conf /root/.btcd/btcd.conf
COPY ./start-btcd.sh .

ENTRYPOINT ["./start-btcd.sh"]
