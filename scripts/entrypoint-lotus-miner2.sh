#!/usr/bin/env bash
set -e
echo Wait for lotus is ready ...
lotus wait-api
echo Lotus ready. Lets go
echo Sector size: $SECTOR_SIZE
if [ ! -f $LOTUS_MINER_PATH/.init.miner ]; then
    echo Import the genesis miner key ...
    lotus wallet import --as-default $GENESIS_PATH/pre-seal-t01001.key || echo "Already imported"
    export DEFAULT_WALLET=`lotus wallet default`

    echo Init wallets ...
    export OWNER_WALLET=`lotus wallet new bls`
    export WORKER_WALLET=`lotus wallet new bls`

    lotus send --from $DEFAULT_WALLET $OWNER_WALLET 10
    lotus send --from $DEFAULT_WALLET $WORKER_WALLET 10
    
    lotus-miner init --owner=$OWNER_WALLET  --worker=$WORKER_WALLET --sector-size=$SECTOR_SIZE --actor=t01001 --pre-sealed-sectors=$GENESIS_PATH --pre-sealed-metadata=$GENESIS_PATH/pre-seal-t01001.json
    touch $LOTUS_MINER_PATH/.init.miner
    echo Done
fi

echo Starting lotus miner ...
exec lotus-miner run
