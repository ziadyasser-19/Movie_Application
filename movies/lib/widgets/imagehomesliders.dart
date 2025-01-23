// ignore_for_file: must_be_immutable, camel_case_types

import 'package:Movie_App/settings/const.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final List<String> images; // List of image URLs

  const ImageSlider({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.images,
  });

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.screenHeight / 3 + 30,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                widget.images[index], // Use the URL from the list
                fit: BoxFit.fill,
                width: widget.screenWidth,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  height: 8.0,
                  width: _currentPage == index ? 20 : 7.0,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Settings.binkthemecolor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}