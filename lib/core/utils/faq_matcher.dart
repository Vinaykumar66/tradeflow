import '../../shared/models/faq_entry.dart';

class FaqMatcher {
  static const _stopWords = {
    'how',
    'do',
    'i',
    'the',
    'a',
    'an',
    'is',
    'to',
    'for',
    'of',
    'what',
    'can',
    'my',
    'in',
    'on',
    'and',
    'does',
    'it',
    'be',
  };
  static Set<String> _words(String text) => text
      .toLowerCase()
      .split(RegExp(r'[^\w]+'))
      .where((w) => w.isNotEmpty && !_stopWords.contains(w))
      .toSet();

  static FaqEntry? findBestMatch(String query, List<FaqEntry> entries) {
    final queryWords = _words(query);
    if (queryWords.isEmpty) return null;
    FaqEntry? best;
    var bestScore = 0;
    for (final entry in entries) {
      final entryWords = {
        ..._words(entry.question),
        ...entry.keywords.map((k) => k.toLowerCase()),
      };
      final score = queryWords.intersection(entryWords).length;
      if (score > bestScore) {
        bestScore = score;
        best = entry;
      }
    }
    return best;
  }

  static List<FaqEntry> suggestedQuestions(List<FaqEntry> entries) =>
      entries.take(3).toList();
}
