require('dotenv').config()
const child_process = require('child_process');
const { ethers } = require('ethers')
const lotusEvemStat = child_process.exec(`lotus`)
const mnemonic = ethers.Mnemonic.fromPhrase(process.env.MNEMONIC);

for (let index = 0; index < 10; index++) {
  //const  account = hdNode.derivePath(`m/44'/60'/0'/0/${index}`);
  const wallet = ethers.HDNodeWallet.fromMnemonic(mnemonic, `m/44'/60'/0'/0/${index}`)
  const stat = child_process.exec(`lotus evm stat ${wallet.address}`)
  stat.stdout.on('data', (data) => {
    const addReg= /t410f\w+/
    const addr = data.match(addReg)
    if (addr) {
      child_process.exec(`lotus send ${addr[0]} 1000`)
    }


  })
  stat.stderr.on('data', (data) => {
    console.log('stderr:data', data)
  })
  stat.on('error', (error) => {
    console.log('error', error)
  })
  stat.on('close', (close) => {
    console.log('close', close)
  })
}
