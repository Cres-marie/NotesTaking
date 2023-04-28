import 'package:flutter/material.dart';
import 'package:notestaking/constants.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          margin: bmargintop,
          padding: bpadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text('Notes', style: bheadings),

              SizedBox(height: 24,),

              InkWell(
                onTap: () {},
                child: Image.asset('images/search.png'),
              )

            ],
          )
        ),
      )
    );
  }
}