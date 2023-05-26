import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";
  List<String> buttonList=[
    'AC',
    ')',
    '(',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      body: Container(
        padding: bpadding,
        margin: bmargintop,
        child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(userInput, style: TextStyle(fontSize: 32, color: Colors.white),),
            ),
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerRight,
              child: Text(result, style: TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),),
            ),
            Divider(color: Colors.white,),
            Expanded(
              child: Container(
                
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: buttonList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 12, mainAxisSpacing: 12), 
                itemBuilder:(context, index){
                  return CustomButton(buttonList[index]);
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget CustomButton(String text){
    return InkWell(
      splashColor: Color(0xFF1d2630),
      onTap:() {
        setState(() {
           handlebutton(text);
        });
       
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgcolor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 3,
              spreadRadius: 0.5,
              offset: Offset(-3, -3)
            )
          ]
        ),
        child: Center(child: Text(text, style: TextStyle(
          color: getcolor(text),
          fontSize: 30, fontWeight: FontWeight.bold),)),
      ),
    );
  }
  getcolor(String text){
    if(text == "/" || text =="*" || text == "+" || text == "-" || text == "C" || text == ")" || text == "("){
      return Color.fromARGB(255, 252,100,100);
    }
    return Colors.white;
  }
    getBgcolor(String text){
    if(text == "AC"){
      return Color.fromARGB(255, 252,100,100);
    }
     if(text == "="){
      return Color.fromARGB(255, 104,204,159);
    }
    return Color(0xFF1d2630);
  }
  handlebutton(String text){
    if(text == "AC"){
      userInput = "";
      result = "0";
      return;
    }
    if(text == "C"){
      if(userInput.isNotEmpty){
        userInput  = userInput.substring(0, userInput.length -1);
        
        return;
      }
      else return;
    }
    if(text == "="){
      result = Calculate();
      userInput = result;
       if(userInput.endsWith(".0")){
        userInput = userInput.replaceAll(".0", "");
        return;
      }
      if(result.endsWith(".0")){
        result = result.replaceAll(".0", "");
        return;
      }
    }
    userInput = userInput + text;
  }
  String Calculate(){
    try{
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();

    }
    catch(e){
      return "Error";
    }
  }
}
