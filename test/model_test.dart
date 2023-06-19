import 'package:flutter_test/flutter_test.dart';
import 'package:achiever_app/model/task.dart';

void main() {
  group('achiever_app/model/task.dart', () {
    test('Task.dueDateString should return "Today" when the task is due today',
        () {
      // arrange
      var task = Task(dueDate: DateTime.now());
      // act
      var result = task.dueDateString;
      // assert
      expect(result, "Today");
    });
    test(
        'Task.dueDateString should return "Tomorrow" when the task is due tomorrow',
        () {
      // arrange
      var task = Task(dueDate: DateTime.now().add(Duration(days: 1)));
      // act
      var result = task.dueDateString;
      // assert
      expect(result, "Tomorrow");
    });
  });
}
