part of 'markerofmap_bloc.dart';

@immutable
abstract class MarkerofmapState {}

class MarkerofmapOnMarking extends MarkerofmapState {
  final Set<Marker> marker;
  final Set<Polyline> polyLine;
  final double? distance;
  MarkerofmapOnMarking({required this.marker, required this.polyLine,this.distance});
}
