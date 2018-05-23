FROM lightningnetwork/btcd-alpine

RUN mkdir -p "/btcd_rpc" "/root/.btcd" "/root/.btcctl"
RUN touch "/root/.btcd/btcd.conf"

RUN "/go/bin/gencerts" --host="*" --directory="/btcd_rpc" --force

VOLUME ["/btcd_rpc"]

RUN apk add --no-cache bash
COPY ./start-btcd.sh .

ENTRYPOINT ["./start-btcd.sh"]
