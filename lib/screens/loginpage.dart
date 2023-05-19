import 'package:flutter/material.dart';
import 'package:ngx/screens/loginform.dart';
import 'package:ngx/screens/regform.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Text(
                      'Retail Management Systems',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 56,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 75,
                ),
                Column(
                  children: [
                    Container(
                      width: 300,
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
                                textStyle: const TextStyle(fontSize: 18),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => loginform()),
                                );
                              },
                              child: Center(child: const Text('Login')),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: 300,
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
                                textStyle: const TextStyle(fontSize: 18),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => regform()),
                                );
                              },
                              child: Center(child: const Text('Register')),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 75,
                    ),
                    Text(
                      'Copyright 2023 Renuka Systems. All rights reserved.',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
