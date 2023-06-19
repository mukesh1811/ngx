import 'package:flutter/material.dart';
import 'package:ngx/screens/ConfigHelper.dart';

import 'DB_Helper.dart';
import 'homepage.dart';
import 'loginpage.dart';

TextEditingController _lotno = TextEditingController();

void clearTextFields() {
  _lotno.clear();
}

class Lotnumber extends StatefulWidget {
  const Lotnumber({Key? key}) : super(key: key);

  @override
  State<Lotnumber> createState() => _LotnumberState();
}

class _LotnumberState extends State<Lotnumber> {
  String? consignor_name_value;
  String? item_name_value;

  bool canSave = true;

  late List<String> consignor_names_list = [];
  late List<String> item_name_list = [];

  void _populateDropdown() async {
    final conslist = await getConsignorList();
    final itemlist = await getItemList();

    setState(() {
      consignor_names_list = conslist!;
      item_name_list = itemlist!;
    });
  }

  @override
  initState() {
    super.initState();
    _populateDropdown();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
        child: Image(
          image: AssetImage("images/veg1.jpg"),
          colorBlendMode: BlendMode.softLight,
          fit: BoxFit.fill,
          opacity: AlwaysStoppedAnimation(.5),
        ),
      ),
      Scaffold(
          backgroundColor: Colors.transparent,
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
                    "Lot Number",
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
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.black,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 5, 10, 5),
                          child: TextField(
                            controller: _lotno,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black, fontSize: 12),

                            //autofocus: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0)),
                                labelText: "Lot Number",
                                labelStyle: TextStyle(

                                    color: Colors.black, fontSize: 12)),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(26, 5, 10, 5),
                          child: SizedBox(
                            width: 320,
                            height: 50,
                            child: Container(
                              decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              )),
                              child: DropdownButtonHideUnderline(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: DropdownButton<String>(
                                    hint: const Text(
                                      "Consignor Name",
                                    ),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                    items: consignor_names_list
                                        .map<DropdownMenuItem<String>>(
                                            (String consignor) {
                                      return DropdownMenuItem<String>(
                                        value: consignor,
                                        child: Text(consignor),
                                      );
                                    }).toList(),
                                    value: consignor_name_value,
                                    onChanged: (String? value) {
                                      setState(() {
                                        consignor_name_value = value ?? "";
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Consignor Name ################

                        // ########## ITEM NAME

                        Padding(
                          padding: const EdgeInsets.fromLTRB(26, 5, 10, 5),
                          child: SizedBox(
                            width: 320,
                            height: 50,
                            child: Container(
                              decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, style: BorderStyle.solid),
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
                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          width: 100,
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
                                  child: Center(child: const Text('SAVE')),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 100,
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
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()),
                                        );
                                      },
                                      child:
                                          Center(child: const Text('LOGOUT')),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                                                builder: (context) =>
                                                    Homepage()),
                                          );
                                        },
                                        child:
                                            Center(child: const Text('HOME')),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ))
    ]);
  }

  Future<SnackBar> saveToDB() async {
    print("Save");

    if (_lotno.text.trim() == "") {
      return const SnackBar(content: Text("Please enter lotnumber"));
    }

    if (consignor_name_value == null) {
      return const SnackBar(content: Text("Please select a consignor name"));
    }

    if (item_name_value == null) {
      return const SnackBar(content: Text("Please select a item name"));
    }

    String consignorId = await getConsignorID(consignor_name_value!);

    final data = {
      'lot_no': _lotno.text,
      'consignor_id': consignorId,
      'item_name': item_name_value
    };

    int id = await DB_Helper.createlotnumber(data);

    print("id");
    print(id);

    _clearFields();

    return const SnackBar(content: Text("Lot number saved successfully!"));
  }

  void _clearFields() {
    setState(() {
      consignor_name_value = null;
      item_name_value = null;
      _lotno.text = "";

      print("cleared!");
    });
  }
}
