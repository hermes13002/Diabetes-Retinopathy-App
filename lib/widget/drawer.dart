import 'package:diabetesimageclassifier/pages/drawer_content.dart';
import 'package:diabetesimageclassifier/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
 Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 2, 208, 223),
      width: 260,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image:  AssetImage('assets/images/logo.jpg')
                )
              ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 12.0,
                  left: 16.0,
                  child: Text("Team Elite",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white)
                  )
                ),
              ]
            )
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.menu_book_rounded, size: 20),
            title: Text('About Project', 
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
            ),
            iconColor: Colors.white,
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutProject()
                )
              );
            }
          ),

          const Divider(color: Colors.white),

          const SizedBox(height: 10,),

          ListTile(
            leading: const Icon(Icons.error, size: 20),
            title: Text('Report Bug', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),),
            iconColor: Colors.white,
            onTap: (){
              Navigator.pop(context);
              contactButton(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.phone, size: 20),
            title: Text('Send Feedback', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),),
            iconColor: Colors.white,
            onTap: (){
              Navigator.pop(context);
              contactButton(context);
            },
          ),

          const SizedBox(height: 10,),

          const Divider(color: Colors.white),

          const SizedBox(height: 10,),

          ListTile(
            leading: const Icon(Icons.people_alt_outlined, size: 20),
            title: Text('Meet the Developers', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),),
            iconColor: Colors.white,
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MeetDevelopers()
                )
              );
            },
          ),

          const SizedBox(height: 10,),

          const Divider(color: Colors.white),

          const SizedBox(height: 10,),

          ListTile(
            leading: const Icon(Icons.logout_rounded, size: 20),
            title: Text('Logout', style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),),
            iconColor: Colors.white,
            onTap: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen()
                )
              );
            },
          ),

          const SizedBox(height: 10,),

          const Divider(color: Colors.white),

          const SizedBox(height: 10,),

          Align(alignment: Alignment.bottomCenter, child: Text('Version: 1.0.0', style: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.white))),
          
          
        ],
      ),
    );
  }


  // The method for contact button bottom sheet
  Future contactButton(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Wrap(
            children: [

              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Gmail'),
                onTap: () async {
                  // ignore: body_might_complete_normally_nullable
                  String? encodeQueryParameters(Map<String, String> params) {
                    params.entries
                        .map((MapEntry<String, String> e) =>
                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                        .join('&');
                    // return null;
                  }

                  final Uri emailLaunchUri = Uri(
                      scheme: 'mailto',
                      path: 'soaresayoigbala@gmail.com',
                      query: encodeQueryParameters(
                          <String, String>{'Contact': 'Hi there!'}));

                  // if (await launchUrl(emailLaunchUri)) {
                  //   launchUrl(emailLaunchUri);
                  // } else {
                  //   throw Exception('Could not launch $emailLaunchUri');
                  // }

                  try {
                    await launchUrl(emailLaunchUri);
                  } catch (e) {
                    // ignore: avoid_print
                    print(e.toString());
                  }
                },
              )
            ],
          );
        });
  }

}