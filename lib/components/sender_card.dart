

import 'package:enyata_chat/models/message.dart';
import 'package:flutter/material.dart';

import '../utils/formaters.dart';

class SenderCard extends StatelessWidget {
  const SenderCard({
    Key? key, required this.message
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.only(topRight: Radius.circular(16),
                  bottomLeft:  Radius.circular(16), topLeft:  Radius.circular(16))
          ),
          child: ListTile(
            title: Text(message.sender,style: const TextStyle(color: Colors.white)),
            subtitle: Text(message.message,style: const TextStyle(color: Colors.white70)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(Converter.formatTimestampToTimeAgo(message.modifiedAt),style: const TextStyle(color: Colors.grey),),
              const Icon(Icons.check, color: Colors.deepPurple,)
            ],
          ),
        ),
      ],
    );
  }
}
