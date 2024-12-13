import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class HomeController extends GetxController {
  var translator = ['English', 'Urdu','Arabic','Hindi','Gujarati'];
  var orgLanguage = ''; // No default value initially
  var desLanguage = ''; // No default value initially
  TextEditingController languageController = TextEditingController();

  var output = '';

  @override
  void onInit() {
    super.onInit();
  }

  Future showExitDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Exit App",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          content: const Text("Are you sure you want to exit?",style: TextStyle(color: Colors.white,fontSize: 16)),
          backgroundColor: const Color(0xff10223d),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("No",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Yes",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
            ),
          ],
        );
      },
    );
  }


  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = GoogleTranslator();
    try {
      if (src.isEmpty || dest.isEmpty || input.isEmpty) {
        output = "Please fill all fields";
      } else {
        var translation = await translator.translate(input, from: src, to: dest);
        output = translation.text;
      }
    } catch (e) {
      output = "Failed to translate: ${e.toString()}";
    }
    update();
  }

  String getLanguageCode(String language) {
    if (language == "Hindi") {
      return "hi";
    } else if (language == "Urdu") {
      return "ur";
    } else if (language == "English") {
      return "en";
    }else if (language == "Arabic") {
      return "ar";
    }else if (language == "Gujarati") {
      return "gu";
    }
    return "";
  }
    @override
    void onClose() {
      super.onClose();
      languageController.dispose(); // Clean up the controller
    }
  }