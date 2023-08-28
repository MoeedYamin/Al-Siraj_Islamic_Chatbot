import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp/main.dart';
import 'package:fyp/model/theme_data.dart';
import 'package:http/http.dart' as http;

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  var controller = TextEditingController();
  bool load = false;
  List<String> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (prefs.getStringList("Chat_Bot") != null) {
      list = prefs.getStringList("Chat_Bot")!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: (WidgetsBinding.instance.window.viewInsets.bottom > 0.0)
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.height - 100,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/alarmback.png"), fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 35),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration:  BoxDecoration(gradient: sky),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Text("Chat With AL-SIRAJ",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold)),
                            )),
                        Expanded(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        alignment: Alignment.topRight,
                                        insetPadding: const EdgeInsets.only(
                                            left: 0.0, top: 50, right: 0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          decoration: BoxDecoration(gradient: sunset,borderRadius: BorderRadius.circular(18)),
                                            // width: 100,
                                            // height: 200,
                                            // alignment: Alignment.topRight,
                                            margin: EdgeInsets.only(
                                                top: 5.0, right: 10.0),
                                            child: TextButton(
                                              child: Text(style: TextStyle(color: Colors.black,fontSize: 18),"Clear Chat"),
                                              onPressed: () {
                                                setState(() {
                                                  list = [];
                                                  prefs.setStringList(
                                                      "Chat_Bot", list);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),

                                      );

                                    },
                                  );
                                },
                                icon: Icon(Icons.more_vert))
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: (index.isEven)
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                  color: (index.isEven)
                                      ? Color(0xFFEAECFF)
                                      : Color.fromRGBO(250, 216, 78, 1),
                                  borderRadius: (index.isEven)
                                      ? BorderRadius.only(
                                          bottomLeft: Radius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3),
                                          topLeft: Radius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3),
                                          topRight: Radius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  3),
                                        )
                                      : BorderRadius.only(
                                          bottomLeft: Radius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  25),
                                          topRight: Radius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  25),
                                          bottomRight: Radius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  25),
                                        ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        // overflow: TextOverflow.ellipsis,

                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.black),
                                        list[index]),
                                  )),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: list.length,
                  ),
                ),
                Container(
                    color: Colors.amberAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                            controller: controller,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: "Ask me",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                          )),
                          (load)
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFEAECFF)),
                                  child: Center(
                                      child: IconButton(
                                          onPressed: () async {
                                            if (controller.text.isNotEmpty) {
                                              setState(() {
                                                load = true;
                                              });
                                              var map = Map<String, String>();
                                              map['input'] = controller.text;
                                              print(jsonEncode(map));
                                              var response = await http.post(
                                                Uri.parse(
                                                    "https://orbital-avatar-389808.de.r.appspot.com/chatbot"),
                                                headers: <String, String>{
                                                  'Content-Type':
                                                      'application/json; charset=UTF-8',
                                                },
                                                body: jsonEncode(map),
                                              );
                                              print(
                                                  'Response status: ${response.statusCode}');
                                              print(
                                                  'Response body: ${response.body}');
                                              var a = jsonDecode(response.body);
                                              list.add(controller.text);
                                              list.add(a["response"]);
                                              prefs.setStringList(
                                                  "Chat_Bot", list);
                                              setState(() {
                                                controller.text = "";
                                                load = false;
                                              });
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Please enter Message");
                                            }
                                          },
                                          icon: Icon(Icons.send))))
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
