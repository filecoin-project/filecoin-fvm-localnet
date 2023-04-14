# Filecoin FVM localnet

Filecoin FVM Localnet is a complete Filecoin [Lotus](https://lotus.filecoin.io/) and [Boost](https://boost.filecoin.io/) Docker image that allows you to spin up a localnet for FVM smart contract development.


## System requirements

ARM64 (e.g. Macbook M1/M2s) or AMD64 (e.g. x86 Linux / Windows / MacOS).

## Prerequisites

Ensure you have [Docker installed](https://docs.docker.com/get-docker/). 

## Installation

1. Clone this repository:

    ```sh
    git clone https://github.com/hammertoe/filecoin-fvm-localnet.git
    ```

1. Navigate to the repository:

    ```sh
    cd filecoin-fvm-localnet
    ```

1. Run Docker `compose up`:

    ```sh
    docker compose up
    ```

Once the localnet is started, you can navigate the Boost UI at: `http://localhost:8080`. 

## Usage notes

- The first time the localnet runs, it will need to download ~5GB of initial data to start the network. After this, local information is stored in `data/`. 

- The localnet will take a while to start up and will display a number of errors in the process.

