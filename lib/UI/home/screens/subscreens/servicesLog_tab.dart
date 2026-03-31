import 'package:fix_hub/UI/home/widgets/custom_servicesLog_card.dart';
import 'package:flutter/material.dart';

class ServicesLogTab extends StatelessWidget {
  const ServicesLogTab({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة تجريبية لسجل الخدمات
    final logs = [
      {
        'title': 'CCTV System Installation - Downtown Office',
        'date': '15 Dec 2023',
        'type': 'Camera Tech'
      },
      {
        'title': 'Logo Design and Branding - Tech Startup',
        'date': '10 Dec 2023',
        'type': 'Graphic Design'
      },
      {
        'title': 'Annual Maintenance of Surveillance Cameras',
        'date': '28 Nov 2023',
        'type': 'Camera Tech'
      },
      {
        'title': 'Poster Design for Local Event',
        'date': '18 Nov 2023',
        'type': 'Graphic Design'
      },
    ];

    return ListView.builder(
      itemCount: logs.length,
      padding: const EdgeInsets.only(top: 8),
      itemBuilder: (context, index) {
        final log = logs[index];
        return LogCard(
          title: log['title'] as String,
          date: log['date'] as String,
          type: log['type'] as String,
        );
      },
    );
  }
}
