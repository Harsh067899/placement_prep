import 'package:flutter/material.dart';
import '../widgets/feature_card.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Header
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Study Planner',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Plan smarter, achieve more',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Switch(
                        value: themeProvider.isDarkMode,
                        onChanged: (value) {
                          themeProvider.toggleTheme(value);
                        },
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        child: Icon(
                          Icons.person_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    FeatureCard(
                      title: 'Upload Timetable',
                      description: 'Upload your class schedule image',
                      icon: Icons.upload_file,
                      color: Colors.blue,
                      onTap: () => Navigator.pushNamed(context, '/upload'),
                    ),
                    FeatureCard(
                      title: 'Verify Data',
                      description: 'Review extracted timetable data',
                      icon: Icons.fact_check,
                      color: Colors.green,
                      onTap: () => Navigator.pushNamed(context, '/verify'),
                    ),
                    FeatureCard(
                      title: 'Study Plan',
                      description: 'View your daily study schedule',
                      icon: Icons.calendar_today,
                      color: Colors.orange,
                      onTap: () => Navigator.pushNamed(context, '/study_plan'),
                    ),
                    FeatureCard(
                      title: 'Progress',
                      description: 'Track your study progress',
                      icon: Icons.insights,
                      color: Colors.purple,
                      onTap: () => Navigator.pushNamed(context, '/progress'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

