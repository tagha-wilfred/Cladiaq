import 'package:cladiaq/commons/widgets/buttom_navigation/cq_buttomn_nav_bar.dart';
import 'package:flutter/material.dart';

class AirQualityChatbotPage extends StatefulWidget {
  @override
  _AirQualityChatbotPageState createState() => _AirQualityChatbotPageState();
}

class _AirQualityChatbotPageState extends State<AirQualityChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _messages = [];

  // Simulate a response based on the user's question
  String _getBotResponse(String userInput) {
    if (userInput.toLowerCase().contains("air quality")) {
      return "Air quality depends on various factors like pollution levels. The current air quality is moderate.";
    } else if (userInput.toLowerCase().contains("pm2.5")) {
      return "PM2.5 refers to fine particulate matter in the air. High levels can cause respiratory issues.";
    } else if (userInput.toLowerCase().contains("improve air quality")) {
      return "To improve air quality, reduce the use of fossil fuels, promote public transport, and plant trees.";
    } else {
      return "I can help with air quality-related questions. Try asking about PM2.5, air pollution, or how to improve air quality.";
    }
  }

  // Handle the user's message
  void _handleMessage() {
    final userInput = _controller.text.trim();
    if (userInput.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': userInput});
      _controller.clear();

      // Get the chatbot's response
      final botResponse = _getBotResponse(userInput);
      _messages.add({'sender': 'bot', 'text': botResponse});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CqButtomnNavBar(
        page: 3,
      ),
      appBar: AppBar(
        title: Text("CLADIAQ AI"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';
                return ListTile(
                  title: Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue[100] : Colors.green[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(message['text']!),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask about air quality...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _handleMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
