import 'package:flutter/material.dart';
import 'package:fyp/view/history.dart';

import '../main.dart';
import '../model/counterModel.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int counter = 0;
  List<CounterModel> count = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(prefs.getInt("counter")!=null)
      {
        counter=prefs.getInt("counter")!;
      }
    get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/tasbeeh_bg.png"), fit: BoxFit.fill)),
        child:  SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                ),
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$counter",
                          style: const TextStyle(fontSize: 60, color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0, top: 16.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => History()))
                                  .then((value) {
                                    if(value!=null)
                                      {
                                        counter=value;
                                      }
                                    setState(() {
                                    });
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.amberAccent),
                              child: const Icon(
                                Icons.history,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 52.0, bottom: 8.0),
                  child: Container(
                    height: 285,
                    width: 285,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(color: Colors.amberAccent)),
                    child: IconButton(
                        onPressed: () {
                          // print(counter);
                          setState(() {
                            counter++;
                          });
                          prefs.setInt("counter", counter);
                        },
                        icon: Text(
                          "Count",
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        _displayTextInputDialog(context);
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
                          child: Center(child: Text("Save")))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                      onTap: () {
                        setState(() {
                          counter = 0;
                        });
                        prefs.setInt("counter", counter);
                      },
                      child: Container(
                          alignment: Alignment.bottomRight,
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(child: Text("Reset")))),
                ),
              ],
            ),
        ),
        
      ),
    );
  }

  void get() {
    if (prefs.getString("count") != null) {
      count = sharepreferenceFromJson(prefs.getString("count")!);
    }
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    var _textFieldController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              backgroundColor: Colors.transparent,

              // title: Text(style: TextStyle(color: Colors.yellow,fontSize: 20),'Enter Text'),
              content: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255,21,71,52),
                  borderRadius:
                  BorderRadius.all(Radius.circular(15)),
                ),
                height: 200,
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(style: TextStyle(color: Colors.yellow,fontSize: 20),'Enter Text'),
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),


                        controller: _textFieldController,
                        decoration:  InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.yellow,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow),
                          ),


                          hintStyle: TextStyle(color: Colors.yellow),
                          hintText: "Your Choice",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: InkWell(
                            onTap: () {
                              if (_textFieldController.text.isNotEmpty) {
                                _displayTextInputDialog(context);
                                count.add(CounterModel(
                                    name: _textFieldController.text,
                                    quantity: counter));
                                setState(() {
                                  counter = 0;
                                });
                                prefs.setInt("counter", counter);
                                prefs.setString(
                                    "count", sharepreferenceToJson(count));
                                Navigator.pop(context);
                                Navigator.pop(context);
                                // Navigator.pop(context);
                              }

                              // print(  count.length);
                            },
                            child: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    border: Border.all(color: Colors.yellow)),
                                child: Center(child: Text(style: TextStyle(color: Colors.yellow), "Save")))),
                      ),
                    ],
                  ),
                ),
              ),
            );
        });
  }
}
