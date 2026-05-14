import 'dart:io';

class InputHelper {
  static String readNonEmptyString(String prompt) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync()?.trim() ?? '';
      if (input.isNotEmpty) {
        return input;
      }
      print('поле не может быть пустым');
    }
  }

  static double readPositiveDouble(String prompt) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync()?.trim() ?? '';
      if (input.isEmpty) {
        print('поле не может быть пустым');
        continue;
      }
      final value = double.tryParse(input);
      if (value != null && value > 0) {
        return value;
      }
      print('введите число больше 0');
    }
  }

  static int readPositiveInt(String prompt) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync()?.trim() ?? '';
      if (input.isEmpty) {
        print('поле не может быть пустым');
        continue;
      }
      final value = int.tryParse(input);
      if (value != null && value > 0) {
        return value;
      }
      print('введите целое число больше 0');
    }
  }

  static DateTime readDateTime(String prompt) {
    while (true) {
      stdout.write(prompt);
      final input = stdin.readLineSync()?.trim() ?? '';
      if (input.isEmpty) {
        print('поле не может быть пустым');
        continue;
      }
      try {
        return DateTime.parse(input);
      } catch (_) {
        print('введите дату в формате гггг-мм-дд чч:мм:сс');
      }
    }
  }

  static int selectFromList<T>(List<T> items, String title, String Function(T) display) {
    if (items.isEmpty) {
      print('список $title пуст, сначала добавьте элемент.');
      return -1;
    }
    print('\n$title');
    for (var i = 0; i < items.length; i++) {
      print('${i + 1}. ${display(items[i])}');
    }
    final choice = readPositiveInt('выберите номер: ') - 1;
    if (choice >= 0 && choice < items.length) {
      final item = items[choice];
      if (item is Identity) return item.id!;
      return -1;
    }
    return -1;
  }
}

abstract class Identity {
  int? get id;
}