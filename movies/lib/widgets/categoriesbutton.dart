import 'package:Movie_App/settings/const.dart';
import 'package:flutter/material.dart';

class CategoriesButton extends StatefulWidget {
  final List<String> categories;
  final Function(int) onCategorySelected;

  const CategoriesButton({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  State<CategoriesButton> createState() => _CategoriesButtonState();
}

class _CategoriesButtonState extends State<CategoriesButton> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Categories",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenHeight / 35,
            ),
          ),
        ),
        SizedBox(
          height: 25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              final isSelected = index == _selectedIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                    widget.onCategorySelected(index);
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(horizontal: 6.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Settings.binkthemecolor
                        : const Color.fromARGB(255, 49, 42, 126),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.categories[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
