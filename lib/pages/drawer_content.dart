import 'dart:io';
import 'package:diabetesimageclassifier/main.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutProject extends StatelessWidget {
  const AboutProject ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About the Project', style: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 20, color: Colors.blue),),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage()
            )
          );
        }, icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),

      backgroundColor: Colors.grey[200],

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          // child: Text(_aboutProjectText, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black)),
          child: Column(
            children: [
              Card(
                child: ExpansionTile(
                  title: Text("Introduction", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.blue)),
                  childrenPadding: const EdgeInsets.all(12),
                  children: [
                    Text(
                      "Diabetic retinopathy (DR) is a leading cause of blindness in adults worldwide, caused by damage to the blood vessels in the retina due to diabetes. Early detection and treatment are crucial to prevent vision loss. This project aims to develop a deep learning model to classify retinal images and determine the presence and severity of diabetic retinopathy, enhancing the efficiency and accessibility of diagnosis.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              Card(
                child: ExpansionTile(
                  title: Text("Aim", style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.blue)),
                  children: [
                    Text(
                      "The primary goal of this project is to develop a deep learning model capable of classifying retinal images into different stages of diabetic retinopathy. The secondary goal is to deploy this model into a mobile application, making it accessible for widespread use.",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "For more information, click the link below to checkout the documentation;",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.blue)
                ),
              ),

              TextButton(
                onPressed: () async{
                  var androidUrl = "https://github.com/TolaniSilas/Diabetic-Retinopathy-Project";
                  var iosUrl = "https://github.com/TolaniSilas/Diabetic-Retinopathy-Project";
              
                  try {
                    if (Platform.isIOS) {
                      await launchUrl(Uri.parse(iosUrl));
                    } else {
                      await launchUrl(Uri.parse(androidUrl));
                    }
                  } on Exception {
                    EasyLoading.showError('Could not launch link, connect to internet.');
                  }
                },
                child: Text("Link to Documentation",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.blue)
              ),
                            )
            ],
          ),
        ),
      )
    );
  }
}


class MeetDevelopers extends StatelessWidget {
  const MeetDevelopers ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meet the Developers', style: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 20, color: Colors.blue),),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage()
            )
          );
        }, icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),

      backgroundColor: Colors.grey[200],

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: () async {
                  var androidUrl = "https://github.com/hermes13002";
                  var iosUrl = "https://github.com/hermes13002";

                  try {
                    if (Platform.isIOS) {
                      await launchUrl(Uri.parse(iosUrl));
                    } else {
                      await launchUrl(Uri.parse(androidUrl));
                    }
                  } on Exception {
                    EasyLoading.showError('Could not launch link, connect to internet.');
                  }
                },
                child: Container(
                  width: 350,
                  height: 200,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: const Color.fromARGB(255, 197, 197, 197)),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 80,
                        height: 80,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/logo.jpg'),
                          radius: 25,
                        ),
                      ),
                      Text('Soares Ayoigbala', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
          
              InkWell(
                onTap: () async {
                  var androidUrl = "https://github.com/TolaniSilas";
                  var iosUrl = "https://github.com/TolaniSilas";

                  try {
                    if (Platform.isIOS) {
                      await launchUrl(Uri.parse(iosUrl));
                    } else {
                      await launchUrl(Uri.parse(androidUrl));
                    }
                  } on Exception {
                    EasyLoading.showError('Could not launch link, connect to internet.');
                  }
                },
                child: Container(
                  width: 350,
                  height: 200,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: const Color.fromARGB(255, 197, 197, 197)),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 80,
                        height: 80,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/logo.jpg'),
                          radius: 25,
                        ),
                      ),
                      Text('Osunba Silas', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),

              InkWell(
                onTap: () async {
                  var androidUrl = "https://github.com/Oluwakorede112";
                  var iosUrl = "https://github.com/Oluwakorede112";

                  try {
                    if (Platform.isIOS) {
                      await launchUrl(Uri.parse(iosUrl));
                    } else {
                      await launchUrl(Uri.parse(androidUrl));
                    }
                  } on Exception {
                    EasyLoading.showError('Could not launch link, connect to internet.');
                  }
                },
                child: Container(
                  width: 350,
                  height: 200,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: const Color.fromARGB(255, 197, 197, 197)),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 80,
                        height: 80,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/logo.jpg'),
                          radius: 25,
                        ),
                      ),
                      Text('Ogundipe Elijah', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

}
