import 'package:flutter/material.dart';
import 'package:ngx/screens/settings.dart';

import 'DB_Helper.dart';
import 'changepwd.dart';

Future<String> login_validate() async {
  String login_status = await DB_Helper.auth("admin", _pwd.text);
  return login_status;
}

TextEditingController _pwd = TextEditingController();

void clearTextFields() {
  _pwd.clear();
}

class SettingsLogin extends StatefulWidget {
  const SettingsLogin({Key? key}) : super(key: key);

  @override
  State<SettingsLogin> createState() => _SettingsLoginState();
}

class _SettingsLoginState extends State<SettingsLogin> {
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
                  height: 75,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  //padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    controller: _pwd,
                    obscureText: true,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    onTapOutside: (event) {},

                    //autofocus: true,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 3.0)),
                        labelText: "Password",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
                                String login_status = await login_validate();

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(login_status)));

                                if (login_status == "Login Successful!") {
                                  clearTextFields();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Settings()),
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
