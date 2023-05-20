import 'package:flutter/material.dart';
import 'package:ngx/screens/homepage.dart';
import 'package:ngx/screens/loginpage.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:ngx/screens/ConfigHelper.dart';

class Token extends StatefulWidget {
  @override
  State<Token> createState() => _TokenState();
}

class _TokenState extends State<Token> {
  String? consignor_name_value;
  String? item_name_value;
  String? payment_type_value;

  var conslist;

  late List<String> consignor_names_list;
  late List<String> item_name_list;
  late List<String> payment_type_list;

  void _populateDropdown() async {
    final conslist = await getList("consignor_name");
    final itemlist = await getList("item_name");
    final custlist = await getList("customer_name");

    setState(() {
      consignor_names_list = conslist!;
      item_name_list = itemlist!;
      payment_type_list = custlist!;
    });
  }

  @override
  initState() {
    super.initState();

    consignor_names_list = <String>["Mukesh", "Nithya"];
    item_name_list = <String>["Potato", "Tomato", "Beetroot"];
    payment_type_list = <String>["Cash", "DC"];

    _populateDropdown();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: AppBar(
              title: Text(
                "Retail Management System",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              actions: const [
                Center(
                    child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "TOKEN",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
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
                padding: EdgeInsets.all(14),
                color: Colors.black,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 130,
                              child: Row(
                                children: [
                                  Text("TOKEN NO:",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text("123456",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ))
                                ],
                              ),
                            ),
                            Container(
                                width: 130,
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

                      // ########## Consignor Name
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
                                    hint: const Text("Consignor Name"),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                    value: consignor_name_value,
                                    onChanged: (String? value) {
                                      setState(() {
                                        consignor_name_value = value ?? "";
                                      });
                                    },
                                    items: consignor_names_list
                                        .map<DropdownMenuItem<String>>(
                                            (String consignor) {
                                      return DropdownMenuItem<String>(
                                        value: consignor,
                                        child: Text(consignor),
                                      );
                                    }).toList()),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Consignor Name ################

                      // ########## ITEM NAME

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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Lot no:",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          Container(
                            width: 200,
                            child: SizedBox(
                              width: 100,
                              height: 30,
                              child: TextField(
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Lot no.',
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
                          Text("Mark:",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          Container(
                            width: 200,
                            child: SizedBox(
                              width: 100,
                              height: 30,
                              child: const TextField(
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Mark',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.all(5),
                                ),
                                style: TextStyle(color: Colors.black),
                                textInputAction: TextInputAction.next,
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
                          Text("Units:",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          Container(
                            width: 200,
                            child: SizedBox(
                              width: 100,
                              height: 30,
                              child: TextField(
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
                                  obscureText: false,
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
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Amount',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                  contentPadding: EdgeInsets.all(5),
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
                            width: 60,
                            height: 30,
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: TextField(
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'copies',
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
                          Container(
                            width: 90,
                            height: 30,
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
                                          fontSize: 12,
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
                            height: 30,
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
                                          fontSize: 12,
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
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(border: Border.all()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 100,
                              height: 30,
                              child: SizedBox(
                                width: 100,
                                height: 40,
                                child: TextField(
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Existing Token ID',
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
                            Container(
                              width: 50,
                              height: 30,
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {},
                                      child: Center(child: const Text('GO')),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 30,
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {},
                                      child: Center(
                                          child: const Text('NEW TOKEN')),
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
                            width: 100,
                            height: 30,
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
                                          fontSize: 12,
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
                            width: 80,
                            height: 30,
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
                                          fontSize: 12,
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
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 30,
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
                                          fontSize: 12,
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
          ),
        )
      ],
    );
  }
}
