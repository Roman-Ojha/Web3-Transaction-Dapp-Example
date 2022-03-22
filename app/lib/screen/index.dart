import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tran-Dapp"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(3, 32, 60, 1),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 300,
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
                    const Text(
                      "0 Eth",
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
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
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100.0,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Amount in Wei",
                              contentPadding: EdgeInsets.only(left: 10.0),
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
                      onPressed: () {},
                      child: const Text(
                        "Send",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 300,
                height: 150,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(99, 97, 102, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      "Receiver Info",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "0 Eth",
                      style: TextStyle(
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
      ),
    );
  }
}
