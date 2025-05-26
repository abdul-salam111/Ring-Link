import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ring_link/utils/context_ext.dart';
import 'package:ring_link/utils/num_txt.dart';

class Message {
  final String text;
  final String time;
  final bool isMe;

  Message({required this.text, required this.time, required this.isMe});
}

class SingleChatScreen extends StatefulWidget {
  const SingleChatScreen({super.key});

  @override
  State<SingleChatScreen> createState() => _SingleChatScreenState();
}

class _SingleChatScreenState extends State<SingleChatScreen> {
  final TextEditingController _controller = TextEditingController();

  List<Message> messages = [
    Message(
        text:
            'Hey Coach Bradley Lawlor,I’m looking to improve my grappling skills. Do you have any availability this week?',
        time: '01:15 PM',
        isMe: true),
    Message(
        text:
            'Hey Maria,Sounds great. I have openings on Tuesday & Thursday evening. Which works for you',
        time: '01:15 PM',
        isMe: false),
    Message(
        text: 'Thursday works for me! What’s your rate for an hour',
        time: '01:15 PM',
        isMe: true),
    Message(
        text:
            'My standard rate is 80/hr, but I offer a first-session discount of 20%. Let me know if you’d like to book!',
        time: '01:15 PM',
        isMe: false),
  ];

  void sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      messages
          .add(Message(text: _controller.text.trim(), time: 'Now', isMe: true));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final myImage =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUbxBmNuEWRnSeavusNsXAJQY-tSNCA7Qr_A&s';

    return Scaffold(
      body: Column(
        children: [
          40.heightBox,
          // Top Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: context.screenWidth * 0.08,
                  height: context.screenHeight * 0.04,
                  decoration: BoxDecoration(
                    color: const Color(0xff212429),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Breadly Lawlor',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: context.screenHeight * 0.02,
                            width: context.screenWidth * 0.02,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
                          7.widthBox,
                          Text(
                            'Active Now',
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 16,
                  backgroundImage: CachedNetworkImageProvider(myImage),
                )
              ],
            ),
          ),
          const Divider(),
          20.heightBox,
          // Chat Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isMe = message.isMe;
                return Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        if (!isMe)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 60),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(myImage),
                            ),
                          ),
                        if (!isMe) 10.widthBox,
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          constraints: const BoxConstraints(maxWidth: 250),
                          decoration: BoxDecoration(
                            color: isMe
                                ? const Color(0xff1c1f23)
                                : const Color(0xff496ef3),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(isMe ? 10 : 0),
                              topRight: Radius.circular(isMe ? 0 : 10),
                              bottomLeft: const Radius.circular(10),
                              bottomRight: const Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                        if (isMe) 10.widthBox,
                        if (isMe)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(myImage),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: isMe ? 0 : 40, right: isMe ? 40 : 0),
                      child: Row(
                        mainAxisAlignment: isMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Text(message.time,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.grey[400])),
                          if (isMe)
                            const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(Icons.done_all,
                                  size: 15, color: Colors.green),
                            )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),

          // Message Input
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _controller,
              onFieldSubmitted: (_) => sendMessage(),
              decoration: InputDecoration(
                hintText: 'Type Message',
                hintStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const CircleBorder(),
                    ),
                  ),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.share, color: Colors.white),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const CircleBorder(),
                    ),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide:
                      const BorderSide(color: Colors.white60, width: 0.2),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
