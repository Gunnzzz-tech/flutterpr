import 'package:flutter/material.dart';
import 'package:newpr/pages/video_player_page.dart';
import 'appbars.dart';
import 'mock_data.dart';
import 'search_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'splash_screen.dart';
import 'main.dart'; // For navigation to HomePage
import 'register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Manually initializing Firebase with the FirebaseOptions
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCSjILo5NmPNoPnIZvrpVkt28lV9I3w5q4",
      appId: "1:1078848904627:android:0c3bfd5fde51c5ea8b7fc6",
      messagingSenderId: "1078848904627",
      projectId: "fire-setup-cb475",
      storageBucket: "fire-setup-cb475.appspot.com",
      authDomain: "fire-setup-cb475.firebaseapp.com",
      databaseURL: "https://fire-setup-cb475.firebaseio.com",  // if you're using Realtime Database
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Splash screen is the first screen
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),// Login page
        '/home': (context) => const HomePage(),   // Home page
      },
    );
  }
}


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assests/yt_logo_rgb_dark.png',
          fit: BoxFit.cover,
          width: 200.0,
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  int _selectedCategoryIndex = 0; // For sliding bar category selection
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    VideosPage(),
    TrendingPage(),
    LibraryPage(),
  ];

  void _onIconTap(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  void _onCategoryTap(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          'assests/yt_logo_rgb_dark.png',
          fit: BoxFit.cover,
          width: 100.0,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.white),
            onPressed: () {
              // Handle video cam press
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Navigate to SearchPage when search icon is tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
          // Account icon with Dropdown
          DropdownButton<String>(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            underline: const SizedBox(), // To remove underline from the dropdown button
            items: [
              // Dropdown item for displaying the email
              DropdownMenuItem<String>(
                value: 'email',
                child: Text('Email: ${user?.email ?? 'No email'}'),
              ),
              // Dropdown item for logout
              DropdownMenuItem<String>(
                value: 'logout',
                child: ElevatedButton(
                  onPressed: () async {
                    // Sign out the user
                    await _auth.signOut();
                    // Navigate back to the LoginPage
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text('Logout'),
                ),
              ),
            ],
            onChanged: (value) {
              // If needed, you can handle the selection here
              if (value == 'logout') {
                // Sign out the user
                _auth.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            slidingBar(
              selectedIndex: _selectedCategoryIndex,
              onTap: _onCategoryTap,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: _pages,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onIconTap,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Trending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Library',
          ),
        ],
      ),
    );
  }
}

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  Widget eachVideo(BuildContext context, String videoUrl, String title, String thumbnail) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image.network(thumbnail),
            Positioned.fill(
              bottom: 10.0,
              right: 10.0,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  color: Colors.black,
                  padding: EdgeInsets.all(4.0),
                  child: Text("20:10", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5.0),
        Container(
          color: Colors.black,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assests/logo.jpg'),
            ),
            title: Text(title),
            subtitle: Text("Uptown Girl - 2B Views - 1 Year"),
            trailing: Icon(Icons.more_vert, color: Colors.white),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoPlayerPage(videoUrl: videoUrl),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.0, child: Container(color: Colors.black)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<VideoData> videoData = VideoData.getMockData();

    return SingleChildScrollView(
      child: Column(
        children: videoData.map((video) {
          return eachVideo(context, video.videoUrl, video.title, video.thumbnail);
        }).toList(),
      ),
    );
  }
}

class TrendingPage extends StatelessWidget {
  const TrendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 18,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(
              child: Text(
                '',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          itemCount: 32,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.accents[index % Colors.accents.length],
              child: Center(
                child: Text(
                  '',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
