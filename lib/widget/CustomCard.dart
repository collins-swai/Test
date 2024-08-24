import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onDelete;

  const CustomCard({
    Key? key,
    required this.title,
    required this.description,
    required this.onDelete
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Building CustomCard with title: $title and description: $description");
    return Container(
      width: 328.0,
      height: 120.0,
      padding: const EdgeInsets.only(top: 16.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: const Color(0xFFEFF0F6),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Light shadow
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity, // Full width of the card
            height: 24.0, // Fixed height
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title.isNotEmpty ? title : 'No Title', // Handle empty title
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
          // Description text
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Text(
                description.isNotEmpty ? description : 'No Description', // Handle empty description
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9E9E9E), // Color with opacity
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
