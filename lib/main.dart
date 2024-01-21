import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'a',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 150, 120, 200)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void newWord(){
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var current = appState.current;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 200, 150, 150),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(current: current),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                appState.newWord();
              },
              child: Text('Próxima Palavra'),
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.current,
  });

  final WordPair current;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(color: theme.colorScheme.onPrimary);
    return Card(
      elevation: 12,
      color: theme.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(current.asPascalCase, style: style, semanticsLabel: "${current.first} ${current.second}",),
      ),
    );
  }
}