import 'package:Movie_App/settings/const.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final Function(int) onTap; 

  CustomBottomNavBar(
      {super.key,
      required this.onTap}); 

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.search_outlined,
    Icons.bookmark_border,
    Icons.download_outlined,
    Icons.account_circle_outlined,
  ];

  final List<IconData> _filledIcons = [
    Icons.home,
    Icons.search,
    Icons.bookmark,
    Icons.download,
    Icons.account_circle,
  ];

  final List<String> _labels = [
    "Home",
    "Search",
    "Saved",
    "Download",
    "Me",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: List.generate(
        _icons.length,
        (index) => BottomNavigationBarItem(
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              if (_selectedIndex == index)
                Container(
                  height: 6,
                  width: 24,
                  decoration:  const BoxDecoration(
                    color:Settings.binkthemecolor ,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                ),
              // Icon
              Icon(
                _selectedIndex == index ? _filledIcons[index] : _icons[index],
                size:
                    22, // Adjust the icon size for both selected and unselected icons
                color: _selectedIndex == index
                    ? const Color.fromARGB(255, 238, 238, 238)
                    : Colors.grey,
              ),
            ],
          ),
          label: _labels[index],
        ),
      ),
      currentIndex: _selectedIndex,
      onTap: _onItemTapped, 
      backgroundColor:Settings.Navigationbarcolor,
      selectedItemColor: const Color.fromARGB(255, 238, 238, 238),
      unselectedItemColor: Colors.white60,
      type: BottomNavigationBarType.fixed,
    );
  }
}
