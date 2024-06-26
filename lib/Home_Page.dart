import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe_game/custom_dialog.dart';

import 'game_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<GameButton>buttonsList;
  var player1;
  var player2;
  var activePlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonsList = doInit();
  }
  List<GameButton> doInit(){
    player1 = [];
    player2 = [];
    activePlayer = 1;
    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gb){
    setState(() {
      if(activePlayer==1){
        gb.text="x";
        gb.bg=Colors.red;
        activePlayer=2;
        player1.add(gb.id);
      }
      else{
        gb.text="0";
        gb.bg=Colors.black;
        activePlayer=1;
        player2.add(gb.id);
      }
      gb.enabled=false;
      int winner = checkWinner();
      if(winner==-1){
        if(buttonsList.every((p)=>p.text!="")){
          showDialog(context: context, builder: (_)=>CustomDialog("Game Tied", "Press the Reset Button to start again.", resetGame));
        }
        else{
          activePlayer==2?autoPlay():null;
        }
      }
    });
  }

  void autoPlay(){
    var emptyCells = [];
    var list= List.generate(9, (i)=>i+1);
    for(var cellID in list){
      if(!(player1.contains(cellID))||(player2.contains(cellID))){
        emptyCells.add(cellID);
      }
    }
    var r = Random();
    var randIndex = r.nextInt(emptyCells.length-1);
    var cellID = emptyCells[randIndex];
    int i = buttonsList.indexWhere((p)=>p.id==cellID);
    playGame(buttonsList[i]);
  }

  int checkWinner(){
    var winner = -1;

    // Row 1
    if(player1.contains(1)&&player1.contains(2)&&player1.contains(3)){
      winner=1;
    }
    if(player2.contains(1)&&player2.contains(2)&&player2.contains(3)){
      winner=2;
    }
    // Row 2
    if(player1.contains(4)&&player1.contains(5)&&player1.contains(6)){
      winner=1;
    }
    if(player2.contains(4)&&player2.contains(5)&&player2.contains(6)){
      winner=2;
    }
    // Row 3
    if(player1.contains(7)&&player1.contains(8)&&player1.contains(9)){
      winner=1;
    }
    if(player2.contains(7)&&player2.contains(8)&&player2.contains(9)){
      winner=2;
    }
    // Column 1
    if(player1.contains(1)&&player1.contains(4)&&player1.contains(7)){
      winner=1;
    }
    if(player2.contains(1)&&player2.contains(4)&&player2.contains(7)){
      winner=2;
    }
    // Column 2
    if(player1.contains(2)&&player1.contains(5)&&player1.contains(8)){
      winner=1;
    }
    if(player2.contains(2)&&player2.contains(5)&&player2.contains(8)){
      winner=2;
    }
    // Column 3
    if(player1.contains(3)&&player1.contains(6)&&player1.contains(9)){
      winner=1;
    }
    if(player2.contains(3)&&player2.contains(6)&&player2.contains(9)){
      winner=2;
    }
    // Left Diagonal
    if(player1.contains(1)&&player1.contains(5)&&player1.contains(9)){
      winner=1;
    }
    if(player2.contains(1)&&player2.contains(5)&&player2.contains(9)){
      winner=2;
    }
    // Right Diagonal
    if(player1.contains(3)&&player1.contains(5)&&player1.contains(7)){
      winner=1;
    }
    if(player2.contains(3)&&player2.contains(5)&&player2.contains(7)){
      winner=2;
    }

    if(winner !=-1){
      if(winner==1){
        showDialog(
            context: context, 
            builder: (_)=>CustomDialog("Player 1 Won", "Press the reset button to start again.", resetGame)
            );
      }else{
        showDialog(
            context: context,
            builder: (_)=>CustomDialog("Player 2 Won", "Press the reset button to start again.", resetGame)
        );
      }
    }
    return winner;
  }

  void resetGame(){
    if(Navigator.canPop(context))Navigator.pop(context);
    setState(() {
      buttonsList=doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: buttonsList.length,
                  itemBuilder: (context,i)=>SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: buttonsList[i].enabled?()=>playGame(buttonsList[i]):null,
                        child:Text(buttonsList[i].text,style: TextStyle(color: Colors.white,fontSize: 20.0),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: buttonsList[i].bg,
                            disabledBackgroundColor: buttonsList[i].bg,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // Square corners
                          ),
                        ),
                      ),
                    ),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 9.0,
                    mainAxisSpacing: 9.0,
                  )
              ),
            ),
          ),
          ElevatedButton(
              onPressed: resetGame,
              child: Text("Reset",style: TextStyle(color: Colors.white,fontSize: 20.0 ),),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          )
        ],
      )
    );
  }
}
