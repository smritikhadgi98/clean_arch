import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/common/my_snackbar.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/batch/presentation/viewmodel/batch_view_model.dart';

class BatchView extends ConsumerWidget {
  BatchView({super.key});

  final _batchNameController = TextEditingController();

  void _showError(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var batchState = ref.watch(batchViewmodelProvider);
    var batchViewModel = ref.read(batchViewmodelProvider.notifier);

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
                final batchName = _batchNameController.text;
                if (batchName.isEmpty) {
                  showMySnackBar(message: "Field is Empty", color: Colors.red);
                } else {
                  batchViewModel.addBatch(BatchEntity(batchName: batchName));
                  _batchNameController.clear();
                }
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
            if (batchState.isLoading) ...[
              const Center(
                child: CircularProgressIndicator(),
              ),
            ] else if (batchState.error != null) ...[
              Text(batchState.error.toString()),
            ] else if (batchState.lstBatches.isEmpty) ...[
              const Center(
                child: Text("No Batches"),
              )
            ] else ...[
              Expanded(
                child: ListView.builder(
                  itemCount: batchState.lstBatches.length,
                  itemBuilder: (context, index) {
                    var batch = batchState.lstBatches[index];
                    return ListTile(
                      title: Text(batch.batchName),
                      subtitle: Text(batch.batchId ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Add delete functionality here
                        },
                      ),
                    );
                  },
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
