import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() => runApp(SwipeGalleryApp());

class SwipeGalleryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swipe Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/gallery': (context) => SwipeGalleryScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/gallery');
          },
          child: Text('Swipe Gallery'),
        ),
      ),
    );
  }
}

class SwipeGalleryScreen extends StatefulWidget {
  @override
  _SwipeGalleryScreenState createState() => _SwipeGalleryScreenState();
}

class _SwipeGalleryScreenState extends State<SwipeGalleryScreen> {
  final CarouselController _controller = CarouselController();
  final List<String> imagePaths = [
    'assets/images/background.jpg',
    'assets/images/goal.jpg',
    'assets/images/intro.jpg',
    'assets/images/personality.jpg',
    'assets/images/profile.jpeg',
  ];

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe Gallery'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 54, 219, 244),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              height: 400.0,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: imagePaths.map((path) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                    child: Image.asset(
                      path,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => _controller.previousPage(),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () => _controller.nextPage(),
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false, // Removes all the previous routes
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
