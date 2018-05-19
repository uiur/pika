FROM lightningnetwork/btcd-alpine

RUN mkdir -p "/shared/rpc" "/root/.btcd" "/root/.btcctl"
RUN touch "/root/.btcd/btcd.conf"

RUN "/go/bin/gencerts" --host="*" --directory="/shared/rpc" --force

VOLUME ["/shared"]

RUN apk add --no-cache bash
COPY ./start-btcd.sh .

ENTRYPOINT ["./start-btcd.sh"]
