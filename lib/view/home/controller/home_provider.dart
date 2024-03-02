import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeProvider extends ChangeNotifier {
  Uint8List? imageData;
  TextEditingController textController = TextEditingController();

  bool isLoading = false;
  bool searchChanging = false;

  void loadingUpdate(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void searchUpdate(bool val) {
    searchChanging = val;
    notifyListeners();
  }

  Future<void> textToImage() async {
    String engineId = "stable-diffusion-v1-6";
    String apiHost = "https://api.stability.ai";
    String apiKey = "API-KEY HERE";

    final response = await http.post(
        Uri.parse('$apiHost/v1/generation/$engineId/text-to-image'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'image/png',
          'Authorization': 'Bearer $apiKey'
        },
        body: jsonEncode(
          {
            "text_prompts": [
              {"text": textController.text, "weight": 1},
            ],
            "cfg_scale": 7,
            "height": 1024,
            "width": 1024,
            "samples": 1,
            "steps": 30,
          },
        ));

    if (response.statusCode == 200) {
      imageData = response.bodyBytes;
      loadingUpdate(false);
      searchUpdate(true);
      notifyListeners();
    } else {
      debugPrint(response.statusCode.toString());
    }
  }
}
