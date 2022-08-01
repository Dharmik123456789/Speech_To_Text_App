import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stts;

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  var speechtotext = stts.SpeechToText();
  bool islisteing = true;
  String text = "Plz Press The Button For Speaking...";
  void listen() async {
    if(islisteing)
      {
      bool available =await  speechtotext.initialize(
          onStatus: (status) => print("$status"),
          onError: (errorNotification) => print("$errorNotification"),
        );
      if(available)
        {
          setState(() {
            islisteing = true;
          });
          speechtotext.listen(
            onResult: (result) => setState(() {
              text = result.recognizedWords;
            }),
          );
        }
      }
    else
      {
        setState(() {
          islisteing = false;
        });
        speechtotext.stop();
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    speechtotext = stts.SpeechToText();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speech_To_Text_Apps",style: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: 23,
          color: Colors.white
        ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlueAccent,
            ),),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: islisteing,
        repeat: true,
        duration: Duration(milliseconds: 1000),
        endRadius: 80,
        glowColor: Colors.lightGreenAccent,
        child: FloatingActionButton(
          onPressed: (){
            listen();
          },
          child: Icon(islisteing ? Icons.mic : Icons.mic_none,color: Colors.white,),
        ),
      ),
    );
  }
}
