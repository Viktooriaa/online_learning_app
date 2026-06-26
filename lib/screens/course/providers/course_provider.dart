import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../models/course_models.dart';

final courseCategoryProvider =
    NotifierProvider<CourseCategoryNotifier, int>(CourseCategoryNotifier.new);

class CourseCategoryNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void select(int index) => state = index;
}

final courseBookmarkProvider =
    NotifierProvider<CourseBookmarkNotifier, bool>(CourseBookmarkNotifier.new);

class CourseBookmarkNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
}

final videoBookmarkProvider =
    NotifierProvider<VideoBookmarkNotifier, bool>(VideoBookmarkNotifier.new);

class VideoBookmarkNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
}

final coursesProvider = Provider<List<Course>>((ref) {
  return const [
    Course(
      title: AppStrings.productDesignV1,
      author: AppStrings.robertsonConnie,
      price: AppStrings.price190,
      hours: AppStrings.sixteenHours,
    ),
    Course(
      title: AppStrings.productDesign,
      author: AppStrings.webbLandon,
      price: AppStrings.price250,
      hours: AppStrings.fourteenHours,
      hasVideos: false,
    ),
    Course(
      title: AppStrings.productDesign,
      author: AppStrings.webbKyle,
      price: AppStrings.price250,
      hours: AppStrings.fourteenHours,
    ),
  ];
});

final detailLessonsProvider = Provider<List<Lesson>>((ref) {
  return const [
    Lesson(
      number: 1,
      title: AppStrings.welcomeToCourse,
      duration: AppStrings.lessonDuration,
      action: LessonAction.play,
    ),
    Lesson(
      number: 2,
      title: AppStrings.processOverview,
      duration: AppStrings.lessonDuration,
      action: LessonAction.play,
    ),
    Lesson(
      number: 3,
      title: AppStrings.discovery,
      duration: AppStrings.lessonDuration,
      action: LessonAction.locked,
    ),
  ];
});

final videoLessonsProvider = Provider<List<Lesson>>((ref) {
  return const [
    Lesson(
      number: 1,
      title: AppStrings.welcomeToCourse,
      duration: AppStrings.lessonDuration,
      action: LessonAction.play,
    ),
    Lesson(
      number: 2,
      title: AppStrings.processOverview,
      duration: AppStrings.lessonDuration,
      action: LessonAction.pause,
    ),
    Lesson(
      number: 3,
      title: AppStrings.discovery,
      duration: AppStrings.lessonDuration,
      action: LessonAction.locked,
    ),
  ];
});

final myCoursesProvider = Provider<List<MyCourse>>((ref) {
  return const [
    MyCourse(
      title: 'Product\nDesign v1.0',
      completed: '14/24',
      color: AppColors.coursePinkCard,
      actionColor: AppColors.coursePinkAction,
    ),
    MyCourse(
      title: 'Java\nDevelopment',
      completed: '12/18',
      color: AppColors.courseBlueCard,
      actionColor: AppColors.primary,
    ),
    MyCourse(
      title: AppStrings.visualDesign,
      completed: '10/16',
      color: AppColors.courseGreenCard,
      actionColor: AppColors.courseGreenAction,
      progressTopSpacing: 46,
    ),
  ];
});
