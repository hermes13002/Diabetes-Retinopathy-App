import 'dart:io';
import 'package:diabetesimageclassifier/classifier_model/classifier.dart';
import 'package:diabetesimageclassifier/main.dart';
import 'package:diabetesimageclassifier/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class MultipleImagesClassifierPage extends StatefulWidget {
  const MultipleImagesClassifierPage({super.key});

  @override
  _MultipleImagesClassifierPageState createState() => _MultipleImagesClassifierPageState();
}

class _MultipleImagesClassifierPageState extends State<MultipleImagesClassifierPage> {
  final Classifier _classifier = Classifier();
  List<File> _images = [];
  List<String> _results = [];

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images = pickedFiles.map((file) => File(file.path)).toList();
      });
      List<String> results = await _classifier.classifyImages(_images);
      setState(() {
        _results = results;
      });
    }
  }

  @override
  void dispose() {
    _classifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Automated Detection of \nDiabetic Retinopathy', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.blue,),),
          leading: IconButton(onPressed: (){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }, icon: const Icon(Icons.arrow_back_ios_rounded)),
          backgroundColor: Colors.grey[200],
        ),
        drawer: const DrawerWidget(),
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: <Widget>[
                _images.isEmpty
                ? const Text('No images selected.')
                : Expanded(
                    child: ListView.builder(
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                width: 200,
                                // height: _images[index] == null ? 200 : null,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 1, color: const Color.fromARGB(255, 197, 197, 197)),
                                ),
                                child: Image.file(_images[index]),
                              ),
                            ),
          
                            const SizedBox(height: 8),
                            Text(
                               _results.isNotEmpty ? _results[index] : '',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      },
                    ),
                  ),
          
                  const SizedBox(height: 10),
          
                  InkWell(
                    onTap: _pickImages,
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: const Color.fromARGB(255, 197, 197, 197)),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.file_download, size: 23),
                          Text('Pick Images', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black))
                        ],
                      ),
                    )
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
