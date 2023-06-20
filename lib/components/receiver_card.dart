

import 'package:enyata_chat/models/message.dart';
import 'package:flutter/material.dart';

import '../utils/formaters.dart';

class ReceiverCard extends StatelessWidget {
  const ReceiverCard({
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
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(16),
                  bottomLeft:  Radius.circular(16), bottomRight:  Radius.circular(16))
          ),
          child: ListTile(
            title: Text(message.sender),
            subtitle: Text(message.message),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(Converter.formatTimestampToTimeAgo(message.modifiedAt),style: const TextStyle(color: Colors.grey),),
        ),
      ],
    );
  }
}
