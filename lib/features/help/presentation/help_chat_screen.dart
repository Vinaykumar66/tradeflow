import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/faq_matcher.dart';
import '../../../shared/models/faq_entry.dart';

class _ChatBubble {
  final String text;
  final bool isUser;
  const _ChatBubble(this.text, this.isUser);
}

class HelpChatScreen extends StatefulWidget {
  const HelpChatScreen({super.key});

  @override
  State<HelpChatScreen> createState() => _HelpChatScreenState();
}

class _HelpChatScreenState extends State<HelpChatScreen> {
  final _inputCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final List<_ChatBubble> _messages = [
    const _ChatBubble(
        'Hi! Ask me how to do something in TradeFlow — '
        'like "how do I create an invoice".',
        false),
  ];

  @override
  void dispose() {
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _send() {
    final text = _inputCtrl.text.trim();
    if (text.isEmpty) return;
    _inputCtrl.clear();
    final match = FaqMatcher.findBestMatch(text, kFaqSeedData);
    setState(() {
      _messages.add(_ChatBubble(text, true));
      _messages.add(_ChatBubble(
          match?.answer ??
              'I don\'t have an answer for that yet. Try asking about '
                  'invoices, products, tax, printing, or payments.',
          false));
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help')),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
                controller: _scrollCtrl,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (_, i) {
                  final m = _messages[i];
                  return Align(
                      alignment: m.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.sizeOf(context).width * 0.75),
                          decoration: BoxDecoration(
                              color: m.isUser
                                  ? AppColors.primary
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(14)),
                          child: Text(m.text,
                              style: TextStyle(
                                  color: m.isUser
                                      ? Colors.white
                                      : Colors.black87))));
                })),
        SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(children: [
                  Expanded(
                      child: TextField(
                          controller: _inputCtrl,
                          decoration: InputDecoration(
                              hintText: 'Ask a question...',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24))),
                          onSubmitted: (_) => _send())),
                  const SizedBox(width: 8),
                  IconButton.filled(
                      icon: const Icon(Icons.send), onPressed: _send),
                ]))),
      ]),
    );
  }
}
