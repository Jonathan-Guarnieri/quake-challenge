# Quake Log Parser: Enter the Arena 🔫
Welcome to a brutal battleground where game logs unveil tales of conquest, prowess, and carnage. This parser dives deep into the recesses of Quake game logs, shedding light on the heroes of the arena and the tales of their combat.

## 🎯 The Original Challenge
The project was birthed from a technical challenge designed to parse the Quake 3 Arena game log. Here's a breakdown:

### Requirements:
- Git
- A development environment
- Quake game log

### Objectives:
- Log Parsing: Create a system to process the Quake log file, providing insights like:
  - Reading the log file.
  - Grouping game data for each match.
  - Collecting kill data.
- Reporting: Draft scripts to showcase reports based on:
  - Grouped information for each match.
  - Player rankings.
- Advanced Reporting:
  - Offer insights on deaths categorized by the cause for each match.

## 💼 Installation & Execution
### Pre-requirements:
- Docker
- Docker Compose
### Instructions:
Forge the Containers:
```
docker-compose build
```
Dive into the Arena:
```
docker-compose run cli
```
Test your Valor:
```
docker-compose run rspec
```

## 🗒️ Notes from the Field
1. Only the warriors who've tasted battle (either killed or were killed) make it to the records.
1. On line 97 of the file-qgames-log, a game's record is cut short, missing its final reckoning ("ShutdownGame" message). This match is hence discarded from our tales.

## ⚙️ Project Configuration
To ensure the application runs like a well-oiled machine, no .env file was used. It's all plug and play!

## 🛠️ Enhancements on the Horizon
Isolation of Presenters: A clear distinction between data and its presentation is necessary. Future iterations aim to separate the two for cleaner, more maintainable code.

Fortify with More Tests: Every arena has its champions. With more rigorous testing, we can ensure the application's robustness.

Unicode and ASCII Overhaul: Emojis were fun additions, but for maximum compatibility, future versions will solely rely on ASCII/UTF8.

Migration Versioning: Introducing a version manager to handle database migrations efficiently.

## 📜 Acknowledgments
This project served as more than just a code repository; it became a battleground where I could showcase my abilities and tackle challenges head-on. While some might notice aspects of over-engineering, they're intentional demonstrations of capabilities and not necessarily real-world best practices.

***Thank you for stepping into the arena. Prepare for combat! 🪓🔥***
