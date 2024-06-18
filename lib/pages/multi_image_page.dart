import 'dart:io';
import 'package:diabetesimageclassifier/classifier_model/classifier.dart';
import 'package:diabetesimageclassifier/main.dart';
import 'package:diabetesimageclassifier/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // For date and time formatting
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

class MultipleImagesClassifierPage extends StatefulWidget {
  const MultipleImagesClassifierPage({super.key});

  @override
  State<MultipleImagesClassifierPage> createState() => _MultipleImagesClassifierPageState();
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: <Widget>[
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
                              MaterialPageRoute(builder: (context) => const HomePage()),
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
                            child: Center(child: Text('Single Image Classifier', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white))),
                          )
                        ),

                      ],
                    )
                  )
                ),

                const SizedBox(height: 18),

                _images.isEmpty
                ? const Text('No images selected.')
                : Expanded(
                    child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Adjust columns as needed
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 30.0,
                    ),
                      itemCount: _images.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Container(
                                width: 130,
                                // height: _images[index] == null ? 200 : null,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 1, color: const Color.fromARGB(255, 197, 197, 197)),
                                ),
                                child: Image.file(_images[index]),
                              ),
                            ),
          
                            const SizedBox(height: 8),
                            if (index < _results.length)
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
            ),
          ),
        ),
      );
  }





  Future<void> _generatePdf() async {
    final pdf = pw.Document();
    final dateTime = DateFormat('yyyy-MM-dd // kk:mm').format(DateTime.now());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Classification Results', style: const pw.TextStyle(fontSize: 24)),
              pw.Text('Date and Time: $dateTime', style: const pw.TextStyle(fontSize: 16)),
              pw.SizedBox(height: 16),
              pw.ListView.builder(
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Image(
                        pw.MemoryImage(_images[index].readAsBytesSync()),
                        height: 100,
                        width: 100,
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        _results.isNotEmpty ? 'Label: ${_results[index]}' : 'Label: Unknown',
                        style: const pw.TextStyle(fontSize: 18),
                      ),
                      pw.SizedBox(height: 16),
                    ],
                  );
                },
              ),
            ],
          );
        },
      )
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/classification_results.pdf");
    await file.writeAsBytes(await pdf.save());

    await Printing.sharePdf(bytes: await pdf.save(), filename: 'classification_results.pdf');

  //   final directory = await getExternalStorageDirectory();
  // final file = File("${directory?.path}/classification_results.pdf");

  // final pdfBytes = await pdf.save();
  // await file.writeAsBytes(pdfBytes.toList());

  // DocumentFileSavePlus.saveFile(pdfBytes, "classification_results.pdf", "classification_results/pdf");
  }

}
