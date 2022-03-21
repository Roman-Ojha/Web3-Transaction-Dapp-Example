import React, { useEffect } from "react";
import "./App.css";
import Web3 from "web3";

const App = () => {
  useEffect(() => {
    // const provider = new Web3.providers.HttpProvider("http://127.0.0.1:7545");
    // const web3 = new Web3(provider);
    // console.log(web3);
  }, []);
  return (
    <>
      <div className="Page_Container">
        <div className="Sender_Container">
          <h1 className="Sender_Info_Text">Sender Info</h1>
          <h2 className="Sender_Balance">0Eth</h2>
          <h2 className="Send_Ether_Text">Send Ether</h2>
          <input type="text" placeholder="Receiver Address" />
          <button className="Sender_Send_Button" type="submit">
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
