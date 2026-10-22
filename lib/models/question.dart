class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  const Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

const List<Question> dummyQuestions = [
  Question(
    questionText: 'Ibu kota Provinsi Sumatera Utara adalah?',
    options: ['Jakarta', 'Bandung', 'Medan', 'Surabaya'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Bahasa pemrograman utama Flutter adalah?',
    options: ['Kotlin', 'Swift', 'Dart', 'Java'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Siapa pencipta logo Android?',
    options: ['Irina Blok', 'Steve Jobs', 'Mark Zuckerberg', 'Bill Gates'],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Manakah yang BUKAN termasuk sistem operasi mobile?',
    options: ['iOS', 'Android', 'Windows', 'Linux'],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'Tahun berapa Flutter pertama kali dirilis?',
    options: ['2015', '2017', '2019', '2021'],
    correctAnswerIndex: 1,
  ),
];