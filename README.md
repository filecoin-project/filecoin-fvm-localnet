# Filecoin FVM Localnet
A complete filecoin lotus and boost docker image to spin up a localnet for smart contract development.

This works on both ARM64 (e.g. Macbook M1/M2s) and AMD64 (e.g. x86 Linux / Windows / MacOS).


## Install
Ensure you have [docker installed](https://docs.docker.com/get-docker/). Clone this repository:

```sh
git clone https://github.com/hammertoe/filecoin-fvm-localnet.git
```

Then run Docker compose up:

```sh
cd filecoin-fvm-localnet
docker compose up
```

The first time this runs, it will need to download about 5GB of initial data to start the network. Then local information is stored in `data/`. 

It will take a while to start up and will display a number of errors in the process.

Once started you will be able to get to the Boost UI at: `http://localhost:8080`
