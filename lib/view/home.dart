import 'package:flutter/material.dart';
import 'package:fyp/view/alarm.dart';
import 'package:fyp/view/counter.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:fyp/model/theme_data.dart';

import 'chatroom.dart';

class Home extends StatefulWidget {
  Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int select = 1;
  var home;
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    select = 1;
    home = ChatRoom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageView(
          controller: _controller,
          children: <Widget>[
            ChatRoom(),
            Counter(),
            Alarm(),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            // color: Colors.white,
            // border: Border.all(),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 15),
            ]
        ),
        child: RollingBottomBar(
          color: Color(0xFFEAECFF),
          controller: _controller,
          flat: true,
          useActiveColorByDefault: false,
          items: const [
            RollingBottomBarItem(Icons.android,
                label: 'Bot', activeColor: Colors.pinkAccent),
            RollingBottomBarItem(Icons.add_box_outlined,
                label: 'Tasbi', activeColor: Colors.amber),
            RollingBottomBarItem(Icons.mosque,
                label: 'Azan', activeColor: Colors.lightGreen),
          ],
          enableIconRotation: true,
          onTap: (index) {
            _controller.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
            );
          },
        ),
      ),
    );
  }
}
