import 'package:flutter/material.dart';
import 'package:notestaking/constants.dart';
import 'package:notestaking/authenticate.dart';
import 'package:notestaking/screens/bottom_bar.dart';
import 'package:notestaking/sqlite.dart';

import '../authenticate.dart';
import '../sqlite.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final message = authenticate();
  final mysqlite = sqlite();
  String Title = '';
  String Note = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:SingleChildScrollView(
        child: Container(
          margin: bmargintop,
          padding: bpadding,
          child: Column(
            children: [
        
              Row(
                children: [
        
                InkWell(
                  onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar()));
                  },
                  child: Image.asset('images/backicon.png'),
                ),
        
                SizedBox(width: 240,),
        
                TextButton(
                  onPressed: () async{
                   if(Title.isEmpty && Note.isEmpty){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar()));
                        message.displaymessagefromtop(context, 'You cant have an Empty Note', false);
                      }
                      else{
                         final id = await mysqlite.insertdata(Title, Note);
                         if(id>0) Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar()));
                      }
                  },
                  child: Image.asset('images/button.png', height: 45,)
                )
        
                ],
              ),

              TextField(
                maxLines: null,
                style: TextStyle(fontSize: 25),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                   border: UnderlineInputBorder(),
                  hintText: 'Title'
                ),
                onChanged: (value){
                Title = value;
                  },
              ),
              TextField(
                maxLines: null,
                style: TextStyle(fontSize:20 ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                Note = value;
                  },
              )
        
            ],
          ),
        )
      )

    );
  }
}
