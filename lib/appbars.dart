import 'package:flutter/material.dart';

Color normalcolor = Colors.white24;
Color selectedcolor = Colors.white;

AppBar topbar = AppBar(
  backgroundColor: Colors.black,
  title: Image.asset(
    'assests/yt_logo_rgb_dark.png',  // Correct path for assets
    fit: BoxFit.cover,
    width: 100.0,
  ),
  actions: <Widget>[
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: Icon(
        Icons.videocam,
      ),
    ),
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: Icon(
        Icons.search,
      ),
    ),
    Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: Icon(
        Icons.account_circle,
      ),
    ),
  ],
);

// Sliding bar widget (below topbar)
Widget slidingBar({required int selectedIndex, required Function(int) onTap}) {
  // Categories for the sliding bar
  final List<String> categories = [
    "Movies",
    "Songs",
    "History",
    "News",
    "Tourism",
    "Sports",
    "Gaming",
    "Education",
    "Fashion",
    "Technology",
  ];

  return Container(
    color: Colors.black,
    padding: EdgeInsets.symmetric(vertical: 10.0),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      child: Row(
        children: List.generate(categories.length, (index) {
          return GestureDetector(
            onTap: () => onTap(index), // Notify the tap
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: selectedIndex == index ? Colors.white : Colors.white24,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: selectedIndex == index ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }),
      ),
    ),
  );
}

// Function to generate the BottomAppBar with dynamic color changes
BottomAppBar bottomAppBar(
    {required int selectedIndex, required Function(int) onIconTap}) {
  return BottomAppBar(
    color: Colors.black,
    child: Container(
      color: Colors.black,
      height: 55.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Home Icon
          GestureDetector(
            onTap: () => onIconTap(0), // Notify the tap
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.home,
                  color: selectedIndex == 0 ? selectedcolor : normalcolor,
                ),
                Text(
                  "Home",
                  style: TextStyle(
                      color: selectedIndex == 0 ? selectedcolor : normalcolor),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => onIconTap(1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Icon(
                  Icons.whatshot,
                  color: selectedIndex == 1 ? selectedcolor : normalcolor,
                ),
                Text(
                  "Trending",
                  style: TextStyle(
                      color: selectedIndex == 1 ? selectedcolor : normalcolor),
                ),
              ],
            ),
          ),
          // Subscriptions Icon
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.subscriptions,
                color: normalcolor,
              ),
              Text(
                "Subscriptions",
                style: TextStyle(color: normalcolor),
              ),
            ],
          ),
          // Inbox Icon
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.email,
                color: normalcolor,
              ),
              Text(
                "Inbox",
                style: TextStyle(color: normalcolor),
              ),
            ],
          ),
          // Library Icon
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.folder,
                color: normalcolor,
              ),
              Text(
                "Library",
                style: TextStyle(color: normalcolor),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
