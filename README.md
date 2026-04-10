import 'dart:io';
import 'dart:math';

enum Mood {
  happy,
  sad,
  angry;
}

void main() {
  print("Введите имя: ");
  String name = stdin.readLineSync()!;
  
  name = name.trim();

  String moodd = "";
  String emoji = "";
  int energy = 0;

  final random = Random();
  final moods = Mood.values;
  
  final randomMood = moods[random.nextInt(moods.length)];
  
  switch (randomMood) {
    case Mood.happy:
      emoji = "\u{1F600}";
      moodd = "счастливый";
      energy = 9;
      break;
    case Mood.sad:
      emoji = "\u{1F622}";
      moodd = "грустный";
      energy = 2;
      break;
    case Mood.angry:
      emoji = "\u{1F621}";
      moodd = "злой";
      energy = 4;
      break;
  }
  
  print("Привет, $name. Настроение: $moodd $emoji (энергия: $energy/10)");
}
