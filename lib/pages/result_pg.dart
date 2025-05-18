import 'package:flutter/material.dart';
import '../widgets/page_header.dart';
import '../widgets/result_card.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text('Your Results'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageHeader(title: 'Here’s What We Found'),
            const SizedBox(height: 20),

            // Responsive Result Cards
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              alignment: WrapAlignment.center,
              children: const [
                ResultCard(
                  title: 'Lower Eyelids',
                  status: 'Mild Anemia',
                  imagePath: 'assets/images/the_eye.jpg',
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Recommendation Card
            Card(
              color: Colors.orange[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Mild Iron Deficiency Detected. Try more leafy greens and iron-rich foods.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Action Buttons
            Center(
              child: Wrap(
                spacing: 12.0,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Navigate to tracking page
                    },
                    child: const Text('Track My Health'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Navigate to info page
                    },
                    child: const Text('Learn More'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
