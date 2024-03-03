import 'package:chat_app/constants.dart';
import 'package:chat_app/models/messageModel.dart';
import 'package:chat_app/widgets/BbubbleChat.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  String id = 'ChatScreen';

  ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }

            return Scaffold(
              appBar: AppBar(
                title:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].id == email
                              ? BubbleChat(
                                  message: messagesList[index],
                                )
                              : BubbleChatForFriend(
                                  message: messagesList[index]);
                        }),
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
                            duration: Duration(seconds: 1),
                            curve: Curves.easeIn);
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
          } else {
            return Text('Loading');
          }
        });
  }
}
