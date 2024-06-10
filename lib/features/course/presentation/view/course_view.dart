import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/common/my_snackbar.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/batch/presentation/viewmodel/batch_view_model.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/course/presentation/viewmodel/batch_view_model.dart';

class CourseView extends ConsumerWidget {
  CourseView({super.key});

  final _courseNameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var courseState = ref.watch(courseViewmodelProvider);
    var courseViewModel = ref.read(courseViewmodelProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _courseNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Course Name',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final courseName = _courseNameController.text;
                if (courseName.isEmpty) {
                  showMySnackBar(message: "Field is Empty", color: Colors.red);
                } else {
                  courseViewModel.addcourse(CourseEntity(courseName: courseName));
                  _courseNameController.clear();
                }
              },
              child: const Text('Add Course'),
            ),
            const SizedBox(height: 16),
            const Text(
              'List of Courses',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (courseState.isLoading) ...[
              const Center(
                child: CircularProgressIndicator(),
              ),
            ] else if (courseState.error != null) ...[
              Text(courseState.error.toString()),
            ] else if (courseState.lstCourses.isEmpty) ...[
              const Center(
                child: Text("No Courses"),
              )
            ] else ...[
              Expanded(
                child: ListView.builder(
                  itemCount: courseState.lstCourses.length,
                  itemBuilder: (context, index) {
                    var course = courseState.lstCourses[index];
                    return ListTile(
                      title: Text(course.courseName),
                      subtitle: Text(course.courseId ?? ''),
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
