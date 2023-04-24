import 'package:flutter/material.dart';
import 'package:ngx/screens/homepage.dart';
import 'package:ngx/screens/loginpage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class Retail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: AppBar(
              title: Text(
                "Retail Management System",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              actions: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "RETAIL",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ))
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 140,
                            child: Row(
                              children: [
                                Text("Retail NO:",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text("123456",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                          ),
                          Container(
                              width: 140,
                              child: Row(
                                children: [
                                  Text("DATE:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      DateFormat("dd/MM/yyyy")
                                          .format(DateTime.now()),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                        ]),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Item Name',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'CASH',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(color: Colors.black),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Units:",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Container(
                          width: 200,
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Units',
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(),
                              ),
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ]
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Weight:",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Container(
                          width: 200,
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Weight',
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(),
                              ),
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Rate:",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Container(
                          width: 200,
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Rate',
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(),
                              ),
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Amount:",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        Container(
                          width: 200,
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: '0',
                                labelStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 80,
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: '0',
                                labelStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(),
                              ),
                              style: TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.deepOrange
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.all(10.0),
                                    textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {},
                                  child: Center(child: const Text('Print')),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.deepOrange
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.all(10.0),
                                    textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {},
                                  child: Center(
                                      child: const Text(
                                    'SAVE',
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 120,
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Existing Token ID',
                                  labelStyle: TextStyle(color: Colors.black,fontSize: 12),
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(color: Colors.black),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ),
                          Container(
                            width: 45,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.deepOrange
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {},
                                      child: Center(child: const Text('GO')),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.deepOrange
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.all(8.0),
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {},
                                      child:
                                          Center(child: const Text('NEW RETAIL')),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.deepOrange
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                      );
                                    },
                                    child: Center(child: const Text('LOGOUT')),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.deepOrange
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Homepage()),
                                      );
                                    },
                                    child: Center(child: const Text('HOME')),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.deepOrange
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.all(10.0),
                                      textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                      );
                                    },
                                    child: Center(child: const Text('EXIT')),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
