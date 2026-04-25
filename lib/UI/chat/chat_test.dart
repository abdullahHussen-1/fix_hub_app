import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../core/network/chat_services.dart';
import '../../shared/custem_text_form_field.dart';

class ChatScreenTest extends StatefulWidget {
  final String receiverId;
  final String myId;

  const ChatScreenTest(
      {super.key, required this.receiverId, required this.myId});

  @override
  State<ChatScreenTest> createState() => _ChatScreenTestState();
}

class _ChatScreenTestState extends State<ChatScreenTest> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        senderId: widget.myId,
        receiverId: widget.receiverId,
        message: _messageController.text,
      );
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundBlue,
        elevation: 1,
        leadingWidth: 70,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              const SizedBox(width: 8),
              const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              const SizedBox(width: 4),
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.receiverId)
                    .get(),
                builder: (context, snapshot) {
                  String? img;
                  if (snapshot.hasData && snapshot.data!.exists) {
                    var data = snapshot.data!.data() as Map<String, dynamic>;
                    img = data['imageUrl'];
                  }
                  return CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.blueAccent,
                    backgroundImage: (img != null && img.isNotEmpty)
                        ? NetworkImage(img)
                        : null,
                    child: (img == null || img.isEmpty)
                        ? const Icon(Icons.person,
                            color: Colors.white, size: 18)
                        : null,
                  );
                },
              ),
            ],
          ),
        ),
        title: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.receiverId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.exists) {
              var userData = snapshot.data!.data() as Map<String, dynamic>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData['name'] ?? 'User',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }
            return const Text('Loading...',
                style: TextStyle(color: Colors.black, fontSize: 16));
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _chatService.getMessages(widget.myId, widget.receiverId),
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return const Center(
                      child: Text(
                    'Error loading messages',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ));
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  children: snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data =
                        doc.data() as Map<String, dynamic>;
                    bool isMe = data['senderId'] == widget.myId;

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: isMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          // فقاعة الرسالة (Message Bubble)
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.75),
                            decoration: BoxDecoration(
                              color: isMe ? Colors.blueAccent : Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(16),
                                topRight: const Radius.circular(16),
                                bottomLeft: isMe
                                    ? const Radius.circular(16)
                                    : Radius.zero,
                                bottomRight: isMe
                                    ? Radius.zero
                                    : const Radius.circular(16),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              data['message'],
                              style: TextStyle(
                                  color: isMe ? Colors.white : Colors.black87,
                                  fontSize: 15),
                            ),
                          ),

                          // عرض الوقت تحت الرسالة
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              data['timestamp'] != null
                                  ? _formatTimestamp(
                                      data['timestamp'] as Timestamp)
                                  : '',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 10,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: CustemTextFormField(
                    borderSideColor: AppColors.primaryBackgroundBlue,
                    text: "Type a message...",
                    controller: _messageController,
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(Timestamp? timestamp) {
    if (timestamp == null) return "";
    DateTime date = timestamp.toDate();

    int hour = date.hour > 12 ? date.hour - 12 : date.hour;

    if (hour == 0) hour = 12;

    String period = date.hour >= 12 ? "PM" : "AM";
    String minutes = date.minute.toString().padLeft(2, '0');

    return "$hour:$minutes $period";
  }
}
