part of 'markerofmap_bloc.dart';

@immutable
abstract class MarkerofmapEvent {}

class MarkerPerform extends MarkerofmapEvent {
  final LatLng position;
  final Set<Marker> marker;
  final Set<Polyline> polyLine;
  final String? markerId;

  MarkerPerform(
      {required this.position, required this.marker, required this.polyLine,this.markerId});
}

class MarkerPerformSearching extends MarkerofmapEvent {
  final String positonAddress;
  final Set<Marker> marker;
  final Set<Polyline> polyLine;
  final String? markerId;

  MarkerPerformSearching(
      {required this.positonAddress,
      this.markerId,
      required this.marker,
      required this.polyLine});
}

class GetThePolyine extends MarkerofmapEvent {
  final Set<Polyline> polyLine;
  final Set<Marker> marker;

  GetThePolyine({required this.polyLine, required this.marker});
}
