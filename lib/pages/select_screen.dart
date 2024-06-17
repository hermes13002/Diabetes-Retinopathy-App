import 'package:diabetesimageclassifier/main.dart';
import 'package:diabetesimageclassifier/pages/multi_image_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectClassifier extends StatelessWidget {
  const SelectClassifier({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Automated Detection of Diabetic Retinopathy', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.blue,),),
        backgroundColor: Colors.grey[200],
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 250,),

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
            
                const SizedBox(height: 20,),
            
                Center(
                  child: InkWell(
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
                ),
            
              ],
            ),
          ),
        ),
      )
    );
  }
}