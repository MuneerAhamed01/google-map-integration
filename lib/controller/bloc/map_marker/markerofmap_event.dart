part of 'markerofmap_bloc.dart';

@immutable
abstract class MarkerofmapEvent {}

class MarkerPerform extends MarkerofmapEvent {
  final LatLng position;
  final Set<Marker> marker;

  MarkerPerform({required this.position,required this.marker});
}
