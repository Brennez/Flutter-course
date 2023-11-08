import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Nativo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _sum = 0;
  int _number1 = 0;
  int _number2 = 0;

  Future<void> _calcSum() async {
    const channel = MethodChannel('br.com.example/native');

    try {
      final sum = await channel.invokeMethod('calcSum', {
        'number1': _number1,
        'number2': _number2,
      });

      setState(() {
        _sum = sum;
      });
    } on PlatformException catch (e) {
      setState(() {
        _sum = 0000;
      });
    }

    setState(() {
      _sum = _number1 + _number2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("App Nativo"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Resultado: ${_sum}',
                style: TextStyle(fontSize: 20),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _number1 = int.tryParse(value) ?? 0;
                  });
                },
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Icon(
                  Icons.add,
                  size: 40,
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _number2 = int.tryParse(value) ?? 0;
                  });
                },
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: _calcSum,
                child: Text(
                  'Somar',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
