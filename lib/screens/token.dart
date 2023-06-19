//import 'dart:html';

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
  String? consignor_name_value;
  String? item_name_value;
  String? payment_type_value;
  String? lot_no_value;

  bool lot_selected = false;

  int tokenNo = 0;
  String dt_field = DateFormat("dd/MM/yyyy").format(DateTime.now());

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
  final TextEditingController _c_and_g = TextEditingController();
  final TextEditingController _amt = TextEditingController();
  final TextEditingController _existing_tokenNo = TextEditingController();

  void _populateDropdown() async {
    final conslist = await getConsignorList();
    final itemlist = await getItemList();

    final custList = await getCustomerList();
    custList?.insert(0, "--- Cash ---");

    final lotList = await DB_Helper.getLotNumberList();
    lotList?.insert(0, "---");


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

  void _setDate() async {
    setState(() {
      dt_field = DateFormat("dd/MM/yyyy").format(DateTime.now());;
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
    _setDate();

    lot_selected = false;

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
                                        dt_field.toString(),
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
                                    bool is_dash = false;
                                    if(value == "---")
                                      {
                                        is_dash = true;
                                      }
                                    setState(() {

                                      lot_no_value = value ?? "";
                                      if(!is_dash)
                                        {
                                          _loadNoData();
                                        }
                                      lot_selected = !is_dash;

                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ########## Consignor Name
                      // ## text - commented as we are using drop down now.
                      // Padding(
                      //   padding: const EdgeInsets.all(5.0),
                      //   child: SizedBox(
                      //     width: 300,
                      //     height: 40,
                      //     child: Container(
                      //         child: TextField(
                      //       controller: consignor,
                      //       obscureText: false,
                      //       decoration: InputDecoration(
                      //         labelText: 'Consignor Name',
                      //         labelStyle:
                      //             TextStyle(color: Colors.black, fontSize: 12),
                      //         contentPadding: EdgeInsets.all(5),
                      //         border: OutlineInputBorder(),
                      //       ),
                      //       enabled: false,
                      //     )),
                      //   ),
                      // ),
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
                                    disabledHint: Text(consignor_name_value ?? ""),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                    value: consignor_name_value,
                                    onChanged: lot_selected ? null : (value) {
                                      setState(() {
                                        consignor_name_value = value ?? "";
                                      });
                                    },
                                    items: consignor_names_list
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
                      // Consignor Name ################

                      // ########## ITEM NAME
                      // text. commented as drop down is being used
                      // Padding(
                      //   padding: const EdgeInsets.all(5.0),
                      //   child: SizedBox(
                      //     width: 300,
                      //     height: 40,
                      //     child: Container(
                      //         child: TextField(
                      //       controller: item,
                      //       obscureText: false,
                      //       decoration: InputDecoration(
                      //         labelText: 'Item Name',
                      //         labelStyle:
                      //             TextStyle(color: Colors.black, fontSize: 12),
                      //         contentPadding: EdgeInsets.all(5),
                      //         border: OutlineInputBorder(),
                      //       ),
                      //       enabled: false,
                      //     )),
                      //   ),
                      // ),
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
                                    disabledHint: Text(item_name_value ?? "", ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,

                                    ),
                                    value: item_name_value,
                                    onChanged: lot_selected ? null : (String? value) {
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
                                        int cANDg = 0;
                                        if (_c_and_g.text.isNotEmpty &&
                                            _c_and_g.text != "") {
                                          cANDg = int.parse(_rate.text);
                                        }
                                        _amt.text = ((rt * units) + cANDg).toString();

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

                                      int cANDg = 0;
                                      if (_c_and_g.text.isNotEmpty &&
                                          _c_and_g.text != "") {
                                        cANDg = int.parse(_rate.text);
                                      }
                                      _amt.text = ((rt * wt) + cANDg).toString();
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

                                    int cANDg = 0;
                                    if (_c_and_g.text != "" || _c_and_g.text.isNotEmpty) {
                                      cANDg = int.parse(_c_and_g.text);
                                    }

                                    int multiplier = 0;

                                    if (_wt.text.isNotEmpty) {
                                      multiplier = int.parse(_wt.text);
                                    } else if (_units.text.isNotEmpty) {
                                      multiplier = int.parse(_units.text);
                                    }

                                    setState(() {
                                      _amt.text = ((rt * multiplier) + cANDg).toString();
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
                          Text("C and G:",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold)),
                          Container(
                            width: 200,
                            child: SizedBox(
                              width: 100,
                              height: 30,
                              child: TextField(
                                  controller: _c_and_g,
                                  obscureText: false,
                                  onChanged: (txt) {
                                    int cANDg = 0;
                                    if (txt != "" || txt.isNotEmpty) {
                                      cANDg = int.parse(txt);
                                    }

                                    int rt = 0;
                                    if (_rate.text != "" || _rate.text.isNotEmpty) {
                                      rt = int.parse(_rate.text);
                                    }

                                    int multiplier = 0;

                                    if (_wt.text.isNotEmpty) {
                                      multiplier = int.parse(_wt.text);
                                    } else if (_units.text.isNotEmpty) {
                                      multiplier = int.parse(_units.text);
                                    }

                                    setState(() {
                                      _amt.text = ((rt * multiplier) + cANDg).toString();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'CandG',
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
                                      if(canSave) {
                                        var snackBar = await saveToDB();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
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
                                        _setDate();
                                        setState(() {
                                          canSave = true;
                                        });
                                        focusRefresh();
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

    // if (lot_no_value == null) {
    //   return const SnackBar(content: Text("Please select Lot No"));
    // }

    if (consignor_name_value == null) {
      return const SnackBar(content: Text("Consignor blank. Select Lot No or enter Consignor Name"));
    }

    if (item_name_value == null) {
      return const SnackBar(content: Text("Item blank. Select Lot No or enter Item Name"));
    }

    //mark is not mandatory
    // if (_mark.text.trim() == "") {
    //   return const SnackBar(content: Text("Please enter Mark"));
    // }

    //units is mandatory
    if (_units.text.trim() == "") {
      return const SnackBar(content: Text("Please enter Units"));
    }

    //weight is not mandatory
    // if (_wt.text.trim() == "") {
    //   return const SnackBar(
    //       content: Text("Please enter weight"));
    // }

    if (_rate.text.trim() == "") {
      return const SnackBar(content: Text("Please enter Rate"));
    }

    var units;
    var weight;
    var c_and_g;

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

    if (_c_and_g.text != "") {
      c_and_g = int.parse(_c_and_g.text);
    } else {
      c_and_g = "";
    }

    final data = {
      'token_no' : tokenNo,
      'date_field' : dt_field,
      // 'consignor_id': consignor.text,
      'consignor_id': consignor_name_value,

      //'item_name': item.text,
      'item_name': item_name_value,

      'payment_type': payment_type_value,
      'lot_no': lot_no_value,
      'mark': _mark.text,
      'units': units,
      'weight': weight,
      'rate': int.parse(_rate.text),
      'c_and_g': c_and_g,
      'amount': int.parse(_amt.text)
    };

    int id = await DB_Helper.createToken(data);

    print("id");
    print(id);

    if (id == tokenNo) {
      setState(() {
        _setTokenNo();
        _setDate();
      });
    }

    _clearFields();

    focusRefresh();

    return const SnackBar(content: Text("Token saved successfully!"));

  }

  void focusRefresh()
  {
    //focus refresh
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => super.widget));
  }

  Future<void> _loadData() async {
    print(_existing_tokenNo.text);

    if (_existing_tokenNo.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Existing Token No is empty")));

      return;
    }

    var res = await DB_Helper.getToken(int.parse(_existing_tokenNo.text));

    if (res == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Token No invalid")));

      return;
    }

    print("returned token is");
    print(res);

    setState(() {
      dt_field = res['date_field'].toString();

      //consignor.text = (res['consignor_id'] as String);
      consignor_name_value = res['consignor_id'].toString();

      //item.text = (res['item_name'] as String);
      item_name_value = res['item_name'].toString();

      payment_type_value = res['payment_type'] as String?;

      if(res['lot_no'].toString() == "null")
        {
          lot_no_value = "---";
        }
      else
        {
          lot_no_value = res['lot_no'].toString();
        }


      _mark.text = res['mark'].toString();
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
      _c_and_g.text = "";
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
      //consignor.text = res['consignor_id'] as String;
      consignor_name_value = res['consignor_id'].toString();

      //item.text = res['item_name'] as String;
      item_name_value = res['item_name'].toString();
    });
  }
}
