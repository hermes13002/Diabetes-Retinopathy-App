import 'dart:io';
import 'package:tflite/tflite.dart';

class Classifier {
  List<String> labels = [];

  Classifier() {
    loadModel();
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model/model.tflite',
      labels: 'assets/model/labels.txt',
    );
  }

  Future<List<String>> classifyImages(List<File> images) async {
    List<String> results = [];
    for (File image in images) {
      var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true,
      );
      if (output != null && output.isNotEmpty) {
        results.add(output[0]['label']);
      } else {
        results.add('Unknown');
      }
    }
    return results;
  }

  void dispose() {
    Tflite.close(); 
  }
}
