import 'package:flutter/material.dart';

void main() {
  runApp(const RestaurantMenuApp());
}

// -------------------------------------------------------------
// 1. DATA MODEL
// -------------------------------------------------------------
// Represents a single menu item with all its relevant details.
class FoodItem {
  final String name;
  final String category;
  final String price;
  final String imagePath;
  final String description;
  final List<String> ingredients;

  const FoodItem({
    required this.name,
    required this.category,
    required this.price,
    required this.imagePath,
    required this.description,
    required this.ingredients,
  });
}

// -------------------------------------------------------------
// 2. ROOT APPLICATION WIDGET
// -------------------------------------------------------------
class RestaurantMenuApp extends StatelessWidget {
  const RestaurantMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Menu',
      debugShowCheckedModeBanner: false, // Removes the red debug banner
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B4D3E),
          primary: const Color(0xFF1B4D3E),
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF6F0), // Coconut cream
      ),
      home: const RestaurantMenuScreen(),
    );
  }
}

// -------------------------------------------------------------
// 3. MAIN MENU SCREEN 
// -------------------------------------------------------------
class RestaurantMenuScreen extends StatelessWidget {
  const RestaurantMenuScreen({super.key});

  final List<FoodItem> menuItems = const [
    FoodItem(
      name: 'Nasi Lemak Viral Homemade',
      category: 'Traditional Rice Dish',
      price: 'RM 12.50',
      imagePath: 'assets/images/nasi_lemak.jpg',
      description:
          'Fragrant rice cooked in coconut milk and pandan leaf, served with spicy sambal, crispy fried anchovies, toasted peanuts, cucumber slices, and a hard-boiled egg.',
      ingredients: [
        'Fragrant Coconut Rice',
        'Special Sambal',
        'Anchovies & Peanuts',
        'Hard-Boiled Egg',
        'Cucumber'
      ],
    ),
    FoodItem(
      name: 'Satay Ayam Berapi',
      category: 'Charcoal Grilled Skewers',
      price: 'RM 15.00',
      imagePath: 'assets/images/satay.jpg',
      description:
          'Skewered and seasoned chicken thigh pieces grilled over charcoal to smoky perfection. Served with rich peanut gravy, cucumber cubes, and compressed rice cake (ketupat).',
      ingredients: [
        'Marinated Chicken Skewers',
        'Spiced Peanut Sauce',
        'Ketupat (Rice Cake)',
        'Red Onions & Cucumber'
      ],
    ),
    FoodItem(
      name: 'Beef Rendang (Daging import Australia)',
      category: 'Slow-Cooked Meat Special',
      price: 'RM 18.00',
      imagePath: 'assets/images/rendang.jpg',
      description:
          'Tender beef slowly braised in coconut milk and a rich blend of lemongrass, galangal, turmeric leaves, and toasted grated coconut (kerisik) until dark and deeply aromatic.',
      ingredients: [
        'Tender Beef Cuts',
        'Kerisik (Toasted Coconut)',
        'Thick Coconut Cream',
        'Traditional Herb Paste'
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurant Menu',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1B4D3E),
        elevation: 3,
      ),
      // ListView ensures content is scrollable and won't overflow on small screens
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return _buildMenuCard(context, item);
        },
      ),
    );
  }

  // Helper method: Builds each food Card matching the lab's visual layout
  Widget _buildMenuCard(BuildContext context, FoodItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18.0),
      child: Card(
        color: const Color(0xFFD48C29),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        clipBehavior: Clip.antiAlias, // Ensures ink ripple clips inside rounded corners
        child: InkWell(
          // Extra Task: Navigate to the detail screen on tap
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodDetailScreen(item: item),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Row(
              children: [
                // Food Image container with rounded corners
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    item.imagePath,
                    width: 90.0,
                    height: 90.0,
                    fit: BoxFit.cover,
                    // If an image fails to load, gracefully display a fallback icon
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 90.0,
                        height: 90.0,
                        color: Colors.black12,
                        child: const Icon(
                          Icons.restaurant,
                          color: Colors.white70,
                          size: 40.0,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 20.0),
                // Food Title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        item.price,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                // Forward arrow indicator hinting that the Card is interactive
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white60,
                  size: 18.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// 4. EXTRA TASK: FOOD DETAIL SCREEN
// -------------------------------------------------------------
// Opens when a user taps any Card, displaying complete information about the dish.
class FoodDetailScreen extends StatelessWidget {
  final FoodItem item;

  const FoodDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          item.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1B4D3E),
        iconTheme: const IconThemeData(color: Colors.white), // Makes back button white
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full-width Hero image display
            Image.asset(
              item.imagePath,
              width: double.infinity,
              height: 240.0,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 240.0,
                  color: Colors.black12,
                  child: const Center(
                    child: Icon(Icons.restaurant, size: 60.0, color: Colors.grey),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Price row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B4D3E),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD48C29),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          item.price,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    item.category,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Divider(height: 32.0, thickness: 1.0),
                  // Description section
                  const Text(
                    'About this Dish',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B4D3E),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    item.description,
                    style: const TextStyle(
                      fontSize: 15.0,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  // Ingredients list section
                  const Text(
                    'Key Ingredients',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B4D3E),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: item.ingredients.map((ingredient) {
                      return Chip(
                        label: Text(ingredient),
                        backgroundColor: const Color(0xFFE8EDE9),
                        labelStyle: const TextStyle(
                          color: Color(0xFF1B4D3E),
                          fontWeight: FontWeight.w500,
                        ),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}