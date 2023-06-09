import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notestaking/constants.dart';
import 'package:notestaking/screens/splashScreen.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

   @override
  // void initState() {
  //   super.initState();
  //   // Hide the top status bar
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  // }

  @override
  Widget build(BuildContext context) {
    // Hide the top status bar
    //SystemChrome.setEnabledSystemUIOverlays([]);
    //SystemChrome.setEnabledSystemUIMode;
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: Home(),
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        //   fontFamily: GoogleFonts.Bubblegum Sans().fontFamily,
        textTheme: GoogleFonts.bubblegumSansTextTheme(textTheme),
      ),
      home: Splash(),
    );
  }
}
