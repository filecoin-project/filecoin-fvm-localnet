#!/bin/bash

# Check if NVM is already installed
if [[ -s $HOME/.nvm/nvm.sh  ]]; then
  echo "NVM is already installed."
else
  # Download and install NVM
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

  # Source NVM to start using it
  source $HOME/.nvm/nvm.sh
  nvm install node

  # Verify NVM installation
  nvm --version
fi
cd fillAccounts && npm install
node index.js


