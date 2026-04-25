import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/network/chat_services.dart';
import 'chat_test.dart';

class ChatListScreen extends StatelessWidget {
  final String myId;
  final ChatService _chatService = ChatService();

  ChatListScreen({super.key, required this.myId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: _chatService.getChatRooms(myId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
                child: Text(
              'Failed to load chat',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          var docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
                child: Text(
              'No messages yet',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data() as Map<String, dynamic>;

              // 1. استخراج الـ ID بتاع الشخص الآخر في المحادثة
              List<dynamic> users = data['users'] ?? [];
              String otherUserId = users
                  .firstWhere((id) => id.toString() != myId, orElse: () => "")
                  .toString();

              if (otherUserId.isEmpty) return const SizedBox.shrink();

              return ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(otherUserId)
                      .get(),
                  builder: (context, userSnapshot) {
                    String? imageUrl;
                    if (userSnapshot.hasData && userSnapshot.data!.exists) {
                      var userData =
                          userSnapshot.data!.data() as Map<String, dynamic>;
                      imageUrl = userData['imageUrl'];
                    }

                    return CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blueAccent,
                      // التحقق إذا كانت الصورة موجودة وليست فارغة
                      backgroundImage: (imageUrl != null && imageUrl.isNotEmpty)
                          ? NetworkImage(imageUrl)
                          : null,
                      // إذا لم تكن هناك صورة (null)، يظهر الأيقونة كـ child
                      child: (imageUrl == null || imageUrl.isEmpty)
                          ? const Icon(Icons.person,
                              color: Colors.white, size: 30)
                          : null,
                    );
                  },
                ),
                // 2. جلب الاسم من مجموعة الـ users بناءً على الـ ID
                title: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(otherUserId)
                      .get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.hasData && userSnapshot.data!.exists) {
                      var userData =
                          userSnapshot.data!.data() as Map<String, dynamic>;
                      return Text(
                        userData['name'] ?? 'مستخدم غير معروف',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      );
                    }

                    return Text(
                      'Loading',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    );
                  },
                ),
                // 3. عرض آخر رسالة
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    data['lastMessage'] ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                // 4. عرض الوقت
                trailing: Text(
                  data['lastTimestamp'] != null
                      ? _formatTimestamp(data['lastTimestamp'] as Timestamp)
                      : '',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChatScreenTest(myId: myId, receiverId: otherUserId),
                    ),
                  );
                },
              );
            },
          )
              .animate()
              .fade(duration: 400.ms)
              .slideX(begin: 0.05, curve: Curves.easeOut);
        },
      ),
    );
  }

  String _formatTimestamp(Timestamp timestamp) {
    var date = timestamp.toDate();
    int hour = date.hour > 12 ? date.hour - 12 : date.hour;
    if (hour == 0) hour = 12;
    String period = date.hour >= 12 ? "PM" : "AM";
    String minutes = date.minute.toString().padLeft(2, '0');
    return "$hour:$minutes $period";
  }
}
