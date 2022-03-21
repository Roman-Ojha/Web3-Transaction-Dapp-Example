const dotenv = require("dotenv");
const path = require("path");
dotenv.config({ path: "../.env" });
const Web3 = require("web3");
const MyContract = require("./contracts/Transaction.json");
const express = require("express");
const app = express();
const router = express.Router();
const address = process.env.ADDRESS;
const private_key = process.env.PRIVATE_KEY;
const port = process.env.PORT;

const init = async () => {
  const web3 = new Web3("http://127.0.0.1:7545");
  const id = await web3.eth.net.getId();
  const deployedNetwork = MyContract.networks[id];
  const contractAddress = deployedNetwork.address;
  const contract = new web3.eth.Contract(MyContract.abi, contractAddress);
};
init();

app.listen(port, () => {
  console.log(`server is running on ${port}`);
});
