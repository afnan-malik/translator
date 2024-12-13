import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            return
            await controller.showExitDialog(context) ?? false;
          },
          child: Scaffold(
            backgroundColor: const Color(0xff10223d),
            appBar: AppBar(
              title: const Text(
                'Translator',
                style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w500),
              ),
              backgroundColor: const Color(0xff10223d),
              centerTitle: true,
              elevation: 0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Source Language Dropdown
                        DropdownButton<String>(
                          value: controller.orgLanguage.isEmpty ? null : controller.orgLanguage,
                          items: controller.translator.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.orgLanguage = value!;
                            controller.update();
                          },
                          focusColor: Colors.white,
                          iconEnabledColor: Colors.white,
                          iconDisabledColor: Colors.white,
                          hint: const Text(
                            'From',
                            style: TextStyle(color: Colors.white),
                          ),
                          dropdownColor: const Color(0xff10223d),
                          icon: const Icon(Icons.keyboard_arrow_down),
                        ),
                        const SizedBox(width: 40),
                        const Icon(
                          Icons.arrow_right_alt_outlined,
                          size: 40,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 40),
                        // Destination Language Dropdown
                        DropdownButton<String>(
                          value: controller.desLanguage.isEmpty ? null : controller.desLanguage,
                          items: controller.translator.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            controller.desLanguage = value!;
                            controller.update();
                          },
                          focusColor: Colors.white,
                          iconEnabledColor: Colors.white,
                          iconDisabledColor: Colors.white,
                          hint: const Text(
                            'To',
                            style: TextStyle(color: Colors.white),
                          ),
                          dropdownColor: const Color(0xff10223d),
                          icon: const Icon(Icons.keyboard_arrow_down),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    // Text Input Field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value){
                          controller.update();
                        },
                        controller: controller.languageController,
                        cursorColor: Colors.white,
                        autofocus: false,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          suffixIcon: controller.languageController.text.isNotEmpty?IconButton(
                              onPressed: () {
                                controller.languageController.clear();
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.white,
                              )):const SizedBox.shrink(),
                          labelText: 'Please Enter Your Text',
                          labelStyle: const TextStyle(fontSize: 14, color: Colors.white),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.white),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1.5
                          )
                        ),
                          errorStyle: const TextStyle(color: Colors.red, fontSize: 15),
                        ),
                      ),
                    ),
                    // Translate Button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 4,
                            backgroundColor: Color(0xff10223d),
                            shadowColor: Colors.white,
                            animationDuration:Duration(seconds: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        onPressed: () {
                          controller.translate(controller.getLanguageCode(controller.orgLanguage), controller.getLanguageCode(controller.desLanguage), controller.languageController.text.toString());
                        },
                        child: const Text('Translate',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Output Text
                    GestureDetector(
                      onLongPress: (){
                        Clipboard.setData(ClipboardData(text: controller.output));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Center(child: Text("Text copied to clipboard!")),
                            backgroundColor: Color(0xff10223d),
                          duration: Duration(seconds: 2)),
                        );
                      },
                      child: Text(
                        controller.output,
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
