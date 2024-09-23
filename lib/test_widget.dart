import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// الحالة (State) الخاصة بالفئات
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategorySelected extends CategoryState {
  final String selectedCategory;

  CategorySelected(this.selectedCategory);
}

// Cubit لإدارة الحالة
class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  void selectCategory(String category) {
    emit(CategorySelected(category));
  }
}

class FastkartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Fastkart'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _onItemTapped(context, index); // التنقل بين الشاشات
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer),
              label: 'Offers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ],
          selectedItemColor: Colors.teal,
        ),
        body: Row(
          children: [
            // استخدام NavigationRail بدلاً من القائمة الجانبية
            NavigationRail(
              selectedIndex: 0,
              onDestinationSelected: (int index) {
                _onCategorySelected(context, index);
              },
              labelType: NavigationRailLabelType.all,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.local_grocery_store),
                  selectedIcon: Icon(Icons.local_grocery_store),
                  label: Text('Oils, Refined & Ghee'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.rice_bowl),
                  selectedIcon: Icon(Icons.rice_bowl),
                  label: Text('Rice, Flour & Grains'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.food_bank),
                  selectedIcon: Icon(Icons.food_bank),
                  label: Text('Food Cupboard'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.local_florist),
                  selectedIcon: Icon(Icons.local_florist),
                  label: Text('Fresh Fruits'),
                ),
              ],
            ),
            // Main content area
            Expanded(
              flex: 3,
              child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is CategorySelected) {
                    return _buildContentForCategory(state.selectedCategory);
                  }
                  return Center(child: Text('Select a category'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة لمعالجة التفاعل مع NavigationRail
  void _onCategorySelected(BuildContext context, int index) {
    final categories = [
      "Oils, Refined & Ghee",
      "Rice, Flour & Grains",
      "Food Cupboard",
      "Fresh Fruits"
    ];

    // اختيار الفئة بناءً على الفهرس (index)
    context.read<CategoryCubit>().selectCategory(categories[index]);
  }

  // بناء المحتوى الخاص بكل فئة
  Widget _buildContentForCategory(String category) {
    // هنا يمكنك وضع أي تصميم بناءً على الفئة المختارة
    return Center(
      child: Text(
        'Content for $category',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  // دالة التنقل بين الصفحات (BottomNavigationBar)
  void _onItemTapped(BuildContext context, int index) {
    // تنفيذ التنقل بين الشاشات
    switch (index) {
      case 0:
        // Navigate to Home screen
        break;
      case 1:
        // Navigate to Categories screen
        break;
      case 2:
        // Navigate to Search screen
        break;
      case 3:
        // Navigate to Offers screen
        break;
      case 4:
        // Navigate to Cart screen
        break;
    }
  }
}
