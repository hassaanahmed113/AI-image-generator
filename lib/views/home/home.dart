// ignore: must_be_immutable
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_to_image/views/home/home_provider.dart';

// ignore: must_be_immutable
class HomePage extends ConsumerWidget {
  HomePage({super.key});
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fWatch = ref.watch(homeProvider);
    final fRead = ref.read(homeProvider);

    return Scaffold(
      backgroundColor: const Color(0xff212121),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'EvoVisioArt AI',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.openSans().fontFamily),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  fWatch.isLoading == true
                      ? Container(
                          alignment: Alignment.center,
                          height: 320,
                          width: 320,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(
                                12.0,
                              )),
                          child: Image.memory(fWatch.imageData!),
                        )
                      : Container(
                          alignment: Alignment.center,
                          height: 320,
                          width: 320,
                          decoration: BoxDecoration(
                              color: const Color(0xff424242),
                              borderRadius: BorderRadius.circular(
                                12.0,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                size: 100,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'No Image has been generated yet.',
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xff424242),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: TextField(
                      controller: textController,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: GoogleFonts.openSans().fontFamily),
                      cursorColor: Colors.white,
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: 'Enter your prompt here...',
                          hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: GoogleFonts.openSans().fontFamily),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(12.0)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          fRead.textToImage(textController.text, context);
                          fRead.searchingChange(true);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: 160,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.deepPurpleAccent,
                                      Colors.purple
                                    ]),
                                color: Colors.purpleAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0))),
                            child: fWatch.isSearching == false
                                ? Text(
                                    'Generate',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.openSans().fontFamily),
                                  )
                                : const CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                      ),
                      GestureDetector(
                        onTap: () {
                          fRead.loadingChange(false);
                          textController.clear();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 160,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.pink, Colors.red]),
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          child: Text(
                            'Clear',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.openSans().fontFamily),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
