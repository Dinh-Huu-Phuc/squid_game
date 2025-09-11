enum Difficulty {
  easy,
  normal,
  hard,
  expert,
}

extension DifficultyExtension on Difficulty {
  String get name {
    switch (this) {
      case Difficulty.easy:
        return 'easy';
      case Difficulty.normal:
        return 'normal';
      case Difficulty.hard:
        return 'hard';
      case Difficulty.expert:
        return 'expert';
    }
  }

  String get label {
    switch (this) {
      case Difficulty.easy:
        return 'Dễ';
      case Difficulty.normal:
        return 'Bình thường';
      case Difficulty.hard:
        return 'Khó';
      case Difficulty.expert:
        return 'Chuyên gia';
    }
  }
}
