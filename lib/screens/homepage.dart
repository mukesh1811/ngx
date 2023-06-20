import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ngx/screens/DB_Helper.dart';
import 'package:ngx/screens/SettingsLogin.dart';
import 'package:ngx/screens/balance.dart';
import 'package:ngx/screens/loginpage.dart';
import 'package:ngx/screens/receipt.dart';
import 'package:ngx/screens/retail.dart';
import 'package:ngx/screens/token.dart';

import 'lotnumber.dart';

class Homepage extends StatelessWidget {

  static const platform = MethodChannel('ngx.print.channel');
  Future<void> _print(String printContent) async {

    var arguments = {
      'print_content' : printContent
    };

    try {
      final int result = await platform.invokeMethod('printContent', arguments);
    } on PlatformException catch (e) {
      print("ERROR: '${e.message}'.");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const Positioned.fill(
        child: Image(
          image: AssetImage("images/veg1.jpg"),
          colorBlendMode: BlendMode.softLight,
          fit: BoxFit.fill,
          opacity: AlwaysStoppedAnimation(.5),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(children: [
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.deepOrange,
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Retail Management System",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                    Text("Home",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Container(
                  width: 130,
                  height: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.deepOrange),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(20.0),
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Token()),
                            );
                          },
                          child: Center(child: const Text('TOKEN')),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 130,
                  height: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.deepOrange),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(20.0),
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Receipt()),
                            );
                          },
                          child: Center(child: const Text('RECEIPT')),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Container(
                  width: 130,
                  height: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.deepOrange),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(20.0),
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          // onPressed: () async {
                          //   print("item wise reports \t dialogue");
                          //   print("\n");
                          //   print( await DB_Helper.item_report_token());
                          // },
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AlertDialog(actions: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton( //token button
                                            onPressed: () async
                                            {
                                              var res = await DB_Helper.item_report_token();
                                              print(res);
                                              _print(res);
                                            },
                                            child: Text("Token")
                                        ),
                                        ElevatedButton( //retail button
                                            onPressed: () async
                                            {
                                              var res = await DB_Helper.item_report_retail();
                                              print(res);
                                              _print(res);
                                            },
                                            child: Text("Retail")
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ]),
                            );
                          },
                          child: Center(
                              child: const Text(
                            'ITEM WISE REPORT',
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 130,
                  height: 90,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.deepOrange),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(20.0),
                            textStyle: const TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Balance()),
                            );
                          },
                          child: Center(
                              child: const Text(
                            'CUSTOMER BALANCE',
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 130,
                    height: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.deepOrange),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(20.0),
                              textStyle: const TextStyle(fontSize: 15),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Retail()),
                              );
                            },
                            child: Center(
                                child: const Text(
                              'RETAIL',
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 130,
                    height: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.deepOrange),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(20.0),
                              textStyle: const TextStyle(fontSize: 15),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Lotnumber()),
                              );
                            },
                            child: Center(
                                child: const Text(
                              'LOT NUMBER',
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 250,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFFff0000),
                                    Color(0xFFff0000),
                                    Color(0xFFff0000),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(10.0),
                              textStyle: const TextStyle(fontSize: 15),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: Center(
                                child: const Text(
                              'LOGOUT',
                              textAlign: TextAlign.center,
                            )),
                          ),
                          IconButton(onPressed: null, icon: Icon(Icons.logout)),
                        ],
                      ),
                    ),
                  ),

                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsLogin()),
                        );
                      },
                      icon: Icon(
                        Icons.storage,
                        color: Colors.deepOrange,
                        size: 36,
                      ))

                  // IconButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => const Settings()),
                  //       );
                  //     },
                  //     icon: Icon(
                  //       Icons.storage,
                  //       color: Colors.deepOrange,
                  //       size: 36,
                  //     ))
                ],
              ),
            ]),
          ),
        ),
      )
    ]);
  }
}
