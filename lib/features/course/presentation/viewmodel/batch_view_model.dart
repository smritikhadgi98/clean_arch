import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/common/my_snackbar.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/course/domain/usecases/course_usecase.dart';
import 'package:student_management_starter/features/course/presentation/state/course_state.dart';

final courseViewmodelProvider =
    StateNotifierProvider<CourseViewModel, CourseState>((ref) {
  return CourseViewModel(ref.read(courseUsecaseProvider));
});

class CourseViewModel extends StateNotifier<CourseState> {
  CourseViewModel(this.courseUseCase) : super(CourseState.initial()) {
    getAllCourses();
  }

  final CourseUseCase courseUseCase;

  Future<void> addcourse(CourseEntity course) async {
    // Show progress bar
    state = state.copyWith(isLoading: true);
    var data = await courseUseCase.addCourse(course);

    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        showMySnackBar(message: l.error, color: Colors.red);
      },
      (r) {
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: "Course Added Successfully");
        // Refresh the batch list after adding a new batch
        getAllCourses();
      },
    );
  }

  // For getting all batches
  Future<void> getAllCourses() async {
    // Show progress bar
    state = state.copyWith(isLoading: true);
    var data = await courseUseCase.getAllCourses();

    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false, lstCourses: r, error: null);
      },
    );
  }
}
