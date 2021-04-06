import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final greetingProvider = Provider((ref) => 'Hello Riverpod!');
final secondProvider = Provider((ref) => 'This is Second');

class IncrementNotifier extends ChangeNotifier {
  int _value = 0;
  int get value => _value;

  void increment() {
    _value += 1;
    notifyListeners();
  }
}

final incrementProvider = ChangeNotifierProvider((ref) => IncrementNotifier());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Riverpod'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            context.read(incrementProvider).increment();
          },
        ),
        body: Center(
          child: Consumer(
            builder: (context, watch, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    watch(incrementProvider).value.toString(),
                  ),
                  Text(
                    watch(greetingProvider),
                  ),
                  Text(
                    watch(secondProvider),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
