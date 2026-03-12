void main() {
  print('журнал успеваемости');
  print('=' * 50);

  //создаем тестовые данные
  final journal = Journal.createTestData();

  //категории студентов по среднему баллу
  print('\n1категории успеваемости:');
  print('-' * 40);
  
  final categories = journal.categorizeStudentsByAverage();
  
  print('отличники (средний балл ≥ 4.5):');
  if (categories['excellent']!.isEmpty) print('   Нет');
  for (var name in categories['excellent']!) {
    print(' $name');
  }
  
  print('\nхорошисты (средний балл 3.5 - 4.5):');
  if (categories['good']!.isEmpty) print('   Нет');
  for (var name in categories['good']!) {
    print(' $name');
  }
  
  print('\nостальные студенты (средний балл < 3.5):');
  if (categories['other']!.isEmpty) print('   Нет');
  for (var name in categories['other']!) {
    print(' $name');
  }

  //статистика оценок
  print('\n\статистика:');
  print('-' * 40);
  final gradeStats = journal.countGrades();
  gradeStats.forEach((grade, count) {
    print('оценка $grade: $count раз(а)');
  });

  //студенты с 5 по предметам
  print('\n\nстуденты со всеми 5:');
  print('-' * 40);
  final studentsWithFivesBySubject = journal.getStudentsWithFiveBySubject();
  studentsWithFivesBySubject.forEach((subject, students) {
    if (students.isNotEmpty) {
      print('$subject:');
      for (var student in students) {
        print('$student:');
      }
    }
  });

  //предметы без двоек
  print('\n\без двоек:');
  print('-' * 40);
  final subjectsWithoutTwos = journal.getSubjectsWithoutTwos();
  if (subjectsWithoutTwos.isEmpty) {
    print('по всем предметам есть 2');
  } else {
    for (var subject in subjectsWithoutTwos) {
      print(' $subject');
    }
  }

  //предмет с наибольшим количеством двоек
  print('\n\nнаибольшее кол-во 2 у студентов:');
  print('-' * 40);
  final worstSubject = journal.getSubjectWithMostTwos();
  if (worstSubject != null) {
    print('${worstSubject.$1}: ${worstSubject.$2} двоек');
  } else {
    print('двоек нет вообще');
  }

  //студенты с наибольшим кол-ом 5
  print('\n\nнаибольшее кол-во 5 у студентов:');
  print('-' * 40);
  final bestStudents = journal.getStudentsWithMostFives();
  if (bestStudents.isNotEmpty) {
    for (var student in bestStudents) {
      print('${student.$1}: ${student.$2} пятерок');
    }
  }

  //студенты с оценками ниже 4
  print('\n\nстденты с оценкой ниже 4:');
  print('-' * 40);
  final lowGradeStudents = journal.getStudentsWithGradesBelowFour();
  if (lowGradeStudents.isEmpty) {
    print('у всех студентов оценки 4 и выше');
  } else {
    lowGradeStudents.forEach((studentName, data) {
      print('$studentName: ${data['count']} предмет(ов)');
      print('предметы: ${(data['subjects'] as List).join(', ')}');
    });
  }

  // все пары студент-предмет с 5
  print('\n\nпары студент-предмет с 5:');
  print('-' * 40);
  final fivePairs = journal.getAllFivePairs();
  if (fivePairs.isEmpty) {
    print('нет ни одной пятерки');
  } else {
    for (var pair in fivePairs) {
      print('${pair.$1} — ${pair.$2}');
    }
  }
  
  print('\n' + '=' * 50);
}

//класс для представления студента
class Student {
  final int id;
  final String name;
  
  Student(this.id, this.name);
}

//класс для представления предмета
class Subject {
  final int id;
  final String name;
  
  Subject(this.id, this.name);
}

//класс для представления оценки
class Grade {
  final int studentId;
  final int subjectId;
  final int value; // 2, 3, 4, 5
  
  Grade(this.studentId, this.subjectId, this.value);
}

//основной класс журнала
class Journal {
  final List<Student> students;
  final List<Subject> subjects;
  final List<Grade> grades;
  
  Journal(this.students, this.subjects, this.grades);
  
  //создание тестовых данных
  static Journal createTestData() {
    final students = [
      Student(1, 'Алина Каврус'),
      Student(2, 'Татьяна Стецко'),
      Student(3, 'Мария Михеева'),
      Student(4, 'Ярослав Степанов'),
      Student(5, 'Владислав Попов'),
      Student(6, 'Артем Шустер'),
    ];
    
    final subjects = [
      Subject(1, 'Математика'),
      Subject(2, 'Физика'),
      Subject(3, 'Программирование'),
      Subject(4, 'Английский язык'),
      Subject(5, 'История'),
    ];
    
    final grades = [
      Grade(1, 1, 5), Grade(1, 2, 5), Grade(1, 3, 5), Grade(1, 4, 4), Grade(1, 5, 5),
      Grade(2, 1, 4), Grade(2, 2, 4), Grade(2, 3, 5), Grade(2, 4, 3), Grade(2, 5, 4),
      Grade(3, 1, 5), Grade(3, 2, 5), Grade(3, 3, 5), Grade(3, 4, 5), Grade(3, 5, 4),
      Grade(4, 1, 3), Grade(4, 2, 2), Grade(4, 3, 3), Grade(4, 4, 4), Grade(4, 5, 2),
      Grade(5, 1, 4), Grade(5, 2, 4), Grade(5, 3, 4), Grade(5, 4, 5), Grade(5, 5, 3),
      Grade(6, 1, 5), Grade(6, 2, 5), Grade(6, 3, 5), Grade(6, 4, 5), Grade(6, 5, 3),
    ];
    
    return Journal(students, subjects, grades);
  }
  
  //для получения имени студента по ID
  String getStudentName(int studentId) {
    return students.firstWhere((s) => s.id == studentId).name;
  }
  
  //для получения названия предмета по ID
  String getSubjectName(int subjectId) {
    return subjects.firstWhere((s) => s.id == subjectId).name;
  }
  
  //категории студентов по среднему баллу
  Map<String, List<String>> categorizeStudentsByAverage() {
    final result = {
      'excellent': <String>[],
      'good': <String>[],
      'other': <String>[],
    };
    
    for (var student in students) {
      final studentGrades = grades.where((g) => g.studentId == student.id).toList();
      if (studentGrades.isEmpty) continue;
      
      final average = studentGrades.map((g) => g.value).reduce((a, b) => a + b) / studentGrades.length;
      
      if (average >= 4.5) {
        result['excellent']!.add(student.name);
      } else if (average >= 3.5) {
        result['good']!.add(student.name);
      } else {
        result['other']!.add(student.name);
      }
    }
    
    return result;
  }
  
  //подсчет кол-ва каждой оценки
  Map<int, int> countGrades() {
    final result = {2: 0, 3: 0, 4: 0, 5: 0};
    
    for (var grade in grades) {
      result[grade.value] = (result[grade.value] ?? 0) + 1;
    }
    
    return result;
  }
  
  //список студентов с 5 по каждому предмету
  Map<String, List<String>> getStudentsWithFiveBySubject() {
    final result = <String, List<String>>{};
    
    for (var subject in subjects) {
      final studentsWithFive = grades
          .where((g) => g.subjectId == subject.id && g.value == 5)
          .map((g) => getStudentName(g.studentId))
          .toList();
      
      if (studentsWithFive.isNotEmpty) {
        result[subject.name] = studentsWithFive;
      }
    }
    
    return result;
  }
  
  //предметы без 2
  List<String> getSubjectsWithoutTwos() {
    final result = <String>[];
    
    for (var subject in subjects) {
      final hasTwo = grades.any((g) => g.subjectId == subject.id && g.value == 2);
      if (!hasTwo) {
        result.add(subject.name);
      }
    }
    
    return result;
  }
  
  //предмет с наибольшим кол-ом 2
  (String, int)? getSubjectWithMostTwos() {
    final twoCounts = <int, int>{}; // subjectId -> count
    
    for (var grade in grades.where((g) => g.value == 2)) {
      twoCounts[grade.subjectId] = (twoCounts[grade.subjectId] ?? 0) + 1;
    }
    
    if (twoCounts.isEmpty) return null;
    
    final worstSubjectId = twoCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    final worstSubject = subjects.firstWhere((s) => s.id == worstSubjectId);
    
    return (worstSubject.name, twoCounts[worstSubjectId]!);
  }
  
  //студенты с наибольшим кол-ом 5
  List<(String, int)> getStudentsWithMostFives() {
    final fiveCounts = <int, int>{}; // studentId -> count
    
    for (var grade in grades.where((g) => g.value == 5)) {
      fiveCounts[grade.studentId] = (fiveCounts[grade.studentId] ?? 0) + 1;
    }
    
    if (fiveCounts.isEmpty) return [];
    
    final maxFives = fiveCounts.values.reduce((a, b) => a > b ? a : b);
    
    return fiveCounts.entries
        .where((e) => e.value == maxFives)
        .map((e) => (getStudentName(e.key), e.value))
        .toList();
  }
  
  //студенты с оценками ниже 4
  Map<String, Map<String, dynamic>> getStudentsWithGradesBelowFour() {
    final result = <String, Map<String, dynamic>>{};
    
    for (var student in students) {
      final lowGrades = grades
          .where((g) => g.studentId == student.id && g.value < 4)
          .toList();
      
      if (lowGrades.isNotEmpty) {
        result[student.name] = {
          'count': lowGrades.length,
          'subjects': lowGrades.map((g) => getSubjectName(g.subjectId)).toList(),
        };
      }
    }
    
    return result;
  }
  
  // все пары студент-предмет с 5
  List<(String, String)> getAllFivePairs() {
    return grades
        .where((g) => g.value == 5)
        .map((g) => (getStudentName(g.studentId), getSubjectName(g.subjectId)))
        .toList();
  }
}