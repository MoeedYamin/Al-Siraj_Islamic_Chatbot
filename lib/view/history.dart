import 'package:flutter/material.dart';

import '../main.dart';
import '../model/counterModel.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int counter = 0;
  List<CounterModel> count = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/tasbeeh_bg.png"), fit: BoxFit.fill)),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(count[index].quantity);
                        },
                        child: Container(
                            height: 50,
                            padding:
                                const EdgeInsets.only(left: 4.5, bottom: 2.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.yellow)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "${count[index].name} : ",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                color: Colors.yellow, fontSize: 25),
                                          ),
                                        ),
                                        Text(
                                          "${count[index].quantity}",
                                          style: TextStyle(
                                              color: Colors.yellow, fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                 Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: IconButton(
                                        onPressed: () {
                                          count.removeAt(index);
                                          prefs.setString("count",
                                              sharepreferenceToJson(count));
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.yellow,
                                        )),
                                  ),

                              ],
                            )),
                      ),
                    );
                  },
                  itemCount: count.length,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow, shape: BoxShape.circle),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back))),
            )
          ],
        ),
      ),
    );
  }

  void get() {
    if (prefs.getString("count") != null)
      count = sharepreferenceFromJson(prefs.getString("count")!);
    // print(count.length);
  }
}
