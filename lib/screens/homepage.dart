import 'package:flutter/material.dart';
import 'package:ngx/screens/loginpage.dart';
import 'package:ngx/screens/token.dart';
import 'package:ngx/screens/receipt.dart';
import 'package:ngx/screens/retail.dart';
import 'package:ngx/screens/balance.dart';
import 'package:ngx/screens/settings.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
                    Text("HOME",
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage()),
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
                            MaterialPageRoute(builder: (context) => Retail()),
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
                              builder: (context) => const Settings()),
                        );
                      },
                      icon: Icon(
                        Icons.storage,
                        color: Colors.deepOrange,
                        size: 36,
                      ))
                ],
              ),
            ]),
          ),
        ),
      )
    ]);
  }
}
