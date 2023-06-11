import 'package:flutter/material.dart';
import 'package:ngx/screens/DB_Helper.dart';
import 'package:ngx/screens/homepage.dart';

Future<String> login_validate() async {
  String login_status = await DB_Helper.auth(_uname.text, _pwd.text);
  return login_status;
}

TextEditingController _uname = TextEditingController();
TextEditingController _pwd = TextEditingController();

void clearTextFields() {
  _uname.clear();
  _pwd.clear();
}

class loginform extends StatefulWidget {
  const loginform({Key? key}) : super(key: key);

  @override
  State<loginform> createState() => _loginformState();
}

class _loginformState extends State<loginform> {
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
                          Text("Login",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: 50),
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
                                String login_status = await login_validate();

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(login_status)));

                                if (login_status == "Login Successful!") {
                                  clearTextFields();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Homepage()),
                                  );
                                } else {}
                              },
                              child: Center(child: const Text('Login')),
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
