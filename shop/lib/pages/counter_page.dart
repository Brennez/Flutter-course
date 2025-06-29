import 'package:flutter/material.dart';
import 'package:shop/providers/counter.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    var provider = CounterProvider.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Exemplo counter'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(provider.state.value.toString()),
          IconButton(
            onPressed: () {
              setState(() {
                provider.state.increment();
              });
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                provider.state.decrement();
              });
            },
            icon: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
