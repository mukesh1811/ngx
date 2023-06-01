import 'package:flutter/material.dart';

class Changepwd extends StatefulWidget {
  const Changepwd({Key? key}) : super(key: key);

  @override
  State<Changepwd> createState() => _ChangepwdState();
}

class _ChangepwdState extends State<Changepwd> {
  TextEditingController _pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
          ),
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
                    controller: _pwd,
                    obscureText: true,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.grey, fontSize: 24),

                    //autofocus: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 3.0)),
                        labelText: "Old Password",
                        labelStyle:
                            TextStyle(color: Colors.grey, fontSize: 18)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  //padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    controller: _pwd,
                    obscureText: true,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.grey, fontSize: 24),

                    //autofocus: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 3.0)),
                        labelText: "New Password",
                        labelStyle:
                            TextStyle(color: Colors.grey, fontSize: 18)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  //padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    controller: _pwd,
                    obscureText: true,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.grey, fontSize: 24),

                    //autofocus: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 3.0)),
                        labelText: "Confirm New Password",
                        labelStyle:
                            TextStyle(color: Colors.grey, fontSize: 18)),
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
                              onPressed: () async {},
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
}
