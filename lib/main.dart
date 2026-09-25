import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/config/app_config.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

// import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    publishableKey: AppConfig.supabaseAnonKey,
  );
  runApp(const ProviderScope(child: TradeFlowApp()));
}

class TradeFlowApp extends ConsumerWidget {
  const TradeFlowApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'TradeFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}

// const supabaseUrl = 'https://mpbibfwwmbxjmhfwfmsz.supabase.co/rest/v1/';
// const supabaseAnonKey = 'sb_publishable_Iu3E2y5U5tZ52V-BCuQz1g_2GONnVi0';

// final supabase = Supabase.instance.client;

// void main() async {
//   // Required before any async work in main()
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Firebase using the generated config
//   // firebase_options.dart was created by FlutterFire CLI
//   // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   await Supabase.initialize(url: supabaseUrl, publishableKey: supabaseAnonKey);

//   runApp(const TradeFlowApp());
// }

// class TradeFlowApp extends StatelessWidget {
//   const TradeFlowApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'TradeFlow',
//       debugShowCheckedModeBanner: false,
//       // We add theme, router, and ProviderScope on Day 2 and Day 5
//       home: Scaffold(
//         body: Center(
//           child: Text(
//             'TradeFlow is running! 🚀',
//             style: TextStyle(fontSize: 24),
//           ),
//         ),
//       ),
//     );
//   }
// }


/*

project name change
The Good News First
Because the project uses relative imports throughout (import '../../../core/...' not import 'package:tradeflow/...'), the internal Dart code does not need to change at all. The package name in pubspec.yaml affects very few things in a well-structured Flutter project.
Everything That Needs Changing
Group 1 — One Command (5 minutes)
VS Code or Android Studio find-and-replace across the whole project. Case-sensitive, whole-word match.
Find:    TradeFlow
Replace: YourNewName

Find:    tradeflow       (lowercase — for package names, bundle IDs)
Replace: yournewname

Find:    trade_flow      (snake_case — if used anywhere)
Replace: your_new_name
This catches all string literals, comments, class names, and PDF text in one pass.
Group 2 — Specific Files to Update Manually
These cannot be fixed by a simple find-replace because the values are structured:
pubspec.yaml — the most important one:
yaml
# Change this:
name: tradeflow

# To this:
name: yournewname
android/app/build.gradle — the Android app ID:
gradle
# Change this:
applicationId "com.tradeflow.app"

# To this:
applicationId "com.yourcompany.yournewname"
ios/Runner/Info.plist — the iOS bundle ID and display name:
xml
<!-- Change CFBundleName -->
<string>TradeFlow</string>   →   <string>YourNewName</string>

<!-- Change CFBundleIdentifier -->
<string>com.tradeflow.app</string>   →   <string>com.yourcompany.yournewname</string>
ios/Runner.xcodeproj — open in Xcode, change the Bundle Identifier in Signing settings. One field change.
lib/core/config/app_config.dart — update the display-facing constants:
dart
static const String razorpayBusinessName = 'YourNewName';  // was 'TradeFlow'
static const String upiMerchantName      = 'YourNewName';
Group 3 — Outside the Flutter Code
These are platform-level changes, not code:
What	Where	Time
Supabase project name	Supabase dashboard → Project Settings → General	2 min
Email templates	Supabase → Auth → Emails → Templates	10 min
Cloudflare R2 bucket names	R2 dashboard (create new buckets, update AppConfig URLs)	20 min
Razorpay business name	Razorpay dashboard → Settings	5 min
UPI merchant name	Your payment provider dashboard	5 min
Play Store listing	Google Play Console	10 min
App Store listing	App Store Connect	10 min
The R2 bucket names are the most fiddly — you cannot rename existing buckets, so you create new ones with the new name and update the three URL constants in AppConfig. Old uploaded files stay in the old bucket. New uploads go to the new bucket. If you want to migrate existing files, that is extra work.
The One Thing That Is Slightly Painful
If you have already published to the Play Store or App Store under com.tradeflow.app, changing the applicationId / Bundle ID means it is treated as a completely new app by both stores. Existing installs will not update automatically — users would need to reinstall. This is only relevant if you are already live.
If you have not yet published, change the IDs now and it costs nothing.
Recommended Approach
Do it in this order:
1. Find and replace all text occurrences (VS Code, 5 min)
2. Update pubspec.yaml name field
3. Update android/app/build.gradle applicationId
4. Update ios/Runner/Info.plist bundle ID and display name
5. Update AppConfig constants (razorpay, upi names)
6. Update Supabase email templates
7. Create new R2 buckets with new names, update AppConfig URLs
8. flutter clean && dart run build_runner build --delete-conflicting-outputs
9. flutter run — confirm the app launches with new name
Total time: 2 hours if you have not published yet. 3 to 4 hours if you need to handle R2 bucket migration for existing uploaded files.
The short answer: do it now before you have real users and real uploaded files. After launch it becomes progressively harder, but still manageable.
*/


// git add .
// git commit -m "Rename project to YourNewName"
// git push

//to open supabase send reminder email index.ts
//open supabase/functions/send-reminder-email