/*
import 'package:civic_connect/createaccount.dart';
import 'package:civic_connect/homepage.dart';
import 'package:civic_connect/myreport.dart';
import 'package:civic_connect/reportissue.dart';
import 'package:civic_connect/issuepage.dart'; // Add this import
import 'package:civic_connect/signin.dart';
import 'package:civic_connect/startpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CivicConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      initialRoute: '/start',
      routes: {
        '/start': (context) => const StartPage(),
        '/create-account': (context) => const CreateAccountPage(),
        '/signin': (context) => const SignInPage(),
        '/home': (context) => const HomePage(),
        '/report-issue': (context) => const ReportIssuePage(), // Dashboard/Overview page
        '/issue-form': (context) => const IssueFormPage(), // Actual form page from issuepage.dart
        '/my-reports': (context) => const MyReportsPage(),
      },
    );
  }
}*/
/*
import 'package:civic_connect/createaccount.dart';
import 'package:civic_connect/homepage.dart';
import 'package:civic_connect/myreport.dart';
import 'package:civic_connect/reportissue.dart';
import 'package:civic_connect/issuepage.dart';
import 'package:civic_connect/community.dart'; // Add community import
import 'package:civic_connect/signin.dart';
import 'package:civic_connect/startpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CivicConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      initialRoute: '/start',
      routes: {
        '/start': (context) => const StartPage(),
        '/create-account': (context) => const CreateAccountPage(),
        '/signin': (context) => const SignInPage(),
        '/home': (context) => const HomePage(),
        '/report-issue': (context) => const ReportIssuePage(), // Dashboard/Overview page
        '/issue-form': (context) => const IssueFormPage(), // Actual form page from issuepage.dart
        '/community': (context) => const CommunityPage(), // Community page
        '/my-reports': (context) => const MyReportsPage(),
      },
    );
  }
}*/
/*
import 'package:civic_connect/createaccount.dart';
import 'package:civic_connect/homepage.dart';
import 'package:civic_connect/myreport.dart';
import 'package:civic_connect/reportissue.dart';
import 'package:civic_connect/issuepage.dart';
import 'package:civic_connect/community.dart';
import 'package:civic_connect/member.dart'; // Add member import
import 'package:civic_connect/signin.dart';
import 'package:civic_connect/startpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CivicConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      initialRoute: '/start',
      routes: {
        '/start': (context) => const StartPage(),
        '/create-account': (context) => const CreateAccountPage(),
        '/signin': (context) => const SignInPage(),
        '/home': (context) => const HomePage(),
        '/report-issue': (context) => const ReportIssuePage(), // Dashboard/Overview page
        '/issue-form': (context) => const IssueFormPage(), // Actual form page from issuepage.dart
        '/community': (context) => const CommunityPage(), // Community page
        '/member': (context) => const MemberPage(), // Member/Profile page
        '/my-reports': (context) => const MyReportsPage(),
      },
    );
  }
}*/
/*
import 'package:civic_connect/createaccount.dart';
import 'package:civic_connect/homepage.dart';
import 'package:civic_connect/myreport.dart';
import 'package:civic_connect/reportissue.dart' as report_dashboard; // Add alias
import 'package:civic_connect/issuepage.dart'; // This contains ReportIssuePage (the form)
import 'package:civic_connect/community.dart';
import 'package:civic_connect/member.dart';
import 'package:civic_connect/notification.dart';
import 'package:civic_connect/signin.dart';
import 'package:civic_connect/startpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CivicConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      initialRoute: '/start',
      routes: {
        '/start': (context) => const StartPage(),
        '/create-account': (context) => const CreateAccountPage(),
        '/signin': (context) => const SignInPage(),
        '/home': (context) => const HomePage(),
        '/report-issue': (context) => const report_dashboard.ReportIssuePage(), // Dashboard from reportissue.dart
        '/issue-form': (context) => const ReportIssuePage(), // Form from issuepage.dart
        '/community': (context) => const CommunityPage(),
        '/member': (context) => const MemberPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/my-reports': (context) => const MyReportsPage(),
      },
    );
  }
}*/
/*
import 'package:civic_connect/createaccount.dart';
import 'package:civic_connect/homepage.dart';
import 'package:civic_connect/myreport.dart';
import 'package:civic_connect/reportissue.dart' as report_dashboard; // Add alias
import 'package:civic_connect/issuepage.dart'; // This contains ReportIssuePage (the form)
import 'package:civic_connect/community.dart';
import 'package:civic_connect/member.dart';
import 'package:civic_connect/notification.dart';
import 'package:civic_connect/signin.dart';
import 'package:civic_connect/startpage.dart';
import 'package:flutter/material.dart';

// NEW: add these
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load env file
  await dotenv.load(fileName: ".env");

  // initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CivicConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      initialRoute: '/start',
      routes: {
        '/start': (context) => const StartPage(),
        '/create-account': (context) => const CreateAccountPage(),
        '/signin': (context) => const SignInPage(),
        '/home': (context) => const HomePage(),
        '/report-issue': (context) =>
        const report_dashboard.ReportIssuePage(), // Dashboard
        '/issue-form': (context) => const ReportIssuePage(), // Form
        '/community': (context) => const CommunityPage(),
        '/member': (context) => const MemberPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/my-reports': (context) => const MyReportsPage(),
      },
    );
  }
}
*/
/*
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // load env file
    await dotenv.load(fileName: ".env");
    print("✅ ENV loaded: ${dotenv.env['SUPABASE_URL']}");

    // initialize Supabase
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
    print("✅ Supabase initialized");
  } catch (e) {
    // catch errors so app still runs
    print("❌ Error loading .env or initializing Supabase: $e");
  }

  runApp(const MyApp());
}
*/
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:civic_connect/createaccount.dart';
import 'package:civic_connect/homepage.dart';
import 'package:civic_connect/myreport.dart';
import 'package:civic_connect/reportissue.dart' as report_dashboard;
import 'package:civic_connect/issuepage.dart';
import 'package:civic_connect/community.dart';
import 'package:civic_connect/member.dart';
import 'package:civic_connect/notification.dart';
import 'package:civic_connect/signin.dart';
import 'package:civic_connect/startpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
    print("✅ ENV loaded: ${dotenv.env['SUPABASE_URL']}");

    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
    print("✅ Supabase initialized");
  } catch (e) {
    print("❌ Error loading .env or initializing Supabase: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CivicConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      initialRoute: '/start',
      routes: {
        '/start': (context) => const StartPage(),
        '/create-account': (context) => const CreateAccountPage(),
        '/signin': (context) => const SignInPage(),
        '/home': (context) => const HomePage(),
        '/report-issue': (context) => const report_dashboard.ReportIssuePage(),
        '/issue-form': (context) => const ReportIssuePage(),
        '/community': (context) => const CommunityPage(),
        '/member': (context) => const MemberPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/my-reports': (context) => const MyReportsPage(),
      },
    );
  }
}
