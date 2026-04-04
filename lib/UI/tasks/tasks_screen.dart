import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/shared/custom_text.dart';
import 'package:flutter/material.dart';

import '../../core/network/api_error.dart';
import '../../shared/custom_appBar.dart';
import 'data/task_model.dart';
import 'data/task_repo.dart';
import 'widgets/custom_task_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final TaskRepo repo = TaskRepo();

  List<TaskModel> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    setState(() => isLoading = true);

    try {
      tasks = await repo.getTasks();
    } catch (e) {
      String msg = "Error";
      if (e is ApiError) msg = e.message;

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }

    setState(() => isLoading = false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          CustomAppbar(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : tasks.isEmpty
                    ? const Center(child:CustomText(text: 'No Works Available', fontsize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryBackgroundBlue))
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final item = tasks[index];

                          return CustomContainer(
                            name: item.userName,
                            image: item.userImage,
                            description: item.description,
                            address: item.address,
                            onReply: () => Navigator.pushNamed(context, AppRoute.chatScreen)
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
