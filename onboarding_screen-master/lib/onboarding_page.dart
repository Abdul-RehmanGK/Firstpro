import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;
  final PageController _controller = PageController();

  final List<Map<String, dynamic>> _pages = [
    {
      "title": "Welcome to App",
      "description": "Discover new features and enjoy the experience.",
      "image": "assets/onboarding1.png",
      "bgColor": Colors.blue,
      "textColor": Colors.white,
    },
    {
      "title": "Stay Connected",
      "description": "Get notifications and stay up-to-date with us.",
      "image": "assets/onboarding2.png",
      "bgColor": Colors.green,
      "textColor": Colors.white,
    },
    {
      "title": "Get Started",
      "description": "Enjoy seamless functionality at your fingertips.",
      "image": "assets/onboarding3.png",
      "bgColor": Colors.orange,
      "textColor": Colors.white,
    },
  ];

  void _goToNextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: _pages[_currentPage]['bgColor'],
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (index) => setState(() {
                    _currentPage = index;
                  }),
                  itemBuilder: (_, index) {
                    final page = _pages[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(page['image'], height: 300),
                        Text(
                          page['title'],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: page['textColor'],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            page['description'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: page['textColor'],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: _currentPage == index ? 20 : 8,
                    height: 8,
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Handle Skip
                      },
                      child: const Text("Skip", style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_currentPage == _pages.length - 1) {
                          // Handle Finish
                        } else {
                          _goToNextPage();
                        }
                      },
                      child: Text(
                        _currentPage == _pages.length - 1 ? "Finish" : "Next",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: OnboardingPage(),
  ));
}