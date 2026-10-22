import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_colors.dart';
import '../providers/quiz_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/soft_button.dart';
import '../models/question.dart'; // Untuk categories
import 'quiz_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _nameController = TextEditingController();
  String _selectedCategory = categories.first;

  void _startQuiz() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama tidak boleh kosong!')),
      );
      return;
    }

    Provider.of<QuizProvider>(context, listen: false).startQuiz(_selectedCategory);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QuizScreen(userName: name)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    final textColor = isDark ? AppColors.textLightDark : AppColors.textDark;
    final textMuted = isDark ? AppColors.textMutedDark : AppColors.textLight;
    final inputColor = isDark ? AppColors.cardDark : AppColors.cream;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen())),
        backgroundColor: isDark ? AppColors.cardDark : AppColors.cream,
        foregroundColor: AppColors.peachDark,
        icon: const Icon(Icons.history_rounded),
        label: const Text('Riwayat', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/kuis.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.menu_book_rounded, size: 100, color: AppColors.peach);
                      },
                    ),
                    const SizedBox(height: 16),
                    Text('Kuis', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textColor)),
                    const SizedBox(height: 8),
                    Text('Uji pengetahuanmu dengan seru', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: textMuted)),
                    const SizedBox(height: 36),

                    TextField(
                      controller: _nameController,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: 'Nama kamu',
                        labelStyle: TextStyle(color: textMuted),
                        filled: true,
                        fillColor: inputColor,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // PERBAIKAN: Menggunakan initialValue (Flutter 3.24+)
                    DropdownButtonFormField<String>(
                      initialValue: _selectedCategory,
                      dropdownColor: isDark ? AppColors.cardDark : Colors.white,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        labelText: 'Pilih Kategori',
                        labelStyle: TextStyle(color: textMuted),
                        filled: true,
                        fillColor: inputColor,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      ),
                      items: categories.map((cat) {
                        return DropdownMenuItem(value: cat, child: Text(cat));
                      }).toList(),
                      onChanged: (val) => setState(() => _selectedCategory = val!),
                    ),
                    const SizedBox(height: 24),

                    SoftButton(label: 'Mulai Kuis', onPressed: _startQuiz),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode, color: textColor),
                onPressed: () => themeProvider.toggleTheme(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}