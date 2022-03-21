import React, { useEffect, useState } from "react";
import "./App.css";
import Web3 from "web3";
import Transaction from "./contracts/Transaction.json";

const App = () => {
  const [state, setState] = useState({
    web3: null,
    contract: null,
    senderBalance: 0,
    receiverBalance: 0,
    receiverAddress: "",
  });
  useEffect(async () => {
    try {
      const web3 = new Web3("http://127.0.0.1:7545");
      const id = await web3.eth.net.getId();
      const deployedNetwork = Transaction.networks[id];
      const contract = new web3.eth.Contract(
        Transaction.abi,
        deployedNetwork.address
      );
      const address = (await web3.eth.getAccounts())[1];
      const senderBalance = await contract.methods.getBalance(address).call();
      setState({
        ...state,
        web3: web3,
        contract: contract,
        senderBalance: (senderBalance * 10 ** -18).toFixed(3),
      });
    } catch (err) {}
  }, []);
  const sendTransaction = () => {
    const isAddress = state.web3.utils.isAddress(state.receiverAddress);
    if (isAddress) {
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
              let receiverBalance;
              if (isAddress) {
                receiverBalance = await state.contract.methods
                  .getBalance(e.target.value)
                  .call();
              } else {
                receiverBalance = 0;
              }
              setState({
                ...state,
                receiverAddress: e.target.value,
                receiverBalance,
              });
            }}
            value={state.receiverAddress}
          />
          <button
            className="Sender_Send_Button"
            type="submit"
            onClick={sendTransaction}
          >
            Send
          </button>
          <button className="Sender_Refresh_Button" type="submit">
            Refresh
          </button>
        </div>
        <div className="Receiver_Container">
          <h1 className="Receiver_Info_Text">Receiver Info</h1>
          <h2 className="Receiver_Balance">0Eth</h2>
        </div>
      </div>
    </>
  );
};

export default App;
