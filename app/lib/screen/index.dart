import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:web_socket_channel/io.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _senderBalance = 0;
  double _receiverBalance = 0;
  final String _senderAddress = "0x156b6c9D84118E80D70f0AEe5FA8Cb58c76956FC";
  // ganache sender address
  final String _receiverAddress = "0x95B6C683A3a7DBD9bee9D47f01FB7f6f6155AdB9";
  // ganache receiver address

  final String _rpcUrl = "http://192.168.10.101:7545";
  final String _wsUrl = "http://192.168.10.101:7545";
  final String _privateKey =
      "640322cb2cf80ce96c34ba2e3dbd3c2e6cc593b926974242e5ee3393708b0056";
  // ganache sender privatekey

  late Web3Client _web3;
  late String _abiCode;
  late EthereumAddress _contractAddress;
  late EthereumAddress _ownAddress;
  late DeployedContract _contract;
  late Credentials _credentials;

  late ContractFunction _getBalance;

  @override
  void initState() {
    super.initState();
    initialSetup();
  }

  Future<void> initialSetup() async {
    _web3 = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getDeployedContract();
    await getCredentials();
    BigInt senderBalance = await getBalance(_senderAddress);
    BigInt receiverBalance = await getBalance(_receiverAddress);
    setState(() {
      _senderBalance = (senderBalance / BigInt.from(1000000000000000000));
      _receiverBalance = (receiverBalance / BigInt.from(1000000000000000000));
    });
  }

  Future<void> getAbi() async {
    try {
      String abiStringFile =
          await rootBundle.loadString("src/contracts/Transaction.json");
      var jsonAbi = jsonDecode(abiStringFile);
      _abiCode = jsonEncode(jsonAbi["abi"]);
      _contractAddress =
          EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    } catch (err) {
      //
    }
  }

  Future<void> getDeployedContract() async {
    try {
      _contract = DeployedContract(
          ContractAbi.fromJson(_abiCode, "Transaction"), _contractAddress);
      _getBalance = _contract.function("getBalance");
    } catch (err) {
      //
    }
  }

  Future<BigInt> getBalance(String address) async {
    BigInt balance = BigInt.from(0);
    try {
      EthereumAddress _address = EthereumAddress.fromHex(address);
      // print(address);
      List<dynamic> balanceList = await _web3
          .call(contract: _contract, function: _getBalance, params: [_address]);

      balance = balanceList[0];
    } catch (err) {
      // print(err);
    }
    return balance;
  }

  Future<void> getCredentials() async {
    try {
      _credentials = await EthPrivateKey.fromHex(_privateKey);
      _ownAddress = await _credentials.extractAddress();
    } catch (err) {}
  }

  Future<void> sendTransaction(
      {required String address, required int amount}) async {
    try {
      EtherAmount _amount = EtherAmount.fromUnitAndValue(EtherUnit.wei, amount);
      Transaction transaction = Transaction(
        from: EthereumAddress.fromHex(_senderAddress),
        to: EthereumAddress.fromHex(_receiverAddress),
        value: _amount,
      );
      var res = await _web3.sendTransaction(_credentials, transaction);
    } catch (err) {
      // print(err);
    }
  }

  Future<void> updateBalance() async {
    try {
      BigInt senderBalance = await getBalance(_senderAddress);
      BigInt receiverBalance = await getBalance(_receiverAddress);
      setState(() {
        _senderBalance = (senderBalance / BigInt.from(1000000000000000000));
        _receiverBalance = (receiverBalance / BigInt.from(1000000000000000000));
      });
    } catch (err) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tran-Dapp"),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Color.fromRGBO(3, 32, 60, 1)),
        child: ListView(
          children: [
            const SizedBox(
              height: 40.0,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),
              height: 350,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(99, 97, 102, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Sender Info",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  Text(
                    "${_senderBalance} Eth",
                    style: const TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                  const Text(
                    "Send Ether",
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                  SizedBox(
                    width: 250.0,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Receiver Address",
                        contentPadding: EdgeInsets.only(left: 10.0),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 150.0,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Amount in Wei",
                            contentPadding: EdgeInsets.only(left: 10.0),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      const Text(
                        "< = 1 Eth",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  TextButton(
                    onPressed: () async {
                      await sendTransaction(
                          address: "0x95B6C683A3a7DBD9bee9D47f01FB7f6f6155AdB9",
                          amount: 100000000000000000);
                      await updateBalance();
                    },
                    child: const Text(
                      "Send",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(52, 52, 177, 1),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),
              height: 150,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(99, 97, 102, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Receiver Info",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${_receiverBalance} Eth",
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
