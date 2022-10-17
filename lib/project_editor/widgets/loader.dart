import 'package:flutter/material.dart';

class Loader{
  BuildContext context;

  Loader({required this.context});
  Future<void> showMyDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: Color(0xFFF39530),),
                SizedBox(height: 4,),
                Text("Loading"),
              ],
            ),
          ),
        );
      },
    );
  }
}