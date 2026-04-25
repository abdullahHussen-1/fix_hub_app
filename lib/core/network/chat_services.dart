import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ----------------------------------------------------------
  // دالة جديدة: حفظ أو تحديث بيانات المستخدم في Firebase
  // نادي الدالة دي أول ما اليوزر يعمل تسجيل دخول بنجاح من الـ API بتاعك
  // ----------------------------------------------------------
  Future<void> saveUserToFirebase({
    required String uid,
    required String name,
    String? email,
    String? imageUrl,
    required String role, // 'user' or 'technician'
  }) async {
    await _firestore.collection('users').doc(uid).set(
        {
          'uid': uid,
          'name': name,
          'email': email ?? '',
          'imageUrl': imageUrl ?? '',
          'role': role,
          'lastSeen': FieldValue.serverTimestamp(),
        },
        SetOptions(
            merge:
                true)); // merge: true عشان لو البيانات موجودة يحدثها بس ميشلهاش
  }

  // 1. إرسال رسالة (كما هي مع إضافة بسيطة للـ LastMessage)
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
    String type = 'text',
    String fileUrl = '',
  }) async {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add({
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'type': type,
      'fileUrl': fileUrl,
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false,
    });

    await _firestore.collection('chat_rooms').doc(chatRoomId).set({
      'lastMessage': message,
      'lastTimestamp': FieldValue.serverTimestamp(),
      'users': ids,
    }, SetOptions(merge: true));
  }

  // 2. استقبال الرسايل
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // 3. جلب قائمة المحادثات
  Stream<QuerySnapshot> getChatRooms(String myId) {
    return _firestore
        .collection('chat_rooms')
        .where('users', arrayContains: myId)
        .orderBy('lastTimestamp', descending: true)
        .snapshots();
  }

  // أضف هذه الدالة داخل كلاس ChatService
  Future<void> updateUserDataInFirebase({
    required String uid,
    required String name,
    String? imageUrl,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'name': name,
      'imageUrl': imageUrl ?? '',
      'lastSeen': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}

/*class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1. إرسال رسالة
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String message,
    String type = 'text',
    String fileUrl = '',
  }) async {
    // بناء معرّف فريد للغرفة بين الشخصين (دايماً الصغير قبل الكبير عشان نضمن إنها نفس الغرفة)
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    // إضافة الرسالة في الـ Sub-collection
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add({
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'type': type,
      'fileUrl': fileUrl,
      'timestamp': FieldValue.serverTimestamp(),
      'isRead': false,
    });

    // تحديث آخر رسالة في الغرفة (عشان القائمة الرئيسية بره)
    await _firestore.collection('chat_rooms').doc(chatRoomId).set({
      'lastMessage': message,
      'lastTimestamp': FieldValue.serverTimestamp(),
      'users': ids,
    }, SetOptions(merge: true));
  }

  // 2. استقبال الرسايل (Stream) عشان التحديث اللحظي
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // جلب قائمة بجميع الأشخاص الذين تحدثت معهم، مرتبة بالأحدث
  Stream<QuerySnapshot> getChatRooms(String myId) {
    return _firestore
        .collection('chat_rooms')
        .where('users', arrayContains: myId) // بجيب الغرف اللي أنا طرف فيها
        .orderBy('lastTimestamp', descending: true) // الترتيب حسب أحدث رسالة
        .snapshots();
  }
}*/
