import 'package:flutter/material.dart';

void main() {
  runApp(const SurfApp());
}

class SurfApp extends StatelessWidget {
  const SurfApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePageStateful(title: 'Counter v. 2.0'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePageStateful extends StatefulWidget {
  final String title;

  const HomePageStateful({required this.title, Key? key}) : super(key: key);

  @override
  State<HomePageStateful> createState() => _HomePageStatefulState();
}

class _HomePageStatefulState extends State<HomePageStateful> {
  int _counter = 0;
  int _incrementPressCounter = 0;
  int _decrementPressCounter = 0;

  void _incrementCounter() {
    setState(() {
      _counter += 1;
      _incrementPressCounter += 1;
    });
  }

  /// функция уменьшения значения с проверкой на неотрицательность
  void _decrementCounter() {
    if (_counter >= 1) {
      setState(() {
        _counter -= 1;
        _decrementPressCounter += 1;
      });
    }
    else {
      setState(() {
        _decrementPressCounter += 1;
      });
      print('value must be more than zero');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Value:',
            ),
            Text(
              '$_counter',
              style: Theme
                .of(context)
                .textTheme
                .headlineMedium,
            ),

            const Text(
              'Increment button has been pressed this many times:',
            ),
            Text(
              '$_incrementPressCounter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
            ),

            const Text(
              'Decrement button has been pressed this many times:',
            ),
            Text(
              '$_decrementPressCounter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium,
            ),
          ],
        ),
      ),
      /// инициализация кнопок увеличения/уменьшения значения, с расположением внизу-справа экрана, с отступом между ними
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 10)
            ),
            FloatingActionButton(
              onPressed: _decrementCounter,
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ],
        ),
    );
  }
}