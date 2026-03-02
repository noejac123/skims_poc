import 'package:equatable/equatable.dart';

class ProductState extends Equatable {
  final String name;
  final String category;
  final double price;
  final String description;
  final List<String> productImages;
  final String tryOnImage;
  final bool isLoading;
  final bool isError;

  const ProductState({
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.productImages,
    required this.tryOnImage,
    required this.isLoading,
    required this.isError,
  });

  factory ProductState.initial() {
    return const ProductState(
      name: '',
      category: '',
      price: 0,
      description: '',
      productImages: [],
      tryOnImage: '',
      isLoading: true,
      isError: false,
    );
  }

  @override
  List<Object?> get props => [
    name,
    category,
    price,
    description,
    productImages,
    tryOnImage,
    isLoading,
    isError,
  ];

  ProductState copyWith({
    String? name,
    String? category,
    double? price,
    String? description,
    List<String>? productImages,
    String? tryOnImage,
    bool? isLoading,
    bool? isError,
  }) {
    return ProductState(
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      description: description ?? this.description,
      productImages: productImages ?? this.productImages,
      tryOnImage: tryOnImage ?? this.tryOnImage,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
