import 'package:flutter/material.dart';
import 'package:ngx/screens/homepage.dart';
import 'package:ngx/screens/loginpage.dart';
import 'package:intl/intl.dart';

import 'ConfigHelper.dart';

class Receipt extends StatefulWidget {
  const Receipt({Key? key}) : super(key: key);

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  String? customer_name_value;

  int receiptNo = 10;

  late List<String> customer_names_list = [];

  final TextEditingController _balance_txtcntrl = TextEditingController();

  void _populateDropdown() async {
    final custList = await getList("customer_name");

    setState(() {
      customer_names_list = custList!;
    });
  }

  @override
  initState() {
    super.initState();
    _populateDropdown();

    _balance_txtcntrl.text = "";
  }

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
                      "Receipt",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150,
                            child: Row(
                              children: [
                                Text("Receipt NO:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(receiptNo.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                          ),
                          Container(
                              width: 100,
                              child: Row(
                                children: [
                                  Text("DATE:",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      DateFormat("dd/MM/yyyy")
                                          .format(DateTime.now()),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )),
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Customer Name",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        width: 300,
                        height: 40,
                        child: Container(
                          decoration: const ShapeDecoration(
                              shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.5, style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          )),
                          child: DropdownButtonHideUnderline(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: DropdownButton<String>(
                                  hint: const Text("Customer Name"),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                  value: customer_name_value,
                                  onChanged: (String? value) {
                                    setState(() {
                                      customer_name_value = value ?? "";
                                    });
                                  },
                                  items: customer_names_list
                                      .map<DropdownMenuItem<String>>(
                                          (String customer) {
                                    return DropdownMenuItem<String>(
                                      value: customer,
                                      child: Text(customer),
                                    );
                                  }).toList()),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Balance",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: "Amount",
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(color: Colors.black),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 40,
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
                                        color: Colors.deepOrange),
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
                                        color: Colors.deepOrange),
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
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    child: Text("Existing Receipt",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Text(":",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Container(
                                width: 120,
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Existing Receipt',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(),
                                    ),
                                    style: TextStyle(color: Colors.black),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned.fill(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.deepOrange),
                                        ),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          textStyle: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {},
                                        child: Center(child: const Text('GO')),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.deepOrange),
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.all(5.0),
                                      textStyle: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {},
                                    child: Center(
                                        child: const Text('NEW RECEIPT')),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 90,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.deepOrange),
                                  ),
                                ),
                                TextButton(
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
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.deepOrange),
                                  ),
                                ),
                                TextButton(
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
                                  child:
                                      const Center(child: const Text('HOME')),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.deepOrange),
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                    );
                                  },
                                  child:
                                      const Center(child: const Text('EXIT')),
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
