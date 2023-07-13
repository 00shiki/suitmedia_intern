import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:suitmedia_intern/third_screen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key, required this.name, required this.username});

  final String name;
  final String username;

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Second Screen",
          style: GoogleFonts.poppins().copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          child: const Icon(
            IconlyLight.arrow_left_2,
            color: Color(0xFF554AF0),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: GoogleFonts.poppins().copyWith(fontSize: 12),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    widget.name,
                    style: GoogleFonts.poppins().copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Text(
              widget.username == "" ? "Selected User Name" : widget.username,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins().copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThirdScreen(name: widget.name),
                  ),
                );
              },
              style: TextButton.styleFrom(
                minimumSize: const Size(double.infinity, 41.0),
                backgroundColor: const Color(0xFF2B637B),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(12.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
              ),
              child: const Text("Choose a user"),
            )
          ],
        ),
      ),
    );
  }
}
