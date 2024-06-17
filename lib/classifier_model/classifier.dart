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

  Future<List<Map<String, dynamic>>> classifyImages(List<File> images) async {
    List<Map<String, dynamic>> results = [];
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
        results.add({
          'label': output[0]['label'],
          'confidence': output[0]['confidence'],
        });
      } else {
        results.add({
          'label': 'Unknown',
          'confidence': 0.0,
        });
      }
    }
    return results;
  }

  Future<void> dispose() async {
    await Tflite.close();
  }
}
