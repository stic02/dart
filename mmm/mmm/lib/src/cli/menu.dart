import 'dart:io';
import '../data/salon_database.dart';
import '../domain/employee.dart';
import '../domain/client.dart';
import '../domain/position.dart';
import '../domain/service.dart';
import '../domain/tattoo_type.dart';
import '../domain/order.dart';
import 'input_helper.dart';

void runMenu(SalonDatabase db) {
  while (true) {
    print('главное меню');
    print('1.  управление сотрудниками');
    print('2.  управление клиентами');
    print('3.  управление должностями');
    print('4.  управление услугами');
    print('5.  управление типами тату');
    print('6.  управление заказами');
    print('7.  показать всё из бд');
    print('0.  выход');
    stdout.write('ваш выбор: ');
    final choice = stdin.readLineSync()?.trim() ?? '';

    switch (choice) {
      case '1':
        _manageEmployees(db);
        break;
      case '2':
        _manageClients(db);
        break;
      case '3':
        _managePositions(db);
        break;
      case '4':
        _manageServices(db);
        break;
      case '5':
        _manageTattooTypes(db);
        break;
      case '6':
        _manageOrders(db);
        break;
      case '7':
        print(db.showAllData());
        break;
      case '0':
        print('до свидания!');
        return;
      default:
        print('неверный выбор. попробуйте снова.');
    }
  }
}

void _manageEmployees(SalonDatabase db) {
  while (true) {
    print('\nуправление сотрудниками');
    print('1. показать всех');
    print('2. добавить');
    print('3. удалить');
    print('0. назад');
    stdout.write('выбор: ');
    final choice = stdin.readLineSync()?.trim() ?? '';

    switch (choice) {
      case '1':
        final employees = db.getAllEmployees();
        if (employees.isEmpty) {
          print('сотрудников нет');
        } else {
          for (final emp in employees) {
            print('${emp.id}. ${emp.name}');
          }
        }
        break;
      case '2':
        final positions = db.getAllPositions();
        if (positions.isEmpty) {
          print('сначала добавьте должности');
          return;
        }
        final name = InputHelper.readNonEmptyString('имя сотрудника: ');
        final phone = InputHelper.readNonEmptyString('телефон: ');
        final posId = InputHelper.selectFromList(
            positions, 'должности', (p) => p.title);
        if (posId == -1) return;
        final salary = InputHelper.readPositiveDouble('зарплата: ');
        db.addEmployee(Employee(
          name: name,
          phone: phone,
          positionId: posId,
          salary: salary,
        ));
        print('сотрудник добавлен');
        break;
      case '3':
        final employees = db.getAllEmployees();
        if (employees.isEmpty) {
          print('нет сотрудников для удаления');
          return;
        }
        final id = InputHelper.selectFromList(
            employees, 'сотрудники', (e) => e.name);
        if (id != -1) {
          db.deleteEmployee(id);
          print('сотрудник удален');
        }
        break;
      case '0':
        return;
      default:
        print('неверный выбор');
    }
  }
}

void _manageClients(SalonDatabase db) {
  while (true) {
    print('\nуправление клиентами');
    print('1. показать всех');
    print('2. добавить');
    print('3. удалить');
    print('0. назад');
    stdout.write('выбор: ');
    final choice = stdin.readLineSync()?.trim() ?? '';

    switch (choice) {
      case '1':
        final clients = db.getAllClients();
        if (clients.isEmpty) {
          print('клиентов нет');
        } else {
          for (final client in clients) {
            print('${client.id}. ${client.name} - ${client.phone}');
          }
        }
        break;
      case '2':
        final name = InputHelper.readNonEmptyString('имя клиента: ');
        final phone = InputHelper.readNonEmptyString('телефон: ');
        final email = InputHelper.readNonEmptyString('email (необязательно): ');
        db.addClient(Client(
          name: name,
          phone: phone,
          email: email.isEmpty ? null : email,
        ));
        print('клиент добавлен');
        break;
      case '3':
        final clients = db.getAllClients();
        if (clients.isEmpty) {
          print('нет клиентов для удаления');
          return;
        }
        final id = InputHelper.selectFromList(
            clients, 'клиенты', (c) => '${c.name} (${c.phone})');
        if (id != -1) {
          db.deleteClient(id);
          print('клиент удален');
        }
        break;
      case '0':
        return;
      default:
        print('неверный выбор');
    }
  }
}

void _managePositions(SalonDatabase db) {
  while (true) {
    print('\nуправление должностями');
    print('1. показать все');
    print('2. добавить');
    print('3. удалить');
    print('0. назад');
    stdout.write('выбор: ');
    final choice = stdin.readLineSync()?.trim() ?? '';

    switch (choice) {
      case '1':
        final positions = db.getAllPositions();
        if (positions.isEmpty) {
          print('должностей нет');
        } else {
          for (final pos in positions) {
            print('${pos.id}. ${pos.title}');
          }
        }
        break;
      case '2':
        final title = InputHelper.readNonEmptyString('название должности: ');
        final desc = InputHelper.readNonEmptyString('описание (необязательно): ');
        db.addPosition(Position(
          title: title,
          description: desc.isEmpty ? null : desc,
        ));
        print('должность добавлена');
        break;
      case '3':
        final positions = db.getAllPositions();
        if (positions.isEmpty) {
          print('нет должностей для удаления');
          return;
        }
        final id = InputHelper.selectFromList(
            positions, 'должности', (p) => p.title);
        if (id != -1) {
          db.deletePosition(id);
          print('должность удалена');
        }
        break;
      case '0':
        return;
      default:
        print('неверный выбор');
    }
  }
}

void _manageServices(SalonDatabase db) {
  while (true) {
    print('\nуправление услугами');
    print('1. показать все');
    print('2. добавить');
    print('3. удалить');
    print('0. назад');
    stdout.write('выбор: ');
    final choice = stdin.readLineSync()?.trim() ?? '';

    switch (choice) {
      case '1':
        final services = db.getAllServices();
        if (services.isEmpty) {
          print('услуг нет');
        } else {
          for (final service in services) {
            print('${service.id}. ${service.name} - ${service.price} руб.');
          }
        }
        break;
      case '2':
        final types = db.getAllTattooTypes();
        if (types.isEmpty) {
          print('сначала добавьте типы тату');
          return;
        }
        final name = InputHelper.readNonEmptyString('название услуги: ');
        final price = InputHelper.readPositiveDouble('цена: ');
        final duration = InputHelper.readPositiveInt('длительность (мин): ');
        final typeId = InputHelper.selectFromList(
            types, 'типы тату', (t) => t.name);
        if (typeId == -1) return;
        db.addService(Service(
          name: name,
          price: price,
          durationMinutes: duration,
          tattooTypeId: typeId,
        ));
        print('услуга добавлена');
        break;
      case '3':
        final services = db.getAllServices();
        if (services.isEmpty) {
          print('нет услуг для удаления');
          return;
        }
        final id = InputHelper.selectFromList(
            services, 'услуги', (s) => s.name);
        if (id != -1) {
          db.deleteService(id);
          print('услуга удалена');
        }
        break;
      case '0':
        return;
      default:
        print('неверный выбор');
    }
  }
}

void _manageTattooTypes(SalonDatabase db) {
  while (true) {
    print('\nуправление типами тату');
    print('1. показать все');
    print('2. добавить');
    print('3. удалить');
    print('0. назад');
    stdout.write('выбор: ');
    final choice = stdin.readLineSync()?.trim() ?? '';

    switch (choice) {
      case '1':
        final types = db.getAllTattooTypes();
        if (types.isEmpty) {
          print('типов тату нет');
        } else {
          for (final type in types) {
            print('${type.id}. ${type.name}');
          }
        }
        break;
      case '2':
        final name = InputHelper.readNonEmptyString('название типа: ');
        final style = InputHelper.readNonEmptyString('стиль (необязательно): ');
        db.addTattooType(TattooType(
          name: name,
          style: style.isEmpty ? null : style,
        ));
        print('тип тату добавлен');
        break;
      case '3':
        final types = db.getAllTattooTypes();
        if (types.isEmpty) {
          print('нет типов для удаления');
          return;
        }
        final id = InputHelper.selectFromList(
            types, 'типы тату', (t) => t.name);
        if (id != -1) {
          db.deleteTattooType(id);
          print('тип тату удален');
        }
        break;
      case '0':
        return;
      default:
        print('неверный выбор');
    }
  }
}

void _manageOrders(SalonDatabase db) {
  while (true) {
    print('\nправление заказами');
    print('1. показать все');
    print('2. добавить');
    print('3. удалить');
    print('0. назад');
    stdout.write('выбор: ');
    final choice = stdin.readLineSync()?.trim() ?? '';

    switch (choice) {
      case '1':
        final orders = db.getAllOrders();
        if (orders.isEmpty) {
          print('заказов нет');
        } else {
          for (final order in orders) {
            print('${order.id}. заказ #${order.id}');
          }
        }
        break;
      case '2':
        final clients = db.getAllClients();
        final employees = db.getAllEmployees();
        final services = db.getAllServices();

        if (clients.isEmpty) {
          print('нет клиентов');
          return;
        }
        if (employees.isEmpty) {
          print('нет сотрудников');
          return;
        }
        if (services.isEmpty) {
          print('нет услуг');
          return;
        }

        final clientId = InputHelper.selectFromList(
            clients, 'клиенты', (c) => c.name);
        if (clientId == -1) return;
        final employeeId = InputHelper.selectFromList(
            employees, 'сотрудники', (e) => e.name);
        if (employeeId == -1) return;
        final serviceId = InputHelper.selectFromList(
            services, 'услуги', (s) => s.name);
        if (serviceId == -1) return;
        final date = InputHelper.readDateTime('дата и время (гггг-мм-дд чч:мм:сс): ');
        final status = InputHelper.readNonEmptyString('статус: ');
        final finalPrice = InputHelper.readPositiveDouble('итоговая цена: ');

        db.addOrder(Order(
          clientId: clientId,
          employeeId: employeeId,
          serviceId: serviceId,
          orderDate: date,
          status: status,
          finalPrice: finalPrice,
        ));
        print('заказ добавлен');
        break;
      case '3':
        final orders = db.getAllOrders();
        if (orders.isEmpty) {
          print('нет заказов для удаления');
          return;
        }
        final id = InputHelper.selectFromList(
            orders, 'заказы', (o) => 'заказ #${o.id}');
        if (id != -1) {
          db.deleteOrder(id);
          print('заказ удален');
        }
        break;
      case '0':
        return;
      default:
        print('неверный выбор');
    }
  }
}