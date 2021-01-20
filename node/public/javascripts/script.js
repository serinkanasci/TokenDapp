const Web3 = require('web3');
const web3SocketProvider = new Web3.providers.WebsocketProvider('ws://127.0.0.1:7546');
const web3Obj = new Web3(web3Provider);

async function getAccounts() {
  let accounts = await web3Obj.eth.getAccounts();
  return accounts;
}

console.log(getAccounts());
