import 'package:flutter/material.dart';

class AutocorrectTestScreen extends StatefulWidget {
  const AutocorrectTestScreen({super.key});

  @override
  State<AutocorrectTestScreen> createState() => _AutocorrectTestScreenState();
}

class _AutocorrectTestScreenState extends State<AutocorrectTestScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Autocorrect Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Type "teh" and see if it autocorrects to "the"',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            
            // Simple TextField with autocorrect
            TextField(
              controller: _controller,
              autocorrect: true,
              enableSuggestions: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Test Autocorrect',
                hintText: 'Type "teh" here',
              ),
              onChanged: (value) {
                print('Text changed: $value');
              },
            ),
            
            const SizedBox(height: 20),
            
            Text('Current text: ${_controller.text}'),
            
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {
                _controller.clear();
              },
              child: const Text('Clear'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}