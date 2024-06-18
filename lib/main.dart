import 'dart:io';
import 'package:diabetesimageclassifier/classifier_model/classifier.dart';
import 'package:diabetesimageclassifier/db_model.dart';
import 'package:diabetesimageclassifier/pages/multi_image_page.dart';
import 'package:diabetesimageclassifier/pages/splash_screen.dart';
import 'package:diabetesimageclassifier/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:tflite/tflite.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart'; // For date and time formatting
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diabetes Retinopathy Image Classifier',
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
      List<String> results = await _classifier.classifyImages([_image!]);
      setState(() {
        _result = results.isNotEmpty ? results[0] : 'Unknown';
      });
    }
  }

  // @override
  // void dispose() {
  //   _classifier.dispose();
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Automated Detection of Diabetic Retinopathy', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.blue,),),
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
                  height: 10,
                ),

                Center(child: 
                  Container(
                    width: 350,
                    height: 70,
                    padding: const EdgeInsets.only(top:12, bottom:12, right: 8, left:8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: const Color.fromARGB(255, 197, 197, 197)),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Navigate to:',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black)
                        ),

                        const SizedBox(width: 10),

                        InkWell(
                          onTap:() {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const MultipleImagesClassifierPage()),
                            );
                          },
                          child: Container(
                            width: 210,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(width: 1, color: const Color.fromARGB(255, 197, 197, 197)),
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(child: Text('Multiple Image Classifier', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white))),
                          )
                        ),

                      ],
                    )
                  )
                ),

                const SizedBox(
                  height: 25,
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
                      : Image.file(_image!),
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
                      width: 200,
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
                          Text('Pick Image', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black))
                        ],
                      ),
                    )
                  ),
                ),
            
                // const SizedBox(height: 10,),
            
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
            
                const SizedBox(height: 20,),
            
                Center(child: 
                  Container(
                    width: 350,
                    height: 250,
                    padding: const EdgeInsetsDirectional.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: const Color.fromARGB(255, 197, 197, 197)),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        Text(
                          _result == null 
                          ? 'Result is shown here'
                          : 'Result: $_result',
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black)
                        ),
                        // Text(
                        //   _result == null
                        //   ? 'Confidence Level is shown here'
                        //   : 'Confidence Level: $_result%',
                        //   style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black)),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              textResult(),
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.blue)
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        Center(
                          child: InkWell(
                            onTap:_generatePdf,
                            child: Container(
                              width: 210,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                border: Border.all(width: 1, color: const Color.fromARGB(255, 197, 197, 197)),
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Center(child: Text('Download Result', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white))),
                            )
                          ),
                        ),

                      ],
                    )
                  )
                ),

                const SizedBox(height: 10,)
              ],
            ),
          )
        ),
      )
    );
  }


  textResult(){
    if(_result != null && _result == 'DR'){
      return 'The result shows that this \npatient has Diabetes Retinopathy.';
    } 
    else if (_result != null && _result == 'No_DR') {
      return 'The result does not indicate that \nthis patient has \nDiabetes Retinopathy.';
    }
    else {
      return '';
    }
  }



  Future<void> _generatePdf() async {
  final pdf = pw.Document();
  final dateTime = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Text('Classification Results', style: const pw.TextStyle(fontSize: 24)),
            pw.Text('Date and Time: $dateTime', style: const pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 16),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                
                pw.Image(
                  pw.MemoryImage(_image!.readAsBytesSync()),
                  height: 100,
                  width: 100,
                ),
                pw.SizedBox(height: 8),
                pw.Text(
                  _result.isNotEmpty ? 'Label: $_result' : 'Label: Unknown',
                  style: const pw.TextStyle(fontSize: 18),
                ),
                pw.SizedBox(height: 16),
              ],
            ),
            pw.Text(
              textResult(),
              style: const pw.TextStyle(fontSize: 18),
            ),
          ],
        );
      },
    ),
  );

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/classification_results.pdf");
  await file.writeAsBytes(await pdf.save());

  await Printing.sharePdf(bytes: await pdf.save(), filename: 'classification_results.pdf');
}

}








