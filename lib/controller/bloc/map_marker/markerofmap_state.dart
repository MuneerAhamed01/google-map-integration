part of 'markerofmap_bloc.dart';

@immutable
abstract class MarkerofmapState {}

class MarkerofmapOnMarking extends MarkerofmapState {
 final Set<Marker> marker;

  MarkerofmapOnMarking({required this.marker});
}
