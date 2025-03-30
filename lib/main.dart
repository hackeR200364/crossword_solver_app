import 'dart:developer';

import 'package:cross_word_solver/solver.dart';
import 'package:cross_word_solver/styles.dart';
import 'package:cross_word_solver/utils/custom_btn.dart';
import 'package:cross_word_solver/utils/custom_text_form_field.dart';
import 'package:cross_word_solver/utils/snack_bar_utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crossword Solver',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _clueTextEditingController,
      _patternTextEditingController;
  CrosswordSolver solver = CrosswordSolver();
  List<String> solutions = [];
  bool loading = false, searched = false;

  loadWords() async {
    await solver.loadWords();
  }

  @override
  void initState() {
    _clueTextEditingController = TextEditingController();
    _patternTextEditingController = TextEditingController();
    loadWords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "Crossword Solver",
              style: TextStyle(
                color: AppColors.black,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 5,
                bottom: 10,
              ),
              child: Column(
                children: [
                  CustomTextField(
                    hint: "Please Enter the clue",
                    keyboard: TextInputType.text,
                    textEditingController: _clueTextEditingController,
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    hint: "Please Enter the pattern",
                    keyboard: TextInputType.text,
                    textEditingController: _patternTextEditingController,
                  ),
                  SizedBox(height: 10),
                  CustomBtn(
                    horizontalMargin: 0,
                    onTap: (() async {
                      if (_clueTextEditingController.text.isNotEmpty &&
                          _patternTextEditingController.text.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          loading = true;
                        });
                        solutions = await solver
                            .solveCrossword(
                                _clueTextEditingController.text.trim(),
                                _patternTextEditingController.text.trim())
                            .whenComplete(() {
                          setState(() {
                            loading = false;
                            searched = true;
                          });
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          AppSnackBar.customizedAppSnackBar(
                            message: "Please fill the fields correctly",
                            context: context,
                          ),
                        );
                      }
                      log(solutions.isNotEmpty
                          ? solutions.toString()
                          : "Empty");
                    }),
                    text: "Search",
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          if (solutions.isEmpty && searched)
            SliverToBoxAdapter(
              child: Center(
                child: Text("No matches found"),
              ),
            ),
          if (loading)
            SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.green,
                ),
              ),
            ),
          if (solutions.isNotEmpty && !loading)
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  "Results",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          if (solutions.isNotEmpty && !loading)
            SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
          if (solutions.isNotEmpty && !loading)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                ((ctx, idx) {
                  return Container(
                    height: 40,
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 5,
                      bottom: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        solutions[idx],
                      ),
                    ),
                  );
                }),
                childCount: solutions.length,
              ),
            )
        ],
      ),
    );
  }
}
