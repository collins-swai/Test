import 'dart:convert'; // For JSON encoding and decoding
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testapp/presentation/add_item_screen.dart';
import 'package:testapp/theme/color_constant.dart';
import 'package:testapp/widget/CustomCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
      _saveItems();
    });
  }

  Future<void> _navigateToAddItemScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddItemsScreen(),
      ),
    );

    if (result != null && result is Map<String, String>) {
      setState(() {
        items.add(result);
        _saveItems();
      });
    }
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = jsonEncode(items); // Convert your items list to JSON
    await prefs.setString('items_key', itemsJson);
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = prefs.getString('items_key');
    if (itemsJson != null) {
      final List<dynamic> decodedItems = jsonDecode(itemsJson);
      setState(() {
        items = decodedItems.map((item) => Map<String, String>.from(item)).toList();
      });
    }
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
                Icons.menu,
                color: Colors.black,
                size: 24, // Icon size
              ),
              onPressed: () {},
            ),
          ),
          title: Row(
            children: const [
              SizedBox(width: 4),
              Text(
                'Test App',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              child: Container(
                width: 79,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF012B55),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: ElevatedButton(
                  onPressed: _navigateToAddItemScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        "New",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final title = item['title'] ?? 'No Title';
            final description = item['description'] ?? 'No Description';
            return CustomCard(
              title: title,
              description: description,
              onDelete: () => _deleteItem(index),
            );
          },
        ),
      ),
    );
  }
}

