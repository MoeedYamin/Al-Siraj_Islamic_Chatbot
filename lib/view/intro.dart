import 'package:flutter/material.dart';

import 'home.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage("assets/alarmback.png")),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Welcome to AL-Siraj",
                        style: TextStyle(fontWeight:FontWeight.bold,fontSize: 35,color: Colors.amberAccent),
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Its an Islamic Chatbot to aid you with your queries",
                        style: TextStyle(fontSize:16,color: Colors.white),
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "You can ask anything to it related to Islam",
                        style: TextStyle(fontSize:16,color: Colors.white),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "It is more effective and efficient",
                        style: TextStyle(fontSize:16,color: Colors.white),
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "We are facing difficulties related to Islam nowadays",
                        style: TextStyle(fontSize:16,color: Colors.white),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Its is here to assist you!",
                        style: TextStyle(fontSize:16,color: Colors.white),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "It also has Tasbih too, to remember your deeds",
                        style: TextStyle(fontSize:16,color: Colors.white),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Azan alarm is also here to remind you your prayers",
                        style: TextStyle(fontSize:16,color: Colors.white),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(
                                    title: 'Al-Siraj',
                                  )));
                    },
                    child: Container(
                        alignment: Alignment.bottomLeft,
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          // border: Border.all()
                        ),
                        child: const Center(
                            child: Text(
                          "Let's Go!",
                          style: TextStyle(fontSize:18,color: Colors.black),
                        )))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
