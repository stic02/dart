import 'package:salon/salon.dart';

void main() {
  final db = SalonDatabase.inApp();
  try {
    runMenu(db);
  } finally {
    db.close();
  }
}