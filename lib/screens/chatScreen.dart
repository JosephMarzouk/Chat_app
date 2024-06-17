import 'package:chat_app/constants.dart';
import 'package:chat_app/models/messageModel.dart';
import 'package:chat_app/screens/Cubits/cubit/chat_cubit.dart';
import 'package:chat_app/widgets/BbubbleChat.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  final _controller = ScrollController();
  String id = 'ChatScreen';
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  TextEditingController controller = TextEditingController();
  List<Message> messagesList = [];
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/images/scholar.png',
            height: 50,
          ),
          const Text('chat')
        ]),
        centerTitle: true,
        backgroundColor: KPrimaryColor,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              
              builder: (context, state) {
                var messageList=BlocProvider.of<ChatCubit>(context).messageList;
                return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? BubbleChat(
                              message: messageList[index],
                            )
                          : BubbleChatForFriend(message: messageList[index]);
                    });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (value) {
                messages.add({
                  'message': value,
                  'createdAt': DateTime.now(),
                  'id': email
                });
                controller.clear();
                _controller.animateTo(0,
                    duration: Duration(seconds: 1), curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                  hintText: 'Send Message',
                  suffixIcon: GestureDetector(
                    child: IconButton(
                      onPressed: () async {
                        if (controller.text.isNotEmpty) {
                          await messages.add({
                            'message': controller.text,
                            'createdAt': DateTime.now(),
                            'id': email,
                          });

                          // Clear the text field after sending the message
                          controller.clear();

                          // Scroll to the top of the list view
                          _controller.animateTo(
                            0,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                      icon: Icon(Icons.send),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: KPrimaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: KPrimaryColor))),
            ),
          ),
        ],
      ),
    );
  }
}
