import 'package:fix_hub/UI/home/data/models/craftsmans_model.dart';
import 'package:fix_hub/UI/home/widgets/custom_craftMans_list_card.dart';
import 'package:fix_hub/core/constants/app_colors.dart';
import 'package:fix_hub/core/constants/app_route.dart';
import 'package:fix_hub/core/utils/pref_helper.dart';
import 'package:fix_hub/shared/custom_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
class CraftsMansListScreen extends StatefulWidget {
  const CraftsMansListScreen({super.key});

  @override
  State<CraftsMansListScreen> createState() => _CraftsMansListScreenState();
}

class _CraftsMansListScreenState extends State<CraftsMansListScreen> {
  List<Technician> technicians = [];
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final category = ModalRoute.of(context)!.settings.arguments as String;

    loadData(category);
  }

  Future<void> loadData(String category) async {
    final data = await PrefHelper.getByCategory(category);

    setState(() {
      technicians = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomAppbar(onTap: () {}, text: ''),
              const Gap(20),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (technicians.isEmpty)
                const Center(child: Text("No technicians yet"))
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: technicians.length,
                    itemBuilder: (context, index) {
                      final tech = technicians[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.craftsMansDetailsScreen,
                            arguments: tech,
                          );
                        },
                        child: CustomCategoryDetailesCard(
                          image: Icons.person,
                          name: tech.name,
                          about: tech.city,
                        ),
                      )
                          .animate()
                          .fade(duration: 800.ms)
                          .scale(delay: (index * 100).ms, duration: 400.ms);
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
