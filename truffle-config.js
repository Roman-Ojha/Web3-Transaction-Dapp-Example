const dotenv = require("dotenv").config();
const HDWalletProvider = require("@truffle/hdwallet-provider");
const path = require("path");
const private_key = process.env.PRIVATE_KEY;

module.exports = {
  contracts_build_directory: path.join(__dirname, "app/src/contracts"),
  // after build the contract copy and past to all the client and server that need the abi code
  networks: {
    development: {
      // host: "127.0.0.1",
      host: "192.168.10.101",
      port: 7545,
      // provider: () =>
      //   new HDWalletProvider(private_key, "http://127.0.0.1:7545"),
      // private key the key of one account from ganache
      // here we are providing the provider while deploying the smart contract
      network_id: "*",
    },
  },
  mocha: {},
  compilers: {
    solc: {
      version: "0.8.12",
    },
  },
};
