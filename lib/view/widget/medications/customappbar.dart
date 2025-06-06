import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final void Function()? onPressedSearch;
  final void Function()? onPressedIcon;
  final TextEditingController? searchController;
  const CustomAppBar({
    super.key, 
    required this.title,
    required this.onPressedIcon, 
    required this.onPressedSearch,
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Expanded(          child: TextFormField(
              controller: searchController,
              onChanged: (value) => onPressedSearch?.call(),
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: onPressedSearch, 
                  icon: Icon(Icons.search_outlined)
                ),
                hintText: title,
                hintStyle: TextStyle(fontSize: 18),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            width: 60,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: IconButton(
              onPressed: onPressedIcon,
              icon: Icon(
                Icons.notifications_active_outlined,
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
