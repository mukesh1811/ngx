import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ngx/screens/homepage.dart';
import 'package:ngx/screens/loginpage.dart';

import 'ConfigHelper.dart';
import 'DB_Helper.dart';

class Retail extends StatefulWidget {
  const Retail({Key? key}) : super(key: key);

  @override
  State<Retail> createState() => _RetailState();
}

class _RetailState extends State<Retail> {
  String? item_name_value;
  String? payment_type_value;
  String? lot_no_value;

  int retailNo = 0;

  bool canSave = true;

  late List<String> item_name_list = [];
  late List<String> payment_type_list = [];
  late List<String> lot_no_list = [];

  final TextEditingController _units = TextEditingController();
  final TextEditingController _wt = TextEditingController();
  final TextEditingController _rate = TextEditingController();
  final TextEditingController _amt = TextEditingController();
  final TextEditingController _existing_retailNo = TextEditingController();

  void _populateDropdown() async {
    final itemlist = await getList("item_name");
    final custList = await getList("customer_name");
    final lotlist = await getList("lot_no");
    custList?.insert(0, "--- Cash ---");

    setState(() {
      item_name_list = itemlist!;
      payment_type_list = custList!;
    });
  }

  void _setRetailNo() async {
    var maxTokenNo = await DB_Helper.getMaxRetailNo();

    setState(() {
      retailNo = maxTokenNo;
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

    _setRetailNo();
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
                    "Retail",
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
                                Text(retailNo.toString(),
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
                                  onPressed: () async {
                                    var snackBar = await saveToDB();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
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
                                  onPressed: canSave
                                      ? () async {
                                          var snackBar = await saveToDB();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      : null,
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
                                controller: _existing_retailNo,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Existing Retail NO',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                  border: OutlineInputBorder(),
                                ),
                                style: TextStyle(color: Colors.black),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
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
                                      onPressed: () {
                                        _loadData();
                                      },
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
                                      onPressed: () {
                                        _clearFields();
                                        _setRetailNo();
                                        setState(() {
                                          canSave = true;
                                        });
                                      },
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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

  Future<SnackBar> saveToDB() async {
    print("Save");

    if (item_name_value == null) {
      return const SnackBar(content: Text("Please select an item name"));
    }

    if (payment_type_value == null) {
      return const SnackBar(content: Text("Please select payment type"));
    }

    if (_units.text.trim() == "") {
      return const SnackBar(content: Text("Please enter Units"));
    }

    if (_wt.text.trim() == "") {
      return const SnackBar(content: Text("Please enter Weight"));
    }

    if (_rate.text.trim() == "") {
      return const SnackBar(content: Text("Please enter Rate"));
    }

    final data = {
      'item_name': item_name_value,
      'payment_type': payment_type_value,
      'units': int.parse(_units.text),
      'weight': int.parse(_wt.text),
      'rate': int.parse(_rate.text),
      'amount': int.parse(_amt.text)
    };

    int id = await DB_Helper.createRetail(data);

    print("id");
    print(id);

    if (id == retailNo) {
      setState(() {
        _setRetailNo();
      });
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => Token()),
    // );
    ;

    _clearFields();

    return const SnackBar(content: Text("Retail info saved successfully!"));
  }

  Future<void> _loadData() async {
    print(_existing_retailNo.text);

    if (_existing_retailNo.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Existing Token No is empty")));

      return;
    }

    var res = await DB_Helper.getRetail(int.parse(_existing_retailNo.text));

    print("returned token is");
    print(res);

    setState(() {
      item_name_value = res['item_name'] as String?;
      payment_type_value = res['payment_type'] as String?;
      _units.text = res['units'].toString();
      _wt.text = res['weight'].toString();
      _rate.text = res['rate'].toString();
      _amt.text = res['amount'].toString();

      retailNo = int.parse(_existing_retailNo.text);

      canSave = false;
    });
  }

  void _clearFields() {
    setState(() {
      item_name_value = null;
      payment_type_value = null;
      _units.text = "";
      _wt.text = "";
      _rate.text = "";
      _amt.text = "";
      _existing_retailNo.text = "";

      print("cleared!");
    });
  }
}
