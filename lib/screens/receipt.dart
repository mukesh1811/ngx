import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ngx/screens/homepage.dart';
import 'package:ngx/screens/loginpage.dart';

import 'ConfigHelper.dart';
import 'DB_Helper.dart';

class Receipt extends StatefulWidget {
  const Receipt({Key? key}) : super(key: key);

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  String? customer_name_value;

  int receiptNo = 0;
  String dt_field = DateFormat("dd/MM/yyyy").format(DateTime.now());

  bool canSave = true;

  late List<String> customer_names_list = [];

  final TextEditingController _balance_txtcntrl = TextEditingController();
  final TextEditingController _existing_receiptNo = TextEditingController();


  static const platform = MethodChannel('ngx.print.channel');
  Future<void> _print() async {

    var arguments = {
      'receipt_no' : receiptNo.toString(),
      'date_field' : dt_field.toString(),

      //'item_name': item.text,
      'customer_name': customer_name_value.toString(),

      'balance': _balance_txtcntrl.text.toString()
    };

    try {
      final int result = await platform.invokeMethod('printReceipt', arguments);
    } on PlatformException catch (e) {
      print("ERROR: '${e.message}'.");
    }
  }


  void _populateDropdown() async {
    final custList = await getCustomerList();

    setState(() {
      customer_names_list = custList!;
    });
  }

  void _setReceiptNo() async {
    var maxTokenNo = await DB_Helper.getMaxReceiptNo();

    setState(() {
      receiptNo = maxTokenNo;
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

    _balance_txtcntrl.text = "";

    _setReceiptNo();
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
                                      dt_field,
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
                          controller: _balance_txtcntrl,
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
                            width: 120,
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: _existing_receiptNo,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Existing Receipt NO',
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
                                        _setReceiptNo();
                                        _setDate();
                                        setState(() {
                                          canSave = true;
                                        });
                                        focusRefresh();
                                      },
                                      child: Center(
                                          child: const Text('NEW RECEIPT')),
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
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
      String custId = await getCustomerID(customer_name_value!);


      final data = {
        'receipt_no': receiptNo,
        'date_field': dt_field,
        'customer_id': custId,
        'balance': _balance_txtcntrl.text
      };

      int id = await DB_Helper.createReceipt(data);

      print("id");
      print(id);

      if (id == receiptNo) {
        setState(() {
          _setReceiptNo();
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
    if (customer_name_value == null) {
      return "Please select a customer name";
    }

    if (_balance_txtcntrl.text.trim() == "") {
      return "Please enter balance amount";
    }

    //validation pass
    return "";

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
    print(_existing_receiptNo.text);

    if (_existing_receiptNo.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Existing Receipt No is empty")));

      return;
    }

    var res = await DB_Helper.getReceipts(int.parse(_existing_receiptNo.text));

    if (res == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Receipt No invalid")));

      return;
    }

    String custDisplayName = await getCustomerDisplayValue(res['customer_id'].toString());

    setState(() {
      dt_field = res['date_field'].toString();


      customer_name_value = custDisplayName;

      _balance_txtcntrl.text = res['balance'].toString();

      receiptNo = int.parse(_existing_receiptNo.text);

      canSave = false;
    });
  }

  void _clearFields() {
    setState(() {
      customer_name_value = null;
      _balance_txtcntrl.text = "";
      _existing_receiptNo.text = "";

      print("cleared!");
    });
  }
}
