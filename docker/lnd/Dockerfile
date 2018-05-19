# https://github.com/lightningnetwork/lnd
FROM lightningnetwork/lnd-alpine

RUN apk add --no-cache bash
COPY ./start-lnd.sh .
ENTRYPOINT ["./start-lnd.sh"]
