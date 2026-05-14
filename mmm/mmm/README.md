# тату салон — модульное cli-приложение на dart

консольное приложение для учета тату салона с хранением данных в sqlite.

## предметная область

система автоматизации тату салона:

- сотрудники (employee);
- клиенты (client);
- должности (position);
- услуги (service);
- типы тату (tattootype);
- заказы (order) с привязкой к клиенту, сотруднику и услуге.

## архитектура и структура папок

проект разделен на модули по слоям:

```text
lib/
  salon.dart               # публичный экспорт
  src/
    domain/                # сущности и базовые интерфейсы
      identity.dart
      employee.dart
      client.dart
      position.dart
      service.dart
      tattoo_type.dart
      order.dart
    data/                  # sqlite и sql-логика
      salon_database.dart
    cli/                   # меню и обработка ввода
      menu.dart
      input_helper.dart
bin/
  mmm.dart                 # точка входа (main)
test/
  salon_test.dart          # тесты