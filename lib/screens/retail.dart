import 'package:flutter/material.dart';
import 'package:ngx/screens/homepage.dart';
import 'package:ngx/screens/loginpage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'ConfigHelper.dart';

class Retail extends StatefulWidget {
  const Retail({Key? key}) : super(key: key);

  @override
  State<Retail> createState() => _RetailState();
}

class _RetailState extends State<Retail> {
  String? item_name_value;
  String? payment_type_value;

  int tokenNo = 0;

  late List<String> item_name_list = [];
  late List<String> payment_type_list = [];

  final TextEditingController _units = TextEditingController();
  final TextEditingController _wt = TextEditingController();
  final TextEditingController _rate = TextEditingController();
  final TextEditingController _amt = TextEditingController();

  void _populateDropdown() async {
    final itemlist = await getList("item_name");
    final custList = await getList("customer_name");
    custList?.insert(0, "--- Cash ---");

    setState(() {
      item_name_list = itemlist!;
      payment_type_list = custList!;
    });
  }

  @override
  initState() {
    super.initState();
    _populateDropdown();

    _units.text = "";
    _wt.text = "";
    _amt.text = "";
    _rate.text = "";
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
                                  hint: const Text("Item Name"),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                  value: item_name_value,
                                  onChanged: (String? value) {
                                    setState(() {
                                      item_name_value = value ?? "";
                                    });
                                  },
                                  items: item_name_list
                                      .map<DropdownMenuItem<String>>(
                                          (String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList()),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ITEM NAME ##########

                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: SizedBox(
                        width: 300,
                        height: 40,
                        child: Container(
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.5, style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          )),
                          child: DropdownButtonHideUnderline(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: DropdownButton<String>(
                                  hint: Text("Payment Type"),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                  value: payment_type_value,
                                  onChanged: (String? value) {
                                    setState(() {
                                      payment_type_value = value ?? "";
                                    });
                                  },
                                  items: payment_type_list
                                      .map<DropdownMenuItem<String>>(
                                          (String paytypes) {
                                    return DropdownMenuItem<String>(
                                      value: paytypes,
                                      child: Text(paytypes),
                                    );
                                  }).toList()),
                            ),
                          ),
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
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        Container(
                          width: 200,
                          child: SizedBox(
                            width: 100,
                            height: 30,
                            child: TextField(
                                controller: _units,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Units',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                  contentPadding: EdgeInsets.all(5),
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(color: Colors.black),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ]),
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
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        Container(
                          width: 200,
                          child: SizedBox(
                            width: 100,
                            height: 30,
                            child: TextField(
                                controller: _wt,
                                onChanged: (txt) {
                                  int wt = 0;
                                  if (txt.isNotEmpty && txt != "") {
                                    wt = int.parse(txt);
                                  }

                                  setState(() {
                                    int rt = 0;
                                    if (_rate.text.isNotEmpty) {
                                      rt = int.parse(_rate.text);
                                    }

                                    _amt.text = (wt * rt).toString();
                                  });
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Weight',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                  contentPadding: EdgeInsets.all(5),
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(color: Colors.black),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ]),
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
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        Container(
                          width: 200,
                          child: SizedBox(
                            width: 100,
                            height: 30,
                            child: TextField(
                                controller: _rate,
                                obscureText: false,
                                onChanged: (txt) {
                                  int rt = 0;

                                  if (txt != "" || txt.isNotEmpty) {
                                    rt = int.parse(txt);
                                  }

                                  setState(() {
                                    int wt = 0;
                                    if (_wt.text.isNotEmpty) {
                                      wt = int.parse(_wt.text);
                                    }

                                    _amt.text = (rt * wt).toString();
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Rate',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                  contentPadding: EdgeInsets.all(5),
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(color: Colors.black),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ]),
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
                                fontSize: 12, fontWeight: FontWeight.bold)),
                        Container(
                          width: 200,
                          child: SizedBox(
                            width: 100,
                            height: 30,
                            child: TextField(
                              enabled: false,
                              controller: _amt,
                              obscureText: false,
                              decoration: InputDecoration(
                                //labelText: 'Amount',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 12),
                                //contentPadding: EdgeInsets.all(5),
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
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 12),
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
                                          color: Colors.deepOrange),
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
                                          color: Colors.deepOrange),
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
                                      child: Center(
                                          child: const Text('NEW RETAIL')),
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
                                        color: Colors.deepOrange),
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
                                        color: Colors.deepOrange),
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
                                        color: Colors.deepOrange),
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
