import 'dart:io';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart' as p1;

class SalonDatabase {
  final Database _bd;
  
  SalonDatabase(String filepath) : _bd = sqlite3.open(filepath) {
    _createTables();
    _insertSampleData();
  }
  
  factory SalonDatabase.inApp() {
    final filepath = p1.join(Directory.current.path, 'salon.db');
    return SalonDatabase(filepath);
  }
  
  factory SalonDatabase.inMemory() {
    return SalonDatabase(':memory:');
  }
  
  void _createTables() {
    _bd.execute("""
      CREATE TABLE IF NOT EXISTS positions(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        title TEXT NOT NULL, 
        description TEXT
      );
    """);

    _bd.execute("""
      CREATE TABLE IF NOT EXISTS tattoo_types(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT NOT NULL, 
        style TEXT
      );
    """);

    _bd.execute("""
      CREATE TABLE IF NOT EXISTS employees(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT NOT NULL, 
        phone TEXT NOT NULL, 
        position_id INTEGER NOT NULL, 
        salary REAL NOT NULL,
        FOREIGN KEY (position_id) REFERENCES positions(id) ON DELETE RESTRICT
      );
    """);

    _bd.execute("""
      CREATE TABLE IF NOT EXISTS clients(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT NOT NULL, 
        phone TEXT NOT NULL UNIQUE, 
        email TEXT
      );
    """);

    _bd.execute("""
      CREATE TABLE IF NOT EXISTS services(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT NOT NULL, 
        price REAL NOT NULL, 
        duration_minutes INTEGER NOT NULL, 
        tattoo_type_id INTEGER NOT NULL,
        FOREIGN KEY (tattoo_type_id) REFERENCES tattoo_types(id) ON DELETE RESTRICT
      );
    """);

    _bd.execute("""
      CREATE TABLE IF NOT EXISTS orders(
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        client_id INTEGER NOT NULL, 
        employee_id INTEGER NOT NULL, 
        service_id INTEGER NOT NULL, 
        order_date TEXT NOT NULL, 
        status TEXT DEFAULT 'pending', 
        final_price REAL,
        FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE RESTRICT,
        FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE RESTRICT,
        FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE RESTRICT
      );
    """);
  }

  void _insertSampleData() {
    final countPositions = _bd.select('SELECT COUNT(*) FROM positions').first.values.first;
    if (countPositions == 0) {
      _bd.execute('INSERT INTO positions (title, description) VALUES (?, ?)',
          ['мастер', 'сертифицированный мастер тату']);
      _bd.execute('INSERT INTO positions (title, description) VALUES (?, ?)',
          ['администратор', 'встречает клиентов']);
      _bd.execute('INSERT INTO positions (title, description) VALUES (?, ?)',
          ['стажер', 'помогает мастеру']);

      _bd.execute('INSERT INTO tattoo_types (name, style) VALUES (?, ?)',
          ['реализм', 'фотореалистичные тату']);
      _bd.execute('INSERT INTO tattoo_types (name, style) VALUES (?, ?)',
          ['традишнл', 'american traditional']);
      _bd.execute('INSERT INTO tattoo_types (name, style) VALUES (?, ?)',
          ['минимализм', 'тонкие линии и точки']);

      _bd.execute('INSERT INTO employees (name, phone, position_id, salary) VALUES (?, ?, ?, ?)',
          ['анна иванова', '+7-999-123-45-67', 1, 150000]);
      _bd.execute('INSERT INTO employees (name, phone, position_id, salary) VALUES (?, ?, ?, ?)',
          ['петр сидоров', '+7-999-234-56-78', 2, 80000]);

      _bd.execute('INSERT INTO clients (name, phone, email) VALUES (?, ?, ?)',
          ['мария петрова', '+7-916-123-45-67', 'maria@mail.ru']);
      _bd.execute('INSERT INTO clients (name, phone, email) VALUES (?, ?, ?)',
          ['иван смирнов', '+7-916-234-56-78', null]);

      _bd.execute('INSERT INTO services (name, price, duration_minutes, tattoo_type_id) VALUES (?, ?, ?, ?)',
          ['рукав', 50000, 360, 1]);
      _bd.execute('INSERT INTO services (name, price, duration_minutes, tattoo_type_id) VALUES (?, ?, ?, ?)',
          ['роза', 15000, 120, 2]);
    }
  }

  Database get sqlite => _bd;
  
  void close() {
    _bd.dispose();
  }
}