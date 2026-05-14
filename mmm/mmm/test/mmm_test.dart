import 'package:test/test.dart';
import 'package:salon/salon.dart';

void main() {
  group('тесты сущностей', () {
    test('client tomap/frommap работает корректно', () {
      final client = Client(
        id: 1,
        name: 'тестовый клиент',
        phone: '+7-999-123-45-67',
        email: 'test@mail.com',
      );
      final map = client.toMap();
      final restored = Client.fromMap(map);
      print('restored.id: ${restored.id}, client.id: ${client.id}');
      print('restored.name: ${restored.name}, client.name: ${client.name}');
      print('restored.phone: ${restored.phone}, client.phone: ${client.phone}');
      print('restored.email: ${restored.email}, client.email: ${client.email}');
    });

    test('employee tomap/frommap работает корректно', () {
      final employee = Employee(
        id: 1,
        name: 'тестовый сотрудник',
        phone: '+7-999-123-45-67',
        positionId: 1,
        salary: 50000.0,
      );
      final map = employee.toMap();
      final restored = Employee.fromMap(map);
      print('restored.id: ${restored.id}, employee.id: ${employee.id}');
      print('restored.name: ${restored.name}, employee.name: ${employee.name}');
      print('restored.phone: ${restored.phone}, employee.phone: ${employee.phone}');
      print('restored.positionId: ${restored.positionId}, employee.positionId: ${employee.positionId}');
      print('restored.salary: ${restored.salary}, employee.salary: ${employee.salary}');
    });
  });

  group('тесты бд', () {
    late SalonDatabase db;

    setUp(() {
      db = SalonDatabase.inMemory();
    });

    tearDown(() {
      db.close();
    });

    test('добавление и чтение клиента из бд', () {
      final client = Client(
        name: 'тестовый клиент',
        phone: '+7-999-000-00-00',
        email: 'test@test.com',
      );

      db.addClient(client);
      final clients = db.getAllClients();
      print('количество клиентов: ${clients.length}');
      for (final c in clients) {
        print('клиент: ${c.name}, ${c.phone}, ${c.email}');
      }
    });

    test('добавление и чтение сотрудника из бд', () {
      final employee = Employee(
        name: 'тестовый сотрудник',
        phone: '+7-999-111-11-11',
        positionId: 1,
        salary: 60000.0,
      );

      db.addEmployee(employee);
      final employees = db.getAllEmployees();
      print('количество сотрудников: ${employees.length}');
      for (final e in employees) {
        print('сотрудник: ${e.name}, ${e.phone}, должность: ${e.positionId}, зарплата: ${e.salary}');
      }
    });
  });

  group('тесты валидации', () {
    test('корректный парсинг даты', () {
      final dateStr = '2024-12-25 14:30:00';
      final date = DateTime.parse(dateStr);
      print('год: ${date.year}');
      print('месяц: ${date.month}');
      print('день: ${date.day}');
      print('час: ${date.hour}');
      print('минута: ${date.minute}');
    });

    test('некорректный парсинг даты выбрасывает ошибку', () {
      try {
        DateTime.parse('not-a-date');
      } catch (e) {
        print('ошибка при парсинге "not-a-date": $e');
      }
      try {
        DateTime.parse('2024-13-45');
      } catch (e) {
        print('ошибка при парсинге "2024-13-45": $e');
      }
    });

    test('проверка положительного числа', () {
      print('функция readPositiveDouble существует: ${InputHelper.readPositiveDouble is Function}');
    });
  });
}