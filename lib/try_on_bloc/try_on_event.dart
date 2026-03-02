sealed class TryOnEvent {}

class LoadOutfitEvent extends TryOnEvent {
  final String outfitImage;

  LoadOutfitEvent({required this.outfitImage});
}

class LoadPersonEvent extends TryOnEvent {
  LoadPersonEvent();
}
