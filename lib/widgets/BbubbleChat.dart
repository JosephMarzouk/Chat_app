import 'package:chat_app/constants.dart';
import 'package:chat_app/models/messageModel.dart';
import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  const BubbleChat({required this.message,
    super.key,
  });
final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal:16,vertical: 25),
          margin: EdgeInsets.symmetric(horizontal:16,vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(32),topRight: Radius.circular(32),bottomLeft: Radius.circular(32)),
            color: KPrimaryColor
          ),
          child: Center(child: Text(message.message,style: TextStyle(color: Colors.white),),),
        ),
      ),
    );
  }
}



class BubbleChatForFriend extends StatelessWidget {
  const BubbleChatForFriend({required this.message,
    super.key,
  });
final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal:16,vertical: 25),
          margin: EdgeInsets.symmetric(horizontal:16,vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(32),topRight: Radius.circular(32),bottomRight: Radius.circular(32)),
            color: Colors.blueAccent
          ),
          child: Center(child: Text(message.message,style: TextStyle(color: Colors.white),),),
        ),
      ),
    );
  }
}
