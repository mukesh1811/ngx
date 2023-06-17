import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ngx/screens/ConfigHelper.dart';
import 'package:ngx/screens/homepage.dart';
import 'package:ngx/screens/loginpage.dart';

import 'DB_Helper.dart';

class Token extends StatefulWidget {
  @override
  State<Token> createState() => _TokenState();
}

class _TokenState extends State<Token> {
  String? payment_type_value;
  String? lot_no_value;

  int tokenNo = 0;

  bool canSave = true;

  late List<String> consignor_names_list = [];
  late List<String> item_name_list = [];
  late List<String> payment_type_list = [];
  late List<String> lot_no_list = [];

  final TextEditingController consignor = TextEditingController();
  final TextEditingController item = TextEditingController();

  final TextEditingController _mark = TextEditingController();
  final TextEditingController _units = TextEditingController();
  final TextEditingController _wt = TextEditingController();
  final TextEditingController _rate = TextEditingController();
  final TextEditingController _amt = TextEditingController();
  final TextEditingController _existing_tokenNo = TextEditingController();

  void _populateDropdown() async {
    final conslist = await getConsignorList();
    final itemlist = await getItemList();
    final custList = await getCustomerList();
    final lotList = await getLotNumberList();
    custList?.insert(0, "--- Cash ---");

    setState(() {
      consignor_names_list = conslist!;
      item_name_list = itemlist!;
      payment_type_list = custList!;
      lot_no_list = lotList!;
    });
  }

  void _setTokenNo() async {
    var maxTokenNo = await DB_Helper.getMaxTokenNo();

    setState(() {
      tokenNo = maxTokenNo;
    });
  }

  @override
  initState() {
    super.initState();
    _populateDropdown();

    _mark.text = "";
    _units.text = "";
    _wt.text = "";
    _amt.text = "";
    _rate.text = "";

    _setTokenNo();
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
                    "Token",
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
                    color: Colors.white,
                  ),
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
                                  Text(tokenNo.toString(),
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
                                  hint: const Text("Lot No"),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                  items: lot_no_list
                                      .map<DropdownMenuItem<String>>(
                                          (String consignor) {
                                    return DropdownMenuItem<String>(
                                      value: consignor,
                                      child: Text(consignor),
                                    );
                                  }).toList(),
                                  value: lot_no_value,
                                  onChanged: (String? value) {
                                    setState(() {
                                      lot_no_value = value ?? "";
                                      _loadNoData();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ########## Consignor Name
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: 300,
                          height: 40,
                          child: Container(
                              child: TextField(
                            controller: consignor,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Consignor Name',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 12),
                              contentPadding: EdgeInsets.all(5),
                              border: OutlineInputBorder(),
                            ),
                            enabled: false,
                          )),
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
                              child: TextField(
                            controller: item,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Item Name',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 12),
                              contentPadding: EdgeInsets.all(5),
                              border: OutlineInputBorder(),
                            ),
                            enabled: false,
                          )),
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
                              child: TextField(
                                controller: _mark,
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
                                  controller: _units,
                                  onChanged: (txt1) {
                                    if (_wt.text.isEmpty || _wt.text == "") {
                                      int units = 0;
                                      if (txt1.isNotEmpty && txt1 != "") {
                                        units = int.parse(txt1);
                                      }

                                      setState(() {
                                        int rt = 0;

                                        if (_rate.text.isNotEmpty &&
                                            _rate.text != "") {
                                          rt = int.parse(_rate.text);
                                        }
                                        _amt.text = (rt * units).toString();
                                      });
                                    }
                                  },
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
                                  onChanged: (txt2) {
                                    int wt = 0;
                                    if (txt2.isNotEmpty && txt2 != "") {
                                      wt = int.parse(txt2);
                                    } else if (_units.text.isNotEmpty) {
                                      wt = int.parse(_units.text);
                                    }

                                    setState(() {
                                      int rt = 0;

                                      if (_rate.text.isNotEmpty &&
                                          _rate.text != "") {
                                        rt = int.parse(_rate.text);
                                      }
                                      _amt.text = (rt * wt).toString();
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

                                    int multiplier = 0;

                                    if (_wt.text.isNotEmpty) {
                                      multiplier = int.parse(_wt.text);
                                    } else if (_units.text.isNotEmpty) {
                                      multiplier = int.parse(_units.text);
                                    }

                                    setState(() {
                                      _amt.text = (rt * multiplier).toString();
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
                                    controller: _existing_tokenNo,
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
                                      onPressed: () {
                                        _loadData();
                                      },
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
                                      onPressed: () {
                                        _clearFields();
                                        _setTokenNo();
                                        setState(() {
                                          canSave = true;
                                        });
                                      },
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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

  Future<SnackBar> saveToDB() async {
    print("Save");

    if (payment_type_value == null) {
      return const SnackBar(content: Text("Please select payment type"));
    }

    if (lot_no_value == null) {
      return const SnackBar(content: Text("Please select Lot No"));
    }

    if (_mark.text.trim() == "") {
      return const SnackBar(content: Text("Please enter Mark"));
    }

    if (_wt.text.trim() == "" && _units.text.trim() == "") {
      return const SnackBar(
          content: Text("Please enter either weight or unit"));
    }

    if (_rate.text.trim() == "") {
      return const SnackBar(content: Text("Please enter Rate"));
    }

    var units;
    var weight;

    if (_units.text != "") {
      units = int.parse(_units.text);
    } else {
      units = "";
    }

    if (_wt.text != "") {
      weight = int.parse(_wt.text);
    } else {
      weight = "";
    }

    final data = {
      'consignor_name': consignor.text,
      'item_name': item.text,
      'payment_type': payment_type_value,
      'lot_no': lot_no_value,
      'mark': _mark.text,
      'units': units,
      'weight': weight,
      'rate': int.parse(_rate.text),
      'amount': int.parse(_amt.text)
    };

    int id = await DB_Helper.createToken(data);

    print("id");
    print(id);

    if (id == tokenNo) {
      setState(() {
        _setTokenNo();
      });
    }

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => Token()),
    // );
    ;

    _clearFields();

    return const SnackBar(content: Text("Token saved successfully!"));
  }

  Future<void> _loadData() async {
    print(_existing_tokenNo.text);

    if (_existing_tokenNo.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Existing Token No is empty")));

      return;
    }

    var res = await DB_Helper.getToken(int.parse(_existing_tokenNo.text));

    print("returned token is");
    print(res);

    setState(() {
      consignor.text = (res['consignor_name'] as String);
      item.text = (res['item_name'] as String);
      payment_type_value = res['payment_type'] as String?;
      lot_no_value = (res['lot_no'] as String?)!;
      _mark.text = (res['mark'] as String?)!;
      _units.text = res['units'].toString();
      _wt.text = res['weight'].toString();
      _rate.text = res['rate'].toString();
      _amt.text = res['amount'].toString();

      tokenNo = int.parse(_existing_tokenNo.text);

      canSave = false;
    });
  }

  void amount() {
    int units = 0;
    int wt = 0;
    int rt = 0;

    if (_wt.text.isNotEmpty & _units.text.isEmpty) {
      wt = int.parse(_wt.text);
    }
    _amt.text = (rt * wt).toString();

    if (_units.text.isNotEmpty & _wt.text.isNotEmpty) {
      wt = int.parse(_wt.text);
    }

    _amt.text = (rt * wt).toString();

    if (_wt.text.isEmpty & _units.text.isNotEmpty) {
      units = int.parse(_units.text);
    }

    _amt.text = (rt * units).toString();
  }

  void _clearFields() {
    setState(() {
      consignor.text = "";
      item.text = "";
      payment_type_value = null;
      lot_no_value = null;
      _mark.text = "";
      _units.text = "";
      _wt.text = "";
      _rate.text = "";
      _amt.text = "";
      _existing_tokenNo.text = "";

      print("cleared!");
    });
  }

  Future<void> _loadNoData() async {
    print(lot_no_value);

    if (lot_no_value == "") {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Lot No is empty")));

      return;
    }

    var res = await DB_Helper.getlotnumber(lot_no_value!);

    print("returned lotnumber is");
    print(res);

    setState(() {
      item.text = res['item_name'] as String;
      consignor.text = res['consignor_name'] as String;
    });
  }
}
