import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'رسائل لا مركزية - تجريبي',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<_Message> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.insert(0, _Message(text: text, time: DateTime.now()));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تجريبي: رسائل محلية')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (c, i) {
                final m = _messages[i];
                return ListTile(
                  title: Text(m.text),
                  subtitle: Text(
                      '${m.time.hour.toString().padLeft(2,'0')}:${m.time.minute.toString().padLeft(2,'0')}'),
                );
              },
            ),
          ),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'اكتب رسالتك...',
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _send,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Message {
  final String text;
  final DateTime time;
  _Message({required this.text, required this.time});
}
