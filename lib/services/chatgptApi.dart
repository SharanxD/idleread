import 'dart:convert';

import 'package:http/http.dart' as http;

class gptApi {
  Future<void> test(String word) async {
    String url = "https://api.openai.com/v1/chat/completions";
    String key = "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";
    final header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${key}"
    };
    final body = {
      'model': 'gpt-3.5-turbo',
      'temperature': 0.7,
      'messages': [
        {'role': 'user', 'content': 'Whats the meaning of ${word} in one line?'}
      ]
    };
    String jsonData = jsonEncode(body);
    final response =
        await http.post(Uri.parse(url), headers: header, body: jsonData);
    if (response.statusCode == 200) {
      Map<String, dynamic> resp = jsonDecode(response.body);
      print("Response: ${resp}");
    } else {
      print("Error");
    }
  }
}
