import 'package:diabetesimageclassifier/db_model.dart';
import 'package:diabetesimageclassifier/main.dart';
import 'package:diabetesimageclassifier/registerScreen.dart';
import 'package:diabetesimageclassifier/select_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      var user = await DatabaseHelper().getUser(
        _usernameController.text,
        _passwordController.text,
      );
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login successful!'),
        ));
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SelectClassifier()),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid username or password'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.blue,),),
        backgroundColor: Colors.grey[200],
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[

              TextFormField(
                cursorColor: Colors.blue,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Colors.blue,
                ),
                controller: _usernameController,
                validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.blue,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1),
                  ),
                ),
              ),

              const SizedBox(height: 20,),
              TextFormField(
                cursorColor: Colors.blue,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Colors.blue,
                ),
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                return null;
              },
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.blue,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1),
                  ),
                ),
              ),
      
              const SizedBox(height: 20),

              InkWell(
                onTap: _login,
                child: Container(
                  // width: 50,
                  // height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), 
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text("Login", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.white,),
                  ),
                ),
              ),
      
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),

                   TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text('Register', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.blue,),)
                  ),
                ],
              )
             
            ],
          ),
        ),
      ),
    );
  }
}
