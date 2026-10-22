class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String category;
  final String imagePath;
  final String explanation;

  const Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    required this.category,
    required this.imagePath,
    required this.explanation,
  });
}

const List<String> categories = ['Umum', 'Teknologi', 'Indonesia'];

const List<Question> allQuestions = [
  Question(
    questionText: 'Ibu kota Provinsi Sumatera Utara adalah?',
    options: ['Jakarta', 'Bandung', 'Medan', 'Surabaya'],
    correctAnswerIndex: 2,
    category: 'Umum',
    imagePath: 'assets/images/medan.jpg',
    explanation: 'Medan adalah ibu kota Provinsi Sumatera Utara, Indonesia.',
  ),
  Question(
    questionText: 'Hewan mamalia terbesar di dunia adalah?',
    options: ['Gajah', 'Paus Biru', 'Jerapah', 'Badak'],
    correctAnswerIndex: 1,
    category: 'Umum',
    imagePath: 'assets/images/hewan.jpg',
    explanation: 'Paus Biru (Blue Whale) adalah hewan terbesar yang pernah hidup di bumi, bahkan lebih besar dari dinosaurus.',
  ),
  Question(
    questionText: 'Planet terdekat dengan Matahari adalah?',
    options: ['Bumi', 'Venus', 'Merkurius', 'Mars'],
    correctAnswerIndex: 2,
    category: 'Umum',
    imagePath: 'assets/images/planet.jpg',
    explanation: 'Merkurius adalah planet terdekat dengan Matahari, berjarak sekitar 58 juta kilometer.',
  ),
  Question(
    questionText: 'Siapa penemu lampu pijar?',
    options: ['Thomas Alva Edison', 'Nikola Tesla', 'Albert Einstein', 'Alexander Graham Bell'],
    correctAnswerIndex: 0,
    category: 'Umum',
    imagePath: 'assets/images/lampu.jpg',
    explanation: 'Thomas Alva Edison adalah penemu lampu pijar komersial pertama yang sukses secara praktis.',
  ),
  Question(
    questionText: 'Berapa jumlah pemain inti dalam satu tim sepak bola?',
    options: ['9', '10', '11', '12'],
    correctAnswerIndex: 2,
    category: 'Umum',
    imagePath: 'assets/images/sepakbola.jpg',
    explanation: 'Satu tim sepak bola terdiri dari 11 pemain inti, termasuk 1 penjaga gawang.',
  ),
  Question(
    questionText: 'Bahasa pemrograman utama Flutter adalah?',
    options: ['Kotlin', 'Swift', 'Dart', 'Java'],
    correctAnswerIndex: 2,
    category: 'Teknologi',
    imagePath: 'assets/images/dart.jpg',
    explanation: 'Flutter dikembangkan oleh Google dan menggunakan bahasa pemrograman Dart.',
  ),
  Question(
    questionText: 'Siapa pencipta logo Android?',
    options: ['Irina Blok', 'Steve Jobs', 'Mark Zuckerberg', 'Bill Gates'],
    correctAnswerIndex: 0,
    category: 'Teknologi',
    imagePath: 'assets/images/android.jpg',
    explanation: 'Logo robot hijau Android dirancang oleh Irina Blok saat bekerja di Google.',
  ),
  Question(
    questionText: 'Tahun berapa Flutter pertama kali dirilis?',
    options: ['2015', '2017', '2019', '2021'],
    correctAnswerIndex: 1,
    category: 'Teknologi',
    imagePath: 'assets/images/flutter.jpg',
    explanation: 'Flutter pertama kali diperkenalkan pada tahun 2015 dan merilis versi stabil pertamanya pada 2017.',
  ),
  Question(
    questionText: 'Singkatan dari HTML adalah?',
    options: ['HyperText Markup Language', 'HyperText Machine Language', 'HighText Markup Language', 'HyperTool Multi Language'],
    correctAnswerIndex: 0,
    category: 'Teknologi',
    imagePath: 'assets/images/html.jpg',
    explanation: 'HTML singkatan dari HyperText Markup Language, bahasa standar untuk membuat halaman web.',
  ),
  Question(
    questionText: 'Perusahaan apa yang mengembangkan sistem operasi Windows?',
    options: ['Apple', 'Google', 'Microsoft', 'Linux'],
    correctAnswerIndex: 2,
    category: 'Teknologi',
    imagePath: 'assets/images/windows.jpg',
    explanation: 'Microsoft adalah perusahaan yang mengembangkan dan merilis sistem operasi Windows.',
  ),
  Question(
    questionText: 'Tari Kecak berasal dari provinsi?',
    options: ['Jawa Barat', 'Bali', 'Sumatera Barat', 'Aceh'],
    correctAnswerIndex: 1,
    category: 'Indonesia',
    imagePath: 'assets/images/kecak.jpg',
    explanation: 'Tari Kecak adalah tarian khas Bali yang biasanya dipentaskan oleh puluhan penari pria.',
  ),
  Question(
    questionText: 'Candi Borobudur terletak di provinsi?',
    options: ['Jawa Timur', 'Jawa Tengah', 'Jawa Barat', 'Yogyakarta'],
    correctAnswerIndex: 1,
    category: 'Indonesia',
    imagePath: 'assets/images/borobudur.jpg',
    explanation: 'Candi Borobudur terletak di Magelang, Jawa Tengah, dan merupakan candi Buddha terbesar di dunia.',
  ),
  Question(
    questionText: 'Binatang langka yang menjadi ikon Provinsi Nusa Tenggara Timur adalah?',
    options: ['Komodo', 'Badak Bercula Satu', 'Orangutan', 'Anoa'],
    correctAnswerIndex: 0,
    category: 'Indonesia',
    imagePath: 'assets/images/komodo.jpg',
    explanation: 'Komodo adalah spesies kadal terbesar di dunia yang hanya ditemukan di Indonesia, khususnya NTT.',
  ),
  Question(
    questionText: 'Lagu "Ampar-Ampar Pisang" berasal dari daerah?',
    options: ['Kalimantan Selatan', 'Maluku', 'Papua', 'Sulawesi Utara'],
    correctAnswerIndex: 0,
    category: 'Indonesia',
    imagePath: 'assets/images/musik.jpg',
    explanation: 'Ampar-Ampar Pisang adalah lagu daerah yang berasal dari Kalimantan Selatan.',
  ),
  Question(
    questionText: 'Selat yang memisahkan Pulau Jawa dan Pulau Sumatera adalah?',
    options: ['Selat Malaka', 'Selat Sunda', 'Selat Bali', 'Selat Makassar'],
    correctAnswerIndex: 1,
    category: 'Indonesia',
    imagePath: 'assets/images/selat.jpg',
    explanation: 'Selat Sunda adalah selat yang terletak di antara Pulau Jawa dan Pulau Sumatera.',
  ),
];