
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
 backgroundColor: success? Color.fromARGB(255, 19, 175, 24): Color.fromARGB(255, 236, 31, 16)
 );
 ScaffoldMessenger.of(context).showSnackBar(Snackbar);
}
void deletenotemessage(BuildContext context, int note){
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
            title: Center(child: Text("Are you sure you want to delete this note?")),
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
      final record = await mysql.deleterecord(note);
      if(record> 0){
           displaymessagefromtop(context, 'Deleted record', true);
                    }
      Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomBar()));
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomBar()));
    }
  });
}

  


}