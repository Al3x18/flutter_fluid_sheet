import 'package:flutter/material.dart';

/// Example content widget for FluidSheet demo
/// Shows images and lorem ipsum text to demonstrate scrolling behavior
class ExampleContent extends StatelessWidget {
  const ExampleContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Lorem Ipsum Dolor',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ),
          Image.network(
            'https://picsum.photos/seed/1/600/400',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
            },
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(height: 200, child: Center(child: Icon(Icons.error, size: 48)));
            },
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
              style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
            ),
          ),
          const SizedBox(height: 16),
          Image.network(
            'https://picsum.photos/seed/2/600/400',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()));
            },
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox(height: 200, child: Center(child: Icon(Icons.error, size: 48)));
            },
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
