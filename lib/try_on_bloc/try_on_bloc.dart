import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skims_poc/gemini_api_client.dart';
import 'package:skims_poc/try_on_bloc/try_on_event.dart';
import 'package:skims_poc/try_on_bloc/try_on_state.dart';

class TryOnBloc extends Bloc<TryOnEvent, TryOnState> {
  late final ImageApiClient _imageApiClient;

  TryOnBloc() : super(TryOnState.initial()) {
    on<LoadOutfitEvent>(_onLoadOutfitEvent);
    on<LoadPersonEvent>(_onLoadPersonEvent);
    _imageApiClient = ImageApiClient();
    // on<GenerateImageEvent>(_onGenerateImageEvent);
  }

  void _onLoadOutfitEvent(
    LoadOutfitEvent event,
    Emitter<TryOnState> emit,
  ) async {
    ByteData bytes = await rootBundle.load(event.outfitImage);
    var buffer = bytes.buffer;
    var unit8List = buffer.asUint8List(
      bytes.offsetInBytes,
      bytes.lengthInBytes,
    );
    emit(state.copyWith(clothingImage: base64Encode(unit8List)));
  }

  void _onLoadPersonEvent(
    LoadPersonEvent event,
    Emitter<TryOnState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final imageBytes = await image?.readAsBytes();
    if (imageBytes != null) {
      emit(state.copyWith(personImage: base64Encode(imageBytes)));
      await _generateImageEvent(event, emit);
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _generateImageEvent(
    LoadPersonEvent event,
    Emitter<TryOnState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isError: false));
    if (state.personImage.isNotEmpty && state.clothingImage.isNotEmpty) {
      final image = await _imageApiClient.generateImagePreview(
        personImage: state.personImage,
        clothingImage: state.clothingImage,
      );
      emit(state.copyWith(isLoading: false, resultImage: image));
    } else {
      emit(state.copyWith(isLoading: false, isError: true));
    }
  }
}
