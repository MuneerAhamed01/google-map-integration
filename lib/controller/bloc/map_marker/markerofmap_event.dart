part of 'markerofmap_bloc.dart';

@immutable
abstract class MarkerofmapEvent {}

class MarkerPerform extends MarkerofmapEvent {
  final LatLng position;
  final Set<Marker> marker;

  MarkerPerform({required this.position, required this.marker});
}

class MarkerPerformSearching extends MarkerofmapEvent {
  final String positonAddress;
  final Set<Marker> marker;


  MarkerPerformSearching({required this.positonAddress,required this.marker});
}
class MarkerRemover extends MarkerofmapEvent{
  final Set<Marker> marker;
  final LatLng position;


  MarkerRemover(this.marker,this.position);

}