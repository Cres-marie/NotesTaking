import 'package:flutter/material.dart';
import 'package:notestaking/screens/bottom_bar.dart';

import '../constants.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: bmargintop,
          padding: bpadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Image.asset('images/started.png')),
              Column(
                children: [
                  Text(
                    'Manage your notes',
                    style: bheadings,
                  ),
                  Text(
                    'easily',
                    style: bheadings,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'A completely easy way to manage and customise your',
                    style: TextStyle(fontSize: 15, color: Color(0xFF1C2121)),
                  ),
                  Text(
                    ' notes.',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomBar(),
                            ));
                      },
                      
                        child: Image.asset(
                          'images/start.png',
                          height: 72 ,
                        ),
                      )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
