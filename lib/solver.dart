import 'dart:convert';

import 'package:flutter/services.dart';

class CrosswordSolver {
  late Set<String> validWords;

  CrosswordSolver();

  /// Load words from the file
  Future<void> loadWords() async {
    String data = await rootBundle.loadString('assets/words/unique_words.txt');
    List<String> words = LineSplitter.split(data).toList();
    validWords = words
        .map((word) => word.trim().toLowerCase())
        .where(
            (word) => word.length > 2 && RegExp(r'^[a-zA-Z]+$').hasMatch(word))
        .toSet();
  }

  /// Find words that match the pattern (like _o_) and have the same length
  List<String> findMatchingWords(String pattern) {
    String regexPattern = "^${pattern.replaceAll('_', '.')}"; // Convert _ to .
    RegExp regex = RegExp(regexPattern);
    return validWords
        .where((word) => regex.hasMatch(word) && word.length == pattern.length)
        .toList();
  }

  /// Rank words based on TF-IDF similarity with the clue
  List<String> rankMatches(String clue, List<String> matches) {
    if (matches.isEmpty) return [];

    Map<String, double> tfidfScores = {};
    Map<String, int> wordFreq = {};

    // Calculate term frequency (TF) for each match
    for (String match in matches) {
      wordFreq[match] = clue.split(' ').where((word) => word == match).length;
    }

    // Compute TF-IDF scores (simplified without full document frequency)
    for (String match in matches) {
      double score = (wordFreq[match] ?? 0) / clue.split(' ').length;
      tfidfScores[match] = score;
    }

    // Sort by highest score
    matches
        .sort((a, b) => (tfidfScores[b] ?? 0).compareTo(tfidfScores[a] ?? 0));
    return matches.take(10).toList();
  }

  /// Solve crossword by matching words and ranking them
  Future<List<String>> solveCrossword(String clue, String pattern) async {
    await loadWords(); // Ensure words are loaded
    List<String> matches = findMatchingWords(pattern);
    return rankMatches(clue, matches);
  }
}
