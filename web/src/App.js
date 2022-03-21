import React from "react";
import "./App.css";

const App = () => {
  return (
    <>
      <div className="Page_Container">
        <div className="Sender_Container">
          <h1 className="Sender_Info_Text">Sender Info</h1>
          <hr />
          <h2 className="Sender_Balance">0Eth</h2>
          <h2 className="Send_Ether_Text">Send Ether</h2>
          <input type="text" placeholder="Receiver Address" />
          <button type="submit">Send</button>
          <button type="submit">Refresh</button>
        </div>
        <div className="Receiver_Container">
          <h1 className="Receiver_Info_Text">Receiver Info</h1>
          <hr />
          <h2 className="Receiver_Balance">0Eth</h2>
        </div>
      </div>
    </>
  );
};

export default App;
