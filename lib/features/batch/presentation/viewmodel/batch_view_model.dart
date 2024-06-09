import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/common/my_snackbar.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/batch/domain/usecases/batch_usecase.dart';
import 'package:student_management_starter/features/batch/presentation/state/batch_state.dart';

final batchViewmodelProvider =
    StateNotifierProvider<BatchViewModel, BatchState>((ref) {
  return BatchViewModel(ref.read(batchUsecaseProvider));
});

class BatchViewModel extends StateNotifier<BatchState> {
  BatchViewModel(this.batchUseCase) : super(BatchState.initial()) {
    getAllBatches();
  }

  final BatchUseCase batchUseCase;

  Future<void> addBatch(BatchEntity batch) async {
    // Show progress bar
    state = state.copyWith(isLoading: true);
    var data = await batchUseCase.addBatch(batch);

    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        showMySnackBar(message: l.error, color: Colors.red);
      },
      (r) {
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: "Batch Added Successfully");
        // Refresh the batch list after adding a new batch
        getAllBatches();
      },
    );
  }

  // For getting all batches
  Future<void> getAllBatches() async {
    // Show progress bar
    state = state.copyWith(isLoading: true);
    var data = await batchUseCase.getAllBatches();

    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false, lstBatches: r, error: null);
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:student_management_starter/core/common/my_snackbar.dart';
// import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
// import 'package:student_management_starter/features/batch/domain/usecases/batch_usecase.dart';
// import 'package:student_management_starter/features/batch/presentation/state/batch_state.dart';

// final batchViewmodelProvider =
//     StateNotifierProvider<BatchViewModel, BatchState>((ref) {
//   return BatchViewModel(ref.read(batchUsecaseProvider));
// });

// class BatchViewModel extends StateNotifier<BatchState> {
//   BatchViewModel(this.batchUseCase) : super(BatchState.initial()) {
//     getAllBatches();
//   }

//   final BatchUseCase batchUseCase;

//   Future<void> addBatch(BatchEntity batch) async {
//     state = state.copyWith(isLoading: true);
//     print('Adding batch: ${batch.batchName}'); // Debug print
//     var data = await batchUseCase.addBatch(batch);

//     data.fold(
//       (l) {
//         state = state.copyWith(isLoading: false, error: l.error);
//         showMySnackBar(message: l.error, color: Colors.red);
//         print('Error adding batch: ${l.error}'); // Debug print
//       },
//       (r) {
//         state = state.copyWith(isLoading: false, error: null);
//         showMySnackBar(message: "Batch Added Successfully");
//         print('Batch added successfully'); // Debug print
//         getAllBatches(); // Refresh the batch list after adding a new batch
//       },
//     );
//   }

//   Future<void> getAllBatches() async {
//     state = state.copyWith(isLoading: true);
//     print('Fetching all batches'); // Debug print
//     var data = await batchUseCase.getAllBatches();

//     data.fold(
//       (l) {
//         state = state.copyWith(isLoading: false, error: l.error);
//         print('Error fetching batches: ${l.error}'); // Debug print
//       },
//       (r) {
//         state = state.copyWith(isLoading: false, lstBatches: r, error: null);
//         print('Batches fetched: ${r.length}'); // Debug print
//       },
//     );
//   }
// }
