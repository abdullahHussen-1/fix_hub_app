// lib/UI/tasks/tasks_screen.dart
import 'package:fix_hub/core/network/chat_services.dart';
import 'package:fix_hub/core/utils/pref_helper.dart';
import 'package:fix_hub/shared/custom_snackBar.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';

import '../../shared/custom_appBar.dart';
import '../chat/chat_test.dart';
import 'data/task_model.dart';
import 'widgets/custom_task_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

// lib/UI/tasks/tasks_screen.dart

class _TasksScreenState extends State<TasksScreen> {
  List<TaskModel> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    setState(() => isLoading = true);
    final myId = await PrefHelper.getCurrentUserId();
    if (myId != null) {
      tasks = await PrefHelper.getTasksByTech(myId);
    }
    setState(() => isLoading = false);
  }

  // دالة رفض الطلب
  Future<void> _declineTask(String taskId) async {
    await PrefHelper.deleteTask(taskId);
    fetchTasks(); // إعادة تحميل البيانات لتحديث الشاشة
    ScaffoldMessenger.of(context)
        .showSnackBar(customSnackBar("Request declined and removed"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            CustomAppbar(onTap: () {}, text: "My Assignments"),
            const SizedBox(height: 10),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : tasks.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.assignment_late_outlined,
                                  size: 80, color: Colors.grey.shade400),
                              const SizedBox(height: 10),
                              CustomText(
                                text: 'No Work Requests Available',
                                fontsize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final item = tasks[index];
                            return CustomContainer(
                                name: item.userName,
                                description: item.description,
                                address: item.address,
                                date: item.date,
                                time: item.time,
                                onReply: () async {
                                  String? myId =
                                      await PrefHelper.getCurrentUserId();
                                  String? receiverId = item.userId;
                                  ChatService().sendMessage(
                                      senderId: myId ?? "null",
                                      receiverId: receiverId,
                                      message:
                                          "Your request has been accepted");

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreenTest(
                                            receiverId: receiverId,
                                            myId: myId ?? "null"),
                                      ));
                                  _declineTask(item.id);
                                },
                                onDecline: () async {
                                  String? myId =
                                      await PrefHelper.getCurrentUserId();
                                  String? receiverId = item.userId;
                                  ChatService().sendMessage(
                                      senderId: myId ?? "null",
                                      receiverId: receiverId,
                                      message:
                                          "Your request has been rejected");

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreenTest(
                                            receiverId: receiverId,
                                            myId: myId ?? "null"),
                                      ));
                                  _declineTask(item.id);
                                });
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
