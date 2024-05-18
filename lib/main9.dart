import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

// Класс задачи
class Task {
  String title;
  bool isCompleted;

  Task(this.title, this.isCompleted);
}

// InheritedWidget для управления состоянием задач
class TaskInheritedWidget extends InheritedWidget {
  final List<Task> tasks;
  final Function(Task) addTask;
  final Function(int) toggleTaskCompletion;

  TaskInheritedWidget({
    required Widget child,
    required this.tasks,
    required this.addTask,
    required this.toggleTaskCompletion,
  }) : super(child: child);

  static TaskInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskInheritedWidget>();
  }

  @override
  bool updateShouldNotify(covariant TaskInheritedWidget oldWidget) {
    return oldWidget.tasks != tasks;
  }
}

// Настройка GetIt
final getIt = GetIt.instance;

// TaskService для GetIt, использует ChangeNotifier для уведомлений
class TaskService extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners(); // Уведомить об изменении состояния
  }

  void toggleTaskCompletion(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    notifyListeners(); // Уведомить об изменении состояния
  }
}

// Регистрация TaskService в GetIt
void setup() {
  getIt.registerSingleton<TaskService>(TaskService());
}

void main() {
  setup();
  runApp(AppState(
    data: 'InheritedWidget',
    child: MyApp(),
  ));
}

// InheritedWidget для состояния приложения
class AppState extends InheritedWidget {
  final String data;
  final Widget child;

  AppState({required this.data, required this.child}) : super(child: child);

  static AppState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
  }

  @override
  bool updateShouldNotify(covariant AppState oldWidget) {
    return oldWidget.data != data;
  }
}

// Основное приложение
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<TaskService>(),
      child: MaterialApp(
        home: TaskProvider(),
      ),
    );
  }
}

// TaskProvider для управления состоянием задач через InheritedWidget
class TaskProvider extends StatefulWidget {
  @override
  _TaskProviderState createState() => _TaskProviderState();
}

class _TaskProviderState extends State<TaskProvider> {
  List<Task> tasks = [];

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TaskInheritedWidget(
      tasks: tasks,
      addTask: addTask,
      toggleTaskCompletion: toggleTaskCompletion,
      child: TaskScreen(),
    );
  }
}

// Основной экран приложения
class TaskScreen extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();

  // Диалог для добавления новой задачи
  Future<void> _showAddTaskDialog(BuildContext context, Function(String) onAddTask) async {
    _taskController.clear();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Добавить задачу'),
          content: TextField(
            controller: _taskController,
            decoration: InputDecoration(hintText: 'Введите название задачи'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Добавить'),
              onPressed: () {
                onAddTask(_taskController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Получение задач из InheritedWidget
    final inheritedTasks = TaskInheritedWidget.of(context)?.tasks ?? [];
    // Получение задач из TaskService (GetIt)
    final taskService = Provider.of<TaskService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Практическая работа №9'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: inheritedTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(inheritedTasks[index].title),
                  trailing: Checkbox(
                    value: inheritedTasks[index].isCompleted,
                    onChanged: (_) {
                      TaskInheritedWidget.of(context)
                          ?.toggleTaskCompletion(index);
                    },
                  ),
                );
              },
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: taskService.tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(taskService.tasks[index].title),
                  trailing: Checkbox(
                    value: taskService.tasks[index].isCompleted,
                    onChanged: (_) {
                      taskService.toggleTaskCompletion(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context, (taskTitle) {
            // Добавление задачи через InheritedWidget
            TaskInheritedWidget.of(context)
                ?.addTask(Task(taskTitle, false));
            // Добавление задачи через TaskService (GetIt)
            taskService.addTask(Task(taskTitle, false));
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}



/*
AppState (InheritedWidget)
  |
  v
TaskProvider (Widget)
  |   ^
  |   |
  v   v
TaskScreen (Widget)
  |   ^
  |   |
  v   v
TaskService (GetIt)
*/