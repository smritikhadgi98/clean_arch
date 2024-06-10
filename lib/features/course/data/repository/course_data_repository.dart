import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/features/batch/data/data_source/local/batch_local_datasource.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/batch/domain/repository/batch_domain_repository.dart';
import 'package:student_management_starter/features/course/data/data_source/local/course_local_datasource.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/course/domain/repository/course_domain_repository.dart';

final courseLocalRepository = Provider<ICourseRepository>((ref) {
  return CourseLocalRepository(
      courseLocalDataSource: ref.read(courseLocalDataSourceProvider));
});

class CourseLocalRepository implements ICourseRepository {
  final CourseLocalDataSource courseLocalDataSource;
  CourseLocalRepository({required this.courseLocalDataSource});
  @override
  Future<Either<Failure, bool>> addCourse(CourseEntity course) {
    // throw UnimplementedError();
    return courseLocalDataSource.addCourse(course);
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getAllCourses() {
    // throw UnimplementedError();
    return courseLocalDataSource.getAllCourses();
  }
}
