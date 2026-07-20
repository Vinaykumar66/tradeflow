import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'core/theme/app_theme.dart';

const supabaseUrl = 'https://mpbibfwwmbxjmhfwfmsz.supabase.co/rest/v1/';
const supabaseAnonKey = 'sb_publishable_Iu3E2y5U5tZ52V-BCuQz1g_2GONnVi0';

final supabase = Supabase.instance.client;

void main() async {
  // Required before any async work in main()
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase using the generated config
  // firebase_options.dart was created by FlutterFire CLI
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(url: supabaseUrl, publishableKey: supabaseAnonKey);

  runApp(const TradeFlowApp());
}

class TradeFlowApp extends StatelessWidget {
  const TradeFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TradeFlow',
      debugShowCheckedModeBanner: false,
      // We add theme, router, and ProviderScope on Day 2 and Day 5
      home: Scaffold(
        body: Center(
          child: Text(
            'TradeFlow is running! 🚀',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
