import 'package:flutter/material.dart';
import 'package:ngx/screens/DB_Helper.dart';

Future<SnackBar> doRegister() async {
  print(_uname.text);
  print(_pwd.text);
  print(_pwdConfirm.text);
  print(_phno.text);
  print('');
  print('pwd check:');
  print(!(_pwd.text == _pwdConfirm.text));
  print('');

  String res = "";

  if (_uname.text.trim() == "") {
    return const SnackBar(content: Text("Username cannot be blank"));
  }

  if (_pwd.text.trim() == "") {
    return const SnackBar(content: Text("Password cannot be blank"));
  }

  if (_phno.text.trim() == "") {
    return const SnackBar(content: Text("Phone Number cannot be blank"));
  }

  if (_pwd.text.trim() != _pwdConfirm.text.trim()) {
    return const SnackBar(content: Text("Passwords mismatch"));
  }

  if (_phno.text.length != 10) {
    return const SnackBar(content: Text("Phone Number should be 10 digits"));
  }

  res = await DB_Helper.addUser(_uname.text, _pwd.text, int.parse(_phno.text));

  print(res);

  if (res.contains("success")) {
    clearTextFields();
  }

  return SnackBar(content: Text(res));
}

final _uname = TextEditingController();
final _pwd = TextEditingController();
final _pwdConfirm = TextEditingController();
final _phno = TextEditingController();

void clearTextFields() {
  _uname.clear();
  _pwd.clear();
  _pwdConfirm.clear();
  _phno.clear();
}

class regform extends StatefulWidget {
  const regform({Key? key}) : super(key: key);

  @override
  State<regform> createState() => _regformState();
}

class _regformState extends State<regform> {
  @override
  Widget build(BuildContext context) {
    clearTextFields();

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
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: Colors.deepOrange,
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Retail Management System",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              )),
                          Text("Register",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: TextField(
                        controller: _uname,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white, fontSize: 24),

                        //autofocus: true,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 3.0)),
                            labelText: "Username",
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      //padding: const EdgeInsets.all(30.0),
                      child: TextField(
                        controller: _pwd,
                        obscureText: true,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white, fontSize: 24),

                        //autofocus: true,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 3.0)),
                            labelText: "Password",
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: TextField(
                        controller: _pwdConfirm,
                        obscureText: true,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white, fontSize: 24),

                        //autofocus: true,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 3.0)),
                            labelText: "Confirm Password",
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: TextField(
                        controller: _phno,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        keyboardType: TextInputType.number,

                        //autofocus: true,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 3.0)),
                            labelText: "Phone Number",
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
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
                                textStyle: const TextStyle(fontSize: 14),
                              ),
                              onPressed: () async {
                                var snackBar = await doRegister();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              child: Center(child: const Text('Register')),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ))
    ]);
  }
}
