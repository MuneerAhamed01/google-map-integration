import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'markerofmap_event.dart';
part 'markerofmap_state.dart';

class MarkerofmapBloc extends Bloc<MarkerofmapEvent, MarkerofmapState> {
  MarkerofmapBloc() : super(MarkerofmapOnMarking(marker: <Marker>{})) {
    on<MarkerPerform>((event, emit) {
      event.marker.add(
        Marker(
            markerId: MarkerId("Marker ${event.marker.length + 1}"),
            position: LatLng(event.position.latitude, event.position.longitude),
            infoWindow: InfoWindow(
                title: 'position ${event.marker.length + 1} ',
                snippet:
                    'latitude:${event.position.latitude},longitude:${event.position.longitude}')),
      );
      emit(MarkerofmapOnMarking(marker: event.marker));
    });
  }
}
