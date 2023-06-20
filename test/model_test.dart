import 'package:flutter_test/flutter_test.dart';
import 'package:achiever_app/model/task.dart';
import './helpers/helpers.dart';

void main() {
  group('achiever_app/model/task.dart', () {
    test('Task.dueDateString should return "Today" when the task is due today',
        () {
      // arrange
      var due = DateTime.now();
      var task = Task(dueDate: due);
      final expected = "Today";
      // act
      final result = task.dueDateString;
      // assert
      expect(result, expected);
    });
    test(
        'Task.dueDateString should return "Tomorrow" when the task is due tomorrow',
        () {
      // arrange
      var today = DateTime.now();
      var due = today.add(Duration(days: 1));
      var task = Task(dueDate: due);
      final expected = "Tomorrow";
      // act
      final result = task.dueDateString;
      // assert
      expect(result, expected);
    });
    test(
        'Task.dueDateString should return the day of the week when the task is due in 2 days',
        () {
      // arrange
      var today = DateTime.now();
      var due = today.add(Duration(days: 2));
      var task = Task(dueDate: due);
      final expected = weekdayToString(due.weekday);
      // act
      final result = task.dueDateString;
      // assert
      expect(result, expected);
    });
    test(
        'Task.dueDateString should return the day of the week when the task is due in 6 days',
        () {
      // arrange
      var today = DateTime.now();
      var due = today.add(Duration(days: 6));
      var task = Task(dueDate: due);
      final expected = weekdayToString(due.weekday);
      // act
      final result = task.dueDateString;
      // assert
      expect(result, expected);
    });
    test(
        'Task.dueDateString should return a formatted date string when the task is due in 7 days',
        () {
      // arrange
      var today = DateTime.now();
      var due = today.add(Duration(days: 7));
      var task = Task(dueDate: due);
      final expected = dateTimeToFormatString(due);
      // act
      final result = task.dueDateString;
      // assert
      expect(result, expected);
    });
  });
}
