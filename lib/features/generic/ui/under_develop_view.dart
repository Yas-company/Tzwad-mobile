import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';

class UnderDevelopView extends StatelessWidget {
  const UnderDevelopView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        title: const Text('Coming Soon'),
        // backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 100,
              color: Colors.orange,
            ),
            SizedBox(height: 20),
            Text(
              'This screen is under development.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Please check back later!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
