import 'package:equatable/equatable.dart';

class TryOnState extends Equatable {
  final String personImage;
  final String clothingImage;
  final String prompt;
  final String resultImage;
  final bool isLoading;
  final bool isError;

  const TryOnState({
    required this.personImage,
    required this.clothingImage,
    required this.prompt,
    required this.resultImage,
    required this.isLoading,
    required this.isError,
  });

  factory TryOnState.initial() {
    return const TryOnState(
      personImage: '',
      clothingImage: '',
      prompt: '',
      resultImage: '',
      isLoading: false,
      isError: false,
    );
  }

  copyWith({
    String? personImage,
    String? clothingImage,
    String? prompt,
    String? resultImage,
    bool? isLoading,
    bool? isError,
  }) {
    return TryOnState(
      personImage: personImage ?? this.personImage,
      clothingImage: clothingImage ?? this.clothingImage,
      prompt: prompt ?? this.prompt,
      resultImage: resultImage ?? this.resultImage,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [
    personImage,
    clothingImage,
    prompt,
    resultImage,
    isLoading,
    isError,
  ];
}
