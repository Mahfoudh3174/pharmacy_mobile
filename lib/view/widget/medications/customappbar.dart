import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final void Function()? onPressedSearch;
  final void Function()? onPressedIcon;
  final TextEditingController? searchController;
  final IconData? icon;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onPressedIcon,
    required this.onPressedSearch,
    this.searchController,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          // Search Input
          Expanded(
            child: TextFormField(
              controller: searchController,
              onChanged: (value) => onPressedSearch?.call(),
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: onPressedSearch,
                  icon: const Icon(Icons.search_outlined),
                ),
                hintText: title,
                hintStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Right-side icon
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            width: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: IconButton(
              onPressed: onPressedIcon,
              icon: Icon(
                icon ?? Icons.notifications_active_outlined, // default fallback
                size: 30,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class CustomMedicationBar extends StatelessWidget {
  final String title;
  final void Function()? onPressedSearch;
  final void Function()? onPressedIcon;
  final TextEditingController? searchController;


  const CustomMedicationBar({
    super.key,
    required this.title,
    required this.onPressedIcon,
    required this.onPressedSearch,
    this.searchController,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          // Search Input
          Expanded(
            child: TextFormField(
              controller: searchController,
              onChanged: (value) => onPressedSearch?.call(),
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: onPressedSearch,
                  icon: const Icon(Icons.search_outlined),
                ),
                hintText: title,
                hintStyle: const TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Right-side icon
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            width: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: IconButton(
              onPressed: onPressedIcon,
              icon: Icon(
                Icons.shopping_cart, 
                size: 30,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
