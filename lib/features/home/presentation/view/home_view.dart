import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/features/batch/presentation/view/batch_view.dart';
import 'package:student_management_starter/features/course/presentation/view/course_view.dart'; // Import the CourseView
import 'package:student_management_starter/features/home/presentation/navigator/home_navigator.dart';

class HomeView extends ConsumerWidget {
  const HomeView(
      {super.key}); // Mark the key parameter as required by adding the required modifier

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(HomeViewNavigator.homeViewModelProvider);
    final homeViewModel =
        ref.watch(HomeViewNavigator.homeViewModelProvider.notifier);

    final views = [
      const Center(child: Text('Dashboard')), // Replace with DashboardView
      CourseView(), // Replace with CourseView
      BatchView(),
      const Center(child: Text('Profile')), // Replace with ProfileView
    ];

    // Determine the title based on the current index
    final title = currentIndex == 1
        ? 'Course View'
        : currentIndex == 2
            ? 'Batch View'
            : 'Dashboard View';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: currentIndex == 2
            ? []
            : [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    // Add your refresh logic here
                  },
                ),
                Switch(
                  value: true, // Replace with a provider value if needed
                  onChanged: (value) {
                    // Add your toggle logic here
                  },
                ),
              ],
      ),
      body: views[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Batch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          homeViewModel.setCurrentIndex(index);
        },
        selectedItemColor: currentIndex == 2 ? Colors.white : Colors.black,
      ),
    );
  }
}
