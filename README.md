# 🧩 Crossword Solver App - WordWeavers

An AI-powered **Crossword Solver** mobile app that helps users solve crossword puzzles in real-time using **pattern matching** and **machine learning (TF-IDF) based word ranking**.  
Developed for **Smart Bengal Hackathon (SBH-Sr) 2025**.

## ✨ Features

- 🧠 **AI-powered word matching** using ML and NLP techniques
- ⚡ **Real-time search and ranking** of potential word solutions
- 📱 **User-friendly mobile app** built with Flutter
- 🚀 **Offline support** — works without internet once dataset is loaded
- 🌐 **Open-source** and easy to expand with more advanced NLP models

---

## 🎯 Objective

To build an **AI-powered crossword solver** that:
- Takes user-provided *clues* and *word patterns*
- Filters possible words using **regex-based pattern matching**
- Ranks and suggests words based on **TF-IDF similarity** to the clue
- Provides a fast and lightweight **mobile UI** for solving puzzles anywhere

---

## 🏆 Target Audience & Benefits

- **Crossword puzzle enthusiasts**
- **Language learners and educators**
- **Students & researchers** in NLP and computational linguistics
- **Content creators** generating word-based puzzles and games

### Societal Impact
- Improves **literacy, vocabulary, and language learning**
- Supports **linguistic research**
- Encourages **cognitive skill development** through word puzzles

---

## 🏗️ System Architecture

```plaintext
User Input (Clue + Pattern)
        ↓
Pattern Matcher (Regex Filtering)
        ↓
ML-based Ranker (TF-IDF Scoring)
        ↓
Result Display (Flutter UI)
