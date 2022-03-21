const dotenv = require("dotenv");
const path = require("path");
dotenv.config({ path: "../.env" });
const Web3 = require("web3");
const MyContract = require("./contracts/Transaction.json");
const address = process.env.ADDRESS;
const private_key = process.env.PRIVATE_KEY;

const init = async () => {
  const web3 = new Web3("http://127.0.0.1:7545");
  const id = await web3.eth.net.getId();
  const deployedNetwork = MyContract.networks[id];
  const contractAddress = deployedNetwork.address;
  const contract = new web3.eth.Contract(MyContract.abi, contractAddress);
};

init();
