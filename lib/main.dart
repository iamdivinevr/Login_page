import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Key Examples')),
      body: const KeyExamples(),
    );
  }
}

class KeyExamples extends StatefulWidget {
  const KeyExamples({Key? key}) : super(key: key);

  @override
  State<KeyExamples> createState() => _KeyExamplesState();
}

class _KeyExamplesState extends State<KeyExamples> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // GlobalKey
  final PageStorageKey<String> _pageStorageKey =
      PageStorageKey<String>('scroll_position'); // PageStorageKey
  final List<String> _items = List.generate(20, (index) => 'Item $index');
  final Map<int, Object> _objectMap = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Example 1: ValueKey
        Container(
          key: const ValueKey<String>('value_key_example'),
          padding: const EdgeInsets.all(8.0),
          color: Colors.blueAccent,
          child: const Text(
            'This container is identified by a ValueKey.',
            style: TextStyle(color: Colors.white),
          ),
        ),

        const SizedBox(height: 10),

        // Example 2: ObjectKey
        Container(
          key: ObjectKey(_objectMap),
          padding: const EdgeInsets.all(8.0),
          color: Colors.orange,
          child: const Text(
            'This container is identified by an ObjectKey.',
            style: TextStyle(color: Colors.white),
          ),
        ),

        const SizedBox(height: 10),

        // Example 3: UniqueKey
        ElevatedButton(
          key: UniqueKey(), // UniqueKey ensures a new key for each build
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Button with UniqueKey pressed!')),
            );
          },
          child: const Text('Click Me (UniqueKey)'),
        ),

        const SizedBox(height: 10),

        // Example 4: GlobalKey
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Enter some text'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter something';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Form validated!')),
                      );
                    }
                  },
                  child: const Text('Validate Form'),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Example 5: PageStorageKey
        Expanded(
          child: ListView.builder(
            key: _pageStorageKey, // Ensures scroll position is preserved
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_items[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
