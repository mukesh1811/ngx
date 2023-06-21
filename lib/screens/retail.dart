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

  int retailNo = 0;
  String dt_field = DateFormat("dd/MM/yyyy").format(DateTime.now());

  bool canSave = true;

  late List<String> item_name_list = [];
  late List<String> payment_type_list = [];

  final TextEditingController _units = TextEditingController();
  final TextEditingController _wt = TextEditingController();
  final TextEditingController _rate = TextEditingController();
  final TextEditingController _amt = TextEditingController();
  final TextEditingController _existing_retailNo = TextEditingController();

  static const platform = MethodChannel('ngx.print.channel');
  Future<void> _print() async {

    var arguments = {
      'retail_no' : retailNo.toString(),
      'date_field' : dt_field.toString(),

      //'item_name': item.text,
      'item_name': item_name_value.toString(),

      'payment_type': payment_type_value.toString(),

      'units': _units.text.toString(),
      'weight': _wt.text.toString(),
      'rate': _rate.text.toString(),

      'amount': _amt.text.toString()
    };

    try {
      final int result = await platform.invokeMethod('printRetail', arguments);
    } on PlatformException catch (e) {
      print("ERROR: '${e.message}'.");
    }
  }

  void _populateDropdown() async {
    final itemlist = await getItemList();
    final custList = await getCustomerList();
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

  void _setDate() async {
    setState(() {
      dt_field = DateFormat("dd/MM/yyyy").format(DateTime.now());;
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
    _setDate();
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
                                      dt_field,
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


                                    if(canSave) {
                                      var snackBar = await saveToDB(true);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                    else
                                    {
                                      _print();
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
                                          var snackBar = await saveToDB(false);
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
                                        _setDate();
                                        setState(() {
                                          canSave = true;
                                        });
                                        focusRefresh();
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

  Future<SnackBar> saveToDB(bool shouldPrint) async {
    print("Save");

    String validationResult = formValidate();

    if(validationResult == "") {
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

      String? paymentResolved = payment_type_value;
      if (payment_type_value != "--- Cash ---") {
        paymentResolved = await getCustomerID(payment_type_value!);
      }

      final data = {
        'retail_no': retailNo,
        'date_field': dt_field,
        'item_name': item_name_value,
        'payment_type': paymentResolved,
        'units': units,
        'weight': weight,
        'rate': int.parse(_rate.text),
        'amount': int.parse(_amt.text)
      };

      int id = await DB_Helper.createRetail(data);

      print("id");
      print(id);

      if (id == retailNo) {
        setState(() {
          _setRetailNo();
          _setDate();
        });
      }

      validationResult = "Token saved successfully!";

      //print
      if (shouldPrint) {
        _print();
      }

      _clearFields();

      focusRefresh();
    }

    return SnackBar(content: Text("$validationResult"));


  }

  String formValidate()
  {

    if (item_name_value == null) {
      return "Please select an item name";
    }

    if (payment_type_value == null) {
      return "Please select payment type";
    }

    if (_wt.text.trim() == "" && _units.text.trim() == "") {
      return "Please enter either weight or unit";
    }

    if (_rate.text.trim() == "") {
      return "Please enter Rate";
    }



    //validation pass
    return "";
  }

  void focusRefresh()
  {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => super.widget));
  }

  Future<void> _loadData() async {
    print(_existing_retailNo.text);

    if (_existing_retailNo.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Existing Retail No is empty")));

      return;
    }

    var res = await DB_Helper.getRetail(int.parse(_existing_retailNo.text));

    if (res == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Retail No invalid")));

      return;
    }

    print("returned token is");
    print(res);

    String paymentType = res['payment_type'].toString();
    if(paymentType != "--- Cash ---")
      {
        paymentType = await getCustomerDisplayValue(paymentType);
      }

    setState(() {
      dt_field = res['date_field'].toString();
      item_name_value = res['item_name'].toString();
      payment_type_value = paymentType;
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
