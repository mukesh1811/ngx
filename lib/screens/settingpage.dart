import 'package:flutter/material.dart';

import 'DB_Helper.dart';
import 'changepwd.dart';
import 'homepage.dart';

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

class settingpage extends StatefulWidget {
  const settingpage({Key? key}) : super(key: key);

  @override
  State<settingpage> createState() => _settingpageState();
}

class _settingpageState extends State<settingpage> {
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
                        labelText: "Password",
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
                                padding: const EdgeInsets.all(10.0),
                                textStyle: const TextStyle(fontSize: 14),
                              ),
                              onPressed: () async {
                                String login_status = await login_validate();

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(login_status)));

                                if (login_status == "Login Successfull!") {
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
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Changepwd()),
                                );
                              },
                              child:
                                  Center(child: const Text('Change Password')),
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

//                     body:SingleChildScrollView(
//     padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
//                       //padding: const EdgeInsets.all(30.0),
//                       child: TextField(
//                         controller: _pwd,
//                         obscureText: true,
//                         cursorColor: Colors.white,
//                         style: TextStyle(color: Colors.grey, fontSize: 24),
//
//                         //autofocus: true,
//                         decoration: InputDecoration(
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(25)),
//                                 borderSide:
//                                     BorderSide(color: Colors.grey, width: 3.0)),
//                             labelText: "Password",
//                             labelStyle:
//                                 TextStyle(color: Colors.grey, fontSize: 18)),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(80, 10, 50, 10),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: Stack(
//                               children: <Widget>[
//                                 Positioned.fill(
//                                   child: Container(
//                                     decoration: const BoxDecoration(
//                                         color: Colors.deepOrange),
//                                   ),
//                                 ),
//                                 TextButton(
//                                   style: TextButton.styleFrom(
//                                     foregroundColor: Colors.white,
//                                     padding: const EdgeInsets.all(10.0),
//                                     textStyle: const TextStyle(fontSize: 14),
//                                   ),
//                                   onPressed: () async {
//                                     String login_status =
//                                         await login_validate();
//
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                         SnackBar(content: Text(login_status)));
//
//                                     if (login_status == "Login Successfull!") {
//                                       clearTextFields();
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => Homepage()),
//                                       );
//                                     } else {}
//                                   },
//                                   child: Center(child: const Text('Login')),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(80, 10, 50, 10),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: Stack(
//                               children: <Widget>[
//                                 Positioned.fill(
//                                   child: Container(
//                                     decoration: const BoxDecoration(
//                                         color: Colors.deepOrange),
//                                   ),
//                                 ),
//                                 TextButton(
//                                   style: TextButton.styleFrom(
//                                     foregroundColor: Colors.white,
//                                     padding: const EdgeInsets.all(10.0),
//                                     textStyle: const TextStyle(fontSize: 14),
//                                   ),
//                                   onPressed: () async {
//                                     String login_status =
//                                         await login_validate();
//
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                         SnackBar(content: Text(login_status)));
//
//                                     if (login_status == "Login Successfull!") {
//                                       clearTextFields();
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => Homepage()),
//                                       );
//                                     } else {}
//                                   },
//                                   child: Center(
//                                       child: const Text('Change Password')),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ))
//     ]);
//     ),
//   }
  }
}
