＃＃＃イーサリアムのコンセンサスプロトコルは、ネットワーク参加者間でトランザクションの正当性とブロックチェーンの整合性を合意するためのルールや手順を定めたものです

import {useState, useEffect} from 'react'
import {ethers} from 'ethers'

const App = () => {
  const [msg, setMsg] = useState("");
  const contractAddress = "0x..."
  const abi = ["function message(string memory message) public"]

  useEffect(() => {
    const msgCatch = (_from, _msg) => {
      console.log("from: ", _from);
      console.log("message: ", _msg);
    };
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(contractAddress, abi, signer);
    const filter = contract.filters.msgEvent(null,null);
    contract.on(filter, msgCatch);
  }, []);

  const doMessage = async () => {
    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const accounts = await provider.send("eth_requestAccounts", []);
    const signer = provider.getSigner();
    const contract = new ethers.Contract(contractAddress, abi, signer);
    contract.message(msg);
  };

  const doChange = (e) => {
    setMsg(e.target.value);
  };

  return (
    <>
      <div>
        <input type="text" onChange={doChange} />
        <a onClick={doMessage}>tweet</a>
      </div>
    <>
  );
};

export default App;
