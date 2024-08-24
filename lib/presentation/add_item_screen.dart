import 'package:flutter/material.dart';
import 'package:testapp/theme/color_constant.dart';
import 'package:testapp/widget/DataEntryCard.dart';

class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({Key? key}) : super(key: key);

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  void _handleAddItem(String title, String description) {
    Navigator.pop(context, {
      'title': title,
      'description': description,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: ColorConstant.whiteA700,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 24, // Icon size
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Row(
            children: const [
              SizedBox(width: 4),
              Text(
                'Add Item',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DataEntryCard(onAddItem: _handleAddItem),
      ),
    );
  }
}
