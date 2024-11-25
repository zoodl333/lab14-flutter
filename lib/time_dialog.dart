import 'package:flutter/material.dart';

class TimeDialog extends StatelessWidget {
  final String time;

  const TimeDialog({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Image.network(
        'https://emojiisland.com/cdn/shop/products/Robot_Emoji_Icon_abe1111a-1293-4668-bdf9-9ceb05cff58e_large.png?v=1571606090',
        width: 50,
        height: 50,
      ),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        const Text('Current Time'),
        Text(time)
      ],),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}