import 'package:flutter/material.dart';
import 'package:ngx/screens/DB_Helper.dart';

class Changepwd extends StatefulWidget {
  const Changepwd({Key? key}) : super(key: key);

  @override
  State<Changepwd> createState() => _ChangepwdState();
}

class _ChangepwdState extends State<Changepwd> {
  TextEditingController _old_pwd = TextEditingController();
  TextEditingController _new_pwd = TextEditingController();
  TextEditingController _confirm_pwd = TextEditingController();

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
                    "Settings",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ))
              ]),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(children: [
                SizedBox(
                  height: 100,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  //padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    controller: _old_pwd,
                    obscureText: true,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontSize: 24),

                    //autofocus: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 3.0)),
                        labelText: "Old Password",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  //padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    controller: _new_pwd,
                    obscureText: true,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontSize: 24),

                    //autofocus: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 3.0)),
                        labelText: "New Password",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  //padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    controller: _confirm_pwd,
                    obscureText: true,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontSize: 24),

                    //autofocus: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 3.0)),
                        labelText: "Confirm New Password",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 50, 10),
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
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                textStyle: const TextStyle(fontSize: 14),
                              ),
                              onPressed: () async {
                                var snackBar = await change_pwd();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              child: Center(child: const Text('Submit')),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      )
    ]);
  }

  Future<SnackBar> change_pwd() async {
    if (_old_pwd.text.trim() == "") {
      return const SnackBar(content: Text("Please enter old password"));
    }

    if (_new_pwd.text.trim() == "") {
      return const SnackBar(content: Text("Please enter new password"));
    }

    if (_confirm_pwd.text.trim() == "") {
      return const SnackBar(content: Text("Please confirm new password"));
    }

    if (_confirm_pwd.text.trim() != _new_pwd.text.trim()) {
      return const SnackBar(content: Text("Password mismatch"));
    }

    String pwd_from_db = await DB_Helper.getPwd('admin');

    if (pwd_from_db != _old_pwd.text.trim()) {
      return const SnackBar(content: Text("Incorrect password"));
    }

    DB_Helper.updateAdminPwd(_new_pwd.text.trim());

    return const SnackBar(content: Text("Password updated successfully!"));
  }
}
