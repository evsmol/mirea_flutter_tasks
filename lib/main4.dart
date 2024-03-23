import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // Запуск приложения Flutter
}

// Основной виджет приложения
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Холодильник',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
}

// Главная страница приложения
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Холодильник'),
      ),
      body: Container(
        padding: EdgeInsets.all(20), // Отступы внутри контейнера
        child: Column( // Вертикальный столбец для размещения кнопок
          mainAxisAlignment: MainAxisAlignment.center,
          // Выравнивание по центру по вертикали
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // Растяжение по ширине экрана
          children: [
            ElevatedButton( // Кнопка для перехода на страницу ColumnScreen
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ColumnScreen()), // Навигация на новую страницу
                );
              },
              child: Padding( // Добавление отступов вокруг текста кнопки
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Column',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            SizedBox(height: 20), // Пространство между кнопками
            ElevatedButton( // Кнопка для перехода на страницу ListViewScreen
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ListViewScreen()), // Навигация на новую страницу
                );
              },
              child: Padding( // Добавление отступов вокруг текста кнопки
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'ListView',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            SizedBox(height: 20), // Пространство между кнопками
            ElevatedButton( // Кнопка для перехода на страницу ListViewSeparatedScreen
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      ListViewSeparatedScreen()), // Навигация на новую страницу
                );
              },
              child: Padding( // Добавление отступов вокруг текста кнопки
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'ListView.separated',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Экран с виджетом Column
class ColumnScreen extends StatefulWidget {
  @override
  _ColumnScreenState createState() => _ColumnScreenState();
}

class _ColumnScreenState extends State<ColumnScreen> {
  List<String> products = ['Молоко', 'Яйца', 'Хлеб'];

  // Метод для добавления продукта
  void _addProduct(String productName) {
    setState(() {
      products.add(productName); // Добавление в список продуктов
    });
  }

  // Метод для удаления продукта
  void _removeProduct(int index) {
    setState(() {
      products.removeAt(index); // Удаление из списка продуктов
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Column'),
      ),
      body: Padding( // Добавление отступов вокруг содержимого
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Растяжение по ширине экрана
          children: [
            for (int i = 0; i <
                products.length; i++) // Цикл по элементам списка
              Card( // Карточка для элемента списка
                elevation: 3, // Тень карточки
                child: ListTile( // Виджет списка для элемента
                  title: Text(products[i]),
                  trailing: IconButton( // Кнопка для удаления элемента
                    icon: Icon(Icons.delete),
                    onPressed: () =>
                        _removeProduct(i), // Удаление элемента при нажатии
                  ),
                ),
              ),
            SizedBox(height: 20), // Пространство между элементами
            TextField( // Поле ввода для добавления нового продукта
              decoration: InputDecoration(
                labelText: 'Введите название продукта',
                border: OutlineInputBorder(), // Оформление границы поля
              ),
              onSubmitted: (value) { // Обработчик ввода текста
                _addProduct(value); // Добавление продукта в список
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Экран с виджетом ListView
class ListViewScreen extends StatefulWidget {
  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  List<String> products = ['Молоко', 'Яйца', 'Хлеб'];

  // Метод для добавления продукта
  void _addProduct(String productName) {
    setState(() {
      products.add(productName); // Добавление продукта в список
    });
  }

  // Метод для удаления продукта
  void _removeProduct(int index) {
    setState(() {
      products.removeAt(index); // Удаление продукта из списка
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView'),
      ),
      body: Padding( // Добавление отступов вокруг содержимого
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: products.length, // Количество элементов списка
          itemBuilder: (context, index) {
            return Card( // Создание карточки для элемента списка
              elevation: 3, // Тень карточки
              child: ListTile( // Виджет списка для элемента
                title: Text(products[index]),
                trailing: IconButton( // Кнопка для удаления элемента
                  icon: Icon(Icons.delete),
                  onPressed: () =>
                      _removeProduct(index), // Удаление элемента при нажатии
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton( // Кнопка для добавления нового продукта
        onPressed: () {
          showDialog( // Показ диалогового окна для добавления продукта
            context: context,
            builder: (context) {
              String newProductName = ''; // Новое название продукта
              return AlertDialog( // Создание диалогового окна
                title: Text('Добавить продукт'),
                content: TextField( // Поле ввода для нового продукта
                  autofocus: true, // Автофокус на поле ввода
                  decoration: InputDecoration(
                    labelText: 'Название продукта',
                    border: OutlineInputBorder(), // Оформление границы поля
                  ),
                  onChanged: (value) { // Обработчик изменения текста
                    newProductName = value; // Обновление названия продукта
                  },
                ),
                actions: <Widget>[
                  TextButton( // Кнопка отмены
                    onPressed: () {
                      Navigator.of(context).pop(); // Закрытие диалогового окна
                    },
                    child: Text('Отмена'),
                  ),
                  TextButton( // Кнопка добавления продукта
                    onPressed: () {
                      if (newProductName.isNotEmpty) { // Проверка на пустое значение
                        _addProduct(newProductName); // Добавление продукта в список
                      }
                      Navigator.of(context).pop(); // Закрытие диалогового окна
                    },
                    child: Text('Добавить'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// Экран с виджетом ListView.separated
class ListViewSeparatedScreen extends StatefulWidget {
  @override
  _ListViewSeparatedScreenState createState() =>
      _ListViewSeparatedScreenState();
}

class _ListViewSeparatedScreenState extends State<ListViewSeparatedScreen> {
  List<String> products = ['Молоко', 'Яйца', 'Хлеб'];

  // Метод для добавления продукта
  void _addProduct(String productName) {
    setState(() {
      products.add(productName); // Добавление продукта в список
    });
  }

  // Метод для удаления продукта
  void _removeProduct(int index) {
    setState(() {
      products.removeAt(index); // Удаление продукта из списка
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView.separated'),
      ),
      body: Padding( // Добавление отступов вокруг содержимого
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated( // Создание списка с разделителями
          itemCount: products.length,
          // Количество элементов списка
          separatorBuilder: (context, index) => Divider(),
          // Создание разделителя между элементами
          itemBuilder: (context, index) { // Построение элементов списка
            return Card( // Создание карточки для элемента списка
              elevation: 3, // Тень карточки
              child: ListTile( // Виджет списка для элемента
                title: Text(products[index]),
                trailing: IconButton( // Кнопка для удаления элемента
                  icon: Icon(Icons.delete),
                  onPressed: () =>
                      _removeProduct(index), // Удаление элемента при нажатии
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton( // Кнопка для добавления нового продукта
        onPressed: () {
          showDialog( // Показ диалогового окна для добавления продукта
            context: context,
            builder: (context) {
              String newProductName = ''; // Новое название продукта
              return AlertDialog( // Создание диалогового окна
                title: Text('Добавить продукт'),
                content: TextField( // Поле ввода для нового продукта
                  autofocus: true, // Автофокус на поле ввода
                  decoration: InputDecoration( // Оформление поля ввода
                    labelText: 'Название продукта',
                    border: OutlineInputBorder(), // Оформление границы поля
                  ),
                  onChanged: (value) { // Обработчик изменения текста
                    newProductName = value; // Обновление названия продукта
                  },
                ),
                actions: <Widget>[
                  TextButton( // Кнопка отмены
                    onPressed: () {
                      Navigator.of(context).pop(); // Закрытие диалогогового окна
                    },
                    child: Text('Отмена'),
                  ),
                  TextButton( // Кнопка добавления продукта
                    onPressed: () {
                      if (newProductName.isNotEmpty) { // Проверка на пустое значение
                        _addProduct(newProductName); // Добавление продукта в список
                      }
                      Navigator.of(context).pop(); // Закрытие диалогового окна
                    },
                    child: Text('Добавить'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

