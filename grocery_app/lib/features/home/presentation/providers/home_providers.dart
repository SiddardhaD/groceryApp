import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/mock_home_repository.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/deal.dart';

// Repository Provider
final homeRepositoryProvider = Provider<MockHomeRepository>((ref) {
  return MockHomeRepository();
});

// Products Provider
final productsProvider = Provider<List<Product>>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return repository.getProducts();
});

// Categories Provider with State
final categoriesProvider = StateNotifierProvider<CategoriesNotifier, List<CategoryItem>>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return CategoriesNotifier(repository.getCategories());
});

class CategoriesNotifier extends StateNotifier<List<CategoryItem>> {
  CategoriesNotifier(super.initialCategories);

  void selectCategory(String categoryId) {
    state = state.map((category) {
      return category.copyWith(
        isSelected: category.id == categoryId,
      );
    }).toList();
  }
}

// Selected Category Provider
final selectedCategoryProvider = Provider<CategoryItem?>((ref) {
  final categories = ref.watch(categoriesProvider);
  try {
    return categories.firstWhere((category) => category.isSelected);
  } catch (e) {
    return null;
  }
});

// Filtered Products Provider
final filteredProductsProvider = Provider<List<Product>>((ref) {
  final products = ref.watch(productsProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);

  if (selectedCategory == null || selectedCategory.name == 'All') {
    return products;
  }

  return products.where((product) => product.category == selectedCategory.name).toList();
});

// Deals Provider
final dealsProvider = Provider<List<Deal>>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return repository.getDeals();
});

// Search Query Provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Searched Products Provider
final searchedProductsProvider = Provider<List<Product>>((ref) {
  final products = ref.watch(filteredProductsProvider);
  final query = ref.watch(searchQueryProvider);

  if (query.isEmpty) {
    return products;
  }

  return products.where((product) {
    return product.name.toLowerCase().contains(query.toLowerCase()) ||
        product.description.toLowerCase().contains(query.toLowerCase());
  }).toList();
});
