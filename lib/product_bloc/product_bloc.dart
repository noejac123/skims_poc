import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skims_poc/assets.dart';
import 'package:skims_poc/product_bloc/product_event.dart';
import 'package:skims_poc/product_bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState.initial()) {
    on<LoadProductEvent>(_onLoadProductEvent);
  }

  void _onLoadProductEvent(LoadProductEvent event, Emitter<ProductState> emit) {
    emit(state.copyWith(isLoading: true));
    Future.delayed(const Duration(seconds: 1));
    emit(
      state.copyWith(
        name: 'Long Sleeve Boatneck Top',
        category: 'Cotton Jersey',
        description:
            'This long sleeve top is made from our signature Cotton Jersey—soft, breathable, and always flattering. Perfect for transitional layering, this boat neck staple features a body-hugging fit.',
        price: 58,
        isLoading: false,
        productImages: [AppAssets.image1, AppAssets.image2, AppAssets.image3],
        tryOnImage: AppAssets.image4,
      ),
    );
  }
}
