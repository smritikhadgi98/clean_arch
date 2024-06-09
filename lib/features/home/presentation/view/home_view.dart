import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/features/home/presentation/navigator/home_navigator.dart';
import 'package:student_management_starter/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:student_management_starter/features/batch/presentation/view/batch_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(HomeViewNavigator.homeViewModelProvider);
    final homeViewModel = ref.watch(HomeViewNavigator.homeViewModelProvider.notifier);

    final views = [
      const Center(child: Text('Dashboard')), // Replace with DashboardView
      const Center(child: Text('Course')), // Replace with CourseView
      BatchView(),
      const Center(child: Text('Profile')), // Replace with ProfileView
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentIndex == 2 ? 'Batch View' : 'Dashboard View', // Change title based on selected tab
        ),
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
