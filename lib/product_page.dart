import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skims_poc/product_bloc/product_bloc.dart';
import 'package:skims_poc/product_bloc/product_event.dart';
import 'package:skims_poc/product_bloc/product_state.dart';
import 'package:skims_poc/try_on_bloc/try_on_bloc.dart';
import 'package:skims_poc/try_on_bloc/try_on_event.dart';
import 'package:skims_poc/try_on_bloc/try_on_state.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(LoadProductEvent()),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.isError) {
            return const Center(child: Text('Product Not Found'));
          } else {
            return Scaffold(
              body: BlocBuilder<TryOnBloc, TryOnState>(
                builder: (context, tryOnState) {
                  if (tryOnState.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final tryOnBloc = context.read<TryOnBloc>();
                  tryOnBloc.add(LoadOutfitEvent(outfitImage: state.tryOnImage));
                  return BlocListener<TryOnBloc, TryOnState>(
                    listenWhen: (previous, current) {
                      return previous.isError == false &&
                          current.isError == true;
                    },
                    listener: (context, state) {
                      if (state.isError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error loading try on image'),
                          ),
                        );
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.6,
                            pageSnapping: true,

                            viewportFraction: 1.0,
                            aspectRatio: 1.0,
                            enableInfiniteScroll: false,
                            padEnds: false,
                          ),
                          items: [
                            if (tryOnState.resultImage.isNotEmpty)
                              Image.memory(
                                base64Decode(tryOnState.resultImage),
                              ),
                            ...[
                              for (final image in state.productImages)
                                Image.asset(
                                  image,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                  width: MediaQuery.of(context).size.width,
                                ),
                            ],
                          ],
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                textAlign: TextAlign.start,
                                state.category.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                state.name.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                '\$${state.price.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                state.description,
                                style: TextStyle(
                                  color: const Color(0xFF504E4C),
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              bottomNavigationBar: Container(
                height: 100,
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: FilledButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return StatefulBuilder(
                          builder: (_, _) {
                            final tryOnBloc = context.read<TryOnBloc>();
                            return AlertDialog(
                              title: const Text('Try It On'),
                              content: const Text(
                                'To try this outfit on, please pick a photo. Photo selected should be a solo photo of you.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    tryOnBloc.add(LoadPersonEvent());
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Select Photo'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  child: const Text('TRY IT ON'),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
