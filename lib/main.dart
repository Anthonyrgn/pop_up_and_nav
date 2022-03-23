import 'package:flutter/material.dart';
import 'package:pop_up_and_nav/next.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Pop Up et Nav'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color btnColor = Colors.greenAccent;
  Color appBarColor = Colors.lightBlueAccent;

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: (() => showMyDialog(dialog: createAlert())),
              child: const Text("Montrer une alerte"),
            ),
            ElevatedButton(
                onPressed: () {
                   showMyDialog(dialog: createSimple());
                },
                child: const Text("Montrer simple")),
            ElevatedButton(
                onPressed: () {
                  final nextPage  = Next(color: appBarColor);
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext) {
                      return nextPage;
                  }));
                },
                child: Text("Page suivante")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: btnColor,
        onPressed: () {
          final snackbar = SnackBar(content: Text("Mon premier snack"));
          ScaffoldMessenger.of(context)
              .showSnackBar(createSnack(text: "Snack bar évoluée"));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), //
    );
  }

  SnackBar createSnack({required String text}) {
    final content = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [const Icon(Icons.house), Text(text)],
    );
    final snack = SnackBar(
      content: content,
      action: SnackBarAction(
        label: "Clique ici",
        onPressed: () {
          setState(() {
            btnColor = (btnColor == Colors.greenAccent)
                ? Colors.redAccent
                : Colors.greenAccent;
          });
        },
        textColor: Colors.red,
      ),
      backgroundColor: Colors.greenAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      elevation: 8,
    );
    return snack;
  }

  SimpleDialog createSimple() {
    final simple = SimpleDialog(
      titlePadding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        backgroundColor: Colors.red,
        title: Text("My simple dialog"),
        children: [
          const Icon(Icons.house),
          const Text("Le contenu de mon dialog"),
          const Divider(),
          const Text("Pop up"),
          option(),
        ],
    );
    return simple;
  }

  SimpleDialogOption option(){
    return SimpleDialogOption(
      onPressed: (){
        Navigator.of(context).pop();
      },
      child: const Text("OK"),
    );
  }

  AlertDialog createAlert() {
    return AlertDialog(
      title: const Text("Ma premiere alerte"),
      content: const Text(
        "J'ai créer ma premier alerte",
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK")),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              appBarColor =
              (appBarColor == Colors.lightBlueAccent)
                  ? Colors.lightGreenAccent
                  : Colors.lightBlueAccent;
            });
          },
          child: Text("Changer le App bar"),
        )
      ],
    );
  }

  Future<void> showMyDialog({required Widget dialog}) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext ctx) {
          return dialog;
        });
  }
}
