import 'dart:io';
import 'package:diabetesimageclassifier/classifier_model/classifier.dart';
import 'package:diabetesimageclassifier/loginScreen.dart';
import 'package:diabetesimageclassifier/mulitImagePage.dart';
import 'package:diabetesimageclassifier/registerScreen.dart';
import 'package:diabetesimageclassifier/splash_screen.dart';
import 'package:diabetesimageclassifier/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diabetes Image Classifier',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: const SplashScreen(),
    ); 
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  // classifyImages(List<File> images) {classifyImages(images);}
  // void dispose() {dispose();}
}

class _HomePageState extends State<HomePage> {
  // File? _image;
  // List? _output;
  // List<String> labels = [];

  // @override
  // void initState() {
  //   super.initState();
  //   loadModel().then((value) {
  //     setState(() {});
  //   });
  // }

  // loadModel() async {
  //   await Tflite.loadModel(
  //     model: 'assets/model/model.tflite',
  //     labels: 'assets/model/labels.txt',
  //   );
  // }


  // // For the single image classification
  // classifyImage(File image) async {
  //   var output = await Tflite.runModelOnImage(
  //     path: image.path,
  //     numResults: 2,
  //     threshold: 0.5,
  //     imageMean: 127.5,
  //     imageStd: 127.5,
  //   );
  //   setState(() {
  //     _output = output;
  //   });
  // }


  // // For the multi images classification
  // Future<List<String>> classifyImages(List<File> images) async {
  //   List<String> results = [];
  //   for (File image in images) {
  //     var output = await Tflite.runModelOnImage(
  //       path: image.path,
  //       imageMean: 0.0,
  //       imageStd: 255.0,
  //       numResults: 2,
  //       threshold: 0.2,
  //       asynch: true,
  //     );
  //     if (output != null && output.isNotEmpty) {
  //       results.add(output[0]['label']);
  //     } else {
  //       results.add('Unknown Image');
  //     }
  //   }
  //   return results;
  // }

  // @override
  // void dispose() {
  //   Tflite.close(); 
  //   super.dispose();
  // }


  final Classifier _classifier = Classifier();
  File? _image;
  String _result = '';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      List<Map<String, dynamic>> results = await _classifier.classifyImages([_image!]);
      setState(() {
        _result = results as String;
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Automated Detection of Diabetic Retinopathy', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.blue,),),
        backgroundColor: Colors.grey[200],
      ),
      drawer: const DrawerWidget(),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 35,
                ),
            
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      width: 200,
                      height: _image == null ? 200 : null,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: const Color.fromARGB(255, 197, 197, 197)),
                      ),
                      child: _image == null
                      ? Center(child: Text('No image selected.', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black)))
                      : Image.file(File(_image!.path)),
                    ),
                  ),
                ),
            
                const SizedBox(
                  height: 30,
                ),
            
                Center(
                  child: InkWell(
                    // onTap:() async {
                    //   var image = await ImagePicker().pickImage(source: ImageSource.gallery);
                    //   if (image == null) return;
                    //   setState(() {
                    //     _image = File(image.path);
                    //   });
                    // },
                    onTap: _pickImage,
                    child: Container(
                      width: 260,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: const Color.fromARGB(255, 197, 197, 197)),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.file_download, size: 23),
                          Text('Choose Picture from Gallery', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black))
                        ],
                      ),
                    )
                  ),
                ),
            
                const SizedBox(height: 10,),
            
                // InkWell(
                //   onTap: () {
                //     classifyImage(_image!);
                //     // print(_output);
                //     // print(_output![0]['confidence']);
                //   },
                //   child: Container(
                //     width: 200,
                //     height: 50,
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       border: Border.all(width: 1, color: const Color.fromARGB(255, 197, 197, 197)),
                //       borderRadius: BorderRadius.circular(15)
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         const Icon(Icons.smart_toy_sharp, size: 23),
                //         Text('Predict Image', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black))
                //       ],
                //     ),
                //   )
                // ),
            
                const SizedBox(height: 50,),
            
                Center(child: 
                  Container(
                    width: 300,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: const Color.fromARGB(255, 197, 197, 197)),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Result', style: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.blue)),
            
                        Text(
                          _result == null 
                          ? 'Result is shown here'
                          : 'Result: $_result',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black)
                        ),
                        Text(
                          _result == null
                          ? 'Confidence Level is shown here'
                          : 'Confidence Level: $_result%',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black)),
                      ],
                    )
                  )
                ),

                const SizedBox(height: 10,),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textResult(),
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.blue)
                    ),
                  ],
                ),

                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const MultipleImagesClassifierPage()),
                    );
                  },
                  child: const Text('Multiple Images'),
                )
            
              ],
            ),
          ),
        ),
      )
    );
  }


  textResult(){
    if(_result != null && _result == 'DR'){
      return 'The result shows that this patient has \nDiabetes Retinopathy.';
    } 
    else if (_result != null && _result == 'No_DR') {
      return 'The result does not indicate that this\npatient has Diabetes Retinopathy.';
    }
    else {
      return '';
    }
  }
}








