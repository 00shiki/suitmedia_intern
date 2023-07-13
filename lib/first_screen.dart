import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:suitmedia_intern/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late TextEditingController _nameController;
  late TextEditingController _palindromeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _palindromeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background_1.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 45),
                child: Image.asset(
                  "assets/images/ic_photo.png",
                  height: 116,
                  width: 116,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: "Name",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                  controller: _nameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                child: TextField(
                  style: GoogleFonts.poppins().copyWith(fontSize: 16),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(width: 0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    labelText: "Palindrome",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                  controller: _palindromeController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 41.0),
                    backgroundColor: const Color(0xFF2B637B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  onPressed: () {
                    if (checkPalindrome(_palindromeController.text)) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("isPalindrome"),
                            );
                          });
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AlertDialog(
                              title: Text("not Palindrome"),
                            );
                          });
                    }
                  },
                  child: Text(
                    "CHECK",
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 41.0),
                    backgroundColor: const Color(0xFF2B637B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondScreen(
                          name: _nameController.text,
                          username: "",
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "NEXT",
                    style: GoogleFonts.poppins(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool checkPalindrome(String text) {
  String textClean = text.split(' ').join();
  String textReverse = textClean.split('').reversed.join();
  if (textClean == textReverse) {
    return true;
  }
  return false;
}
