import '../../domain/entities/product.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/deal.dart';

class MockHomeRepository {
  // Mock Products Data
  List<Product> getProducts() {
    return [
      const Product(
        id: '1',
        name: 'Organic Beetroot Fresh',
        description: 'Natural',
        price: 4.99,
        category: 'Fresh',
        imageUrl: '🥬',
        discount: 20,
        badge: '20% OFF',
      ),
      const Product(
        id: '2',
        name: 'Green Capsicum Organic',
        description: 'Healthy',
        price: 6.99,
        category: 'Fresh',
        imageUrl: '🫑',
        discount: 20,
        badge: '20% OFF',
      ),
      const Product(
        id: '3',
        name: 'Fresh Tomatoes',
        description: 'Organic & Fresh',
        price: 3.99,
        category: 'Fresh',
        imageUrl: '🍅',
        discount: 15,
        badge: '15% OFF',
      ),
      const Product(
        id: '4',
        name: 'Fresh Carrots',
        description: 'Crunchy & Sweet',
        price: 2.99,
        category: 'Fresh',
        imageUrl: '🥕',
        discount: 10,
        badge: '10% OFF',
      ),
    ];
  }

  // Mock Categories Data
  List<CategoryItem> getCategories() {
    return const [
      CategoryItem(
        id: '1',
        name: 'All',
        icon: '📦',
        isSelected: true,
      ),
      CategoryItem(
        id: '2',
        name: 'Fresh',
        icon: '🍎',
        isSelected: false,
      ),
      CategoryItem(
        id: '3',
        name: 'Electronics',
        icon: '🎧',
        isSelected: false,
      ),
    ];
  }

  // Mock Deals Data
  List<Deal> getDeals() {
    return const [
      Deal(
        id: '1',
        title: 'Kitchenware',
        description: 'Up to 50% OFF',
        discount: 50,
        imageUrl: '🍽️',
        backgroundColor: '#E8FFB3',
      ),
      Deal(
        id: '2',
        title: 'Travel',
        description: 'Up to 70% OFF',
        discount: 70,
        imageUrl: '🧳',
        backgroundColor: '#FFE8B3',
      ),
      Deal(
        id: '3',
        title: 'Makeup',
        description: 'Min 40% OFF',
        discount: 40,
        imageUrl: '💄',
        backgroundColor: '#FFE5E5',
      ),
      Deal(
        id: '4',
        title: 'Fragrance',
        description: 'Up to 60% OFF',
        discount: 60,
        imageUrl: '🧴',
        backgroundColor: '#E5E5FF',
      ),
    ];
  }
}
