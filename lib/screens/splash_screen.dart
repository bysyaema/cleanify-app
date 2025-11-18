import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/service_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  double _opacity = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => _opacity = 1);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(seconds: 2),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Judul
                  Text(
                    'Cleanify App',
                    style: TextStyle(
                      color: const Color(0xFF84A9BB),
                      fontSize: width > 500 ? 48 : 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Bersih setiap sudut, nyaman setiap saat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF7A8A9F),
                      fontSize: width > 500 ? 22 : 16,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Gambar responsif
                  Image.asset(
                    'assets/images/cleaning.jpg',
                    width: width * 0.7,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 40),

                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF84A9BB),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ServicePage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Go Clean 🧼',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
