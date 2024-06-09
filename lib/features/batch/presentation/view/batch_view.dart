import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/features/home/presentation/navigator/home_navigator.dart';

class BatchView extends ConsumerWidget {
  BatchView({super.key});

  final _batchNameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(HomeViewNavigator.homeViewModelProvider);
    final homeViewModel =
        ref.watch(HomeViewNavigator.homeViewModelProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _batchNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Batch Name',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add batch adding logic here
              },
              child: const Text('Add Batch'),
            ),
            const SizedBox(height: 16),
            const Text(
              'List of Batches',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Add logic to display list of batches here
          ],
        ),
      ),
    );
  }
}
