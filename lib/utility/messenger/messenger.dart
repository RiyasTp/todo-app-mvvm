import 'package:flutter/material.dart';
class Messenger {
  static final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static alert({required String msg, Color? color}) {
    if(msg.trim().isEmpty) return;
    rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        showCloseIcon: true,
        closeIconColor: Colors.white,
        duration: const Duration(milliseconds: 2500),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        shape: const RoundedRectangleBorder(),
        // margin: EdgeInsets.only(bottom: size.height - 78, right: 0, left: 0),
        // dismissDirection: DismissDirection.up,
        content: Text(
          msg,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  static pop(BuildContext context) {
    showModalBottomSheet<void>(
      constraints: const BoxConstraints.expand(),
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.blue[100],
          child: ListView.builder(
            // controller: scrollController,
            itemCount: 25,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text('Item $index'));
            },
          ),
        );
      },
    );
  }
}
