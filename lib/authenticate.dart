
import 'package:flutter/material.dart';
import 'package:notestaking/screens/bottom_bar.dart';
import 'package:notestaking/screens/home.dart';
//import 'package:notestaking/screens/marie1.dart';
import 'package:notestaking/sqlite.dart';
import 'package:notestaking/sqlite.dart';
class authenticate {
  final mysql = sqlite();

void displaymessagefromtop(BuildContext context, String message, bool success){
 final Snackbar = SnackBar(
  //behavior: SnackBarBehavior.floating,
  duration: Duration(seconds: 2),
  
  content: Row( 
  children: [
     success? Icon(Icons.check, color: Colors.white): Icon(Icons.error, color: Colors.white,),
     SizedBox(width: 10,),
     Expanded(child: Wrap(children: [Text(message, style: TextStyle(color: Colors.white),overflow: TextOverflow.fade ,)] )),
     
  ],
 ),
 backgroundColor: success? Color.fromARGB(255, 103, 222, 156): Color.fromARGB(255, 167, 77, 70)
 );
 ScaffoldMessenger.of(context).showSnackBar(Snackbar);
}
void deletenotemessage(BuildContext context, int note, bool NoteOrEvent){
  showModalBottomSheet(
    backgroundColor: Color.fromARGB(255, 185, 181, 181),
    elevation: 30,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25)
      )
    ),
    context: context, 
  builder: (context){

    return Container(
      height: 150,
     margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          ListTile(
            title: NoteOrEvent? Center(child: Text("Are you sure you want to delete this Note")): Center(child: Text("Are you sure you want to delete this Event"))

          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: (){
                  Navigator.of(context).pop(true);
              }, child: Text("Delete")),
               TextButton(
            onPressed: (){
              Navigator.of(context).pop(false);
          }, child: Text("Cancel"))
            ],
          ),
         
        ],
      )
    );
  }).then((value) async {
    if(value !=null && value) {
    if(NoteOrEvent) {
      final record = await mysql.deleterecord(note); 
      if(record> 0){
           displaymessagefromtop(context, 'Deleted Note', true);
                    }
      Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomBar(index: 0,)));
    }
    else{
      final record = await mysql.deleteevent(note);
      if(record> 0){
           displaymessagefromtop(context, 'Deleted Event', true);
                    }
      Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomBar(index: 1,)));
    }  
    
      
    }
    else{
      // NoteOrEvent? Navigator.of(context).pop():
      // Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomBar(index: 1,)));
      Navigator.of(context).pop();
    }
  });
}

  
