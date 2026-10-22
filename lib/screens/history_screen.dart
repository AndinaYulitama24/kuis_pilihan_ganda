import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';
import '../providers/history_provider.dart';
import '../models/history_model.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  // Dialog Konfirmasi Hapus
  void _confirmDelete(BuildContext context, HistoryProvider provider, {int? index}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text(index != null
            ? 'Apakah kamu yakin ingin menghapus riwayat ini?'
            : 'Apakah kamu yakin ingin menghapus SEMUA riwayat kuis?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              if (index != null) {
                provider.deleteHistory(index);
              } else {
                provider.clearHistory();
              }
              Navigator.pop(context);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showDetail(BuildContext context, HistoryModel item, bool isDark, Color textColor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.bgDark : AppColors.bg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Detail Kesalahan', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
                      IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                    ],
                  ),
                  const Divider(),
                  item.wrongQuestions.isEmpty
                      ? Center(child: Padding(padding: const EdgeInsets.all(32), child: Text('Sempurna! Tidak ada jawaban yang salah.', style: TextStyle(color: textColor))))
                      : Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: item.wrongQuestions.length,
                      itemBuilder: (context, index) {
                        final q = item.wrongQuestions[index];
                        return Card(
                          color: isDark ? AppColors.cardDark : AppColors.cream,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Soal ${index + 1}: ${q.questionText}', style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
                                const SizedBox(height: 8),
                                Text('Jawaban Benar: ${q.options[q.correctAnswerIndex]}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Text('Penjelasan: ${q.explanation}', style: TextStyle(fontSize: 13, color: textColor, height: 1.4)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textLightDark : AppColors.textDark;
    final textMuted = isDark ? AppColors.textMutedDark : AppColors.textLight;

    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Kuis', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        actions: [
          // TOMBOL HAPUS SEMUA (Hanya muncul jika ada riwayat)
          if (historyProvider.history.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep, color: Colors.red),
              tooltip: 'Hapus Semua',
              onPressed: () => _confirmDelete(context, historyProvider),
            ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: historyProvider.history.isEmpty
              ? Center(child: Text('Belum ada riwayat kuis.', style: TextStyle(color: textColor)))
              : ListView.builder(
            itemCount: historyProvider.history.length,
            itemBuilder: (context, index) {
              final item = historyProvider.history[index];
              int score100 = (item.score / item.totalQuestions * 100).round();

              return Card(
                color: isDark ? AppColors.cardDark : AppColors.cream,
                margin: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _showDetail(context, item, isDark, textColor),
                  child: ListTile(
                    leading: const Icon(Icons.emoji_events, color: AppColors.peachDark),
                    title: Text('Kuis ${item.category}', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
                    subtitle: Text(DateFormat('dd MMM yyyy, HH:mm').format(item.date), style: TextStyle(color: textMuted)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Nilai: $score100', style: const TextStyle(color: AppColors.peachDark, fontWeight: FontWeight.bold, fontSize: 16)),
                            if (item.wrongQuestions.isNotEmpty)
                              Text('${item.wrongQuestions.length} Salah', style: const TextStyle(color: Colors.red, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(width: 8),
                        // TOMBOL HAPUS PER ITEM
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                          onPressed: () => _confirmDelete(context, historyProvider, index: index),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}