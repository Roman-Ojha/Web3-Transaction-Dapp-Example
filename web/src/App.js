import React, { useEffect, useState } from "react";
import "./App.css";
import Web3 from "web3";
import Transaction from "./contracts/Transaction.json";

const App = () => {
  const [state, setState] = useState({
    web3: null,
    contract: null,
    senderBalance: 0,
    senderAddress: "",
    receiverBalance: 0,
    receiverAddress: "",
    amount: "",
  });
  const updateBalance = async () => {
    const senderBalance = await state.contract.methods
      .getBalance(state.senderAddress)
      .call();
    const receiverBalance = await state.contract.methods
      .getBalance(state.receiverAddress)
      .call();
    setState({
      ...state,
      senderBalance: (senderBalance * 10 ** -18).toFixed(3),
      receiverBalance: (receiverBalance * 10 ** -18).toFixed(3),
    });
  };
  useEffect(async () => {
    try {
      const web3 = new Web3("http://127.0.0.1:7545");
      const id = await web3.eth.net.getId();
      const deployedNetwork = Transaction.networks[id];
      const contractAddress = deployedNetwork.address;
      const contract = new web3.eth.Contract(Transaction.abi, contractAddress);
      const senderAddress = (await web3.eth.getAccounts())[1];
      const senderBalance = await contract.methods
        .getBalance(senderAddress)
        .call();
      setState({
        ...state,
        web3: web3,
        contract: contract,
        senderBalance: (senderBalance * 10 ** -18).toFixed(3),
        senderAddress,
      });
    } catch (err) {}
  }, []);
  const sendTransaction = async () => {
    try {
      const isAddress = state.web3.utils.isAddress(state.receiverAddress);
      const amount = state.amount;
      if (!parseInt(amount)) {
        window.alert("Please enter Number");
      } else {
        if (isAddress) {
          await state.web3.eth.sendTransaction({
            from: state.senderAddress,
            to: state.receiverAddress,
            value: amount,
          });
          updateBalance();
        } else {
          window.alert("Address is Invalid");
        }
      }
    } catch (err) {
      console.log(err);
    }
  };
  return (
    <>
      <div className="Page_Container">
        <div className="Sender_Container">
          <h1 className="Sender_Info_Text">Sender Info</h1>
          <h2 className="Sender_Balance">{state.senderBalance}Eth</h2>
          <h2 className="Send_Ether_Text">Send Ether</h2>
          <input
            type="text"
            placeholder="Receiver Address"
            onChange={async (e) => {
              const isAddress = state.web3.utils.isAddress(e.target.value);
              if (isAddress) {
                setState({
                  ...state,
                  receiverAddress: e.target.value,
                  receiverBalance: (
                    (await state.contract.methods
                      .getBalance(e.target.value)
                      .call()) *
                    10 ** -18
                  ).toFixed(3),
                });
              } else {
                setState({
                  ...state,
                  receiverAddress: e.target.value,
                  receiverBalance: 0,
                });
              }
            }}
            value={state.receiverAddress}
          />
          <div className="Amount_Of_Ether_Container">
            <input
              type="text"
              placeholder="Amount in Wei"
              value={state.amount}
              onChange={(e) => {
                setState({
                  ...state,
                  amount: e.target.value,
                });
              }}
            />
            <p>{"< = 1 Eth"}</p>
          </div>
          <button
            className="Sender_Send_Button"
            type="submit"
            onClick={sendTransaction}
          >
            Send
          </button>
        </div>
        <div className="Receiver_Container">
          <h1 className="Receiver_Info_Text">Receiver Info</h1>
          <h2 className="Receiver_Balance">{state.receiverBalance} Eth</h2>
        </div>
      </div>
    </>
  );
};

export default App;
