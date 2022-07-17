import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemapimplementation/controller/api_key/api_key.dart';
import 'package:meta/meta.dart';

part 'markerofmap_event.dart';
part 'markerofmap_state.dart';

class MarkerofmapBloc extends Bloc<MarkerofmapEvent, MarkerofmapState> {
  MarkerofmapBloc()
      : super(
            MarkerofmapOnMarking(marker: <Marker>{}, polyLine: <Polyline>{})) {
    on<MarkerPerform>((event, emit) {
      if (event.marker.length == 2) {
        print("haeeeeeee");
        for (var element in event.marker) {
          if (element.markerId.value == "Marker ${event.markerId}") {
            event.marker.remove(element);
            break;
          }
        }
        event.polyLine.clear();
      }

      event.marker.add(Marker(
          markerId: MarkerId("Marker ${event.markerId}"),
          position: LatLng(event.position.latitude, event.position.longitude),
          infoWindow: InfoWindow(
              title: 'position ${event.marker.length + 1} ',
              snippet:
                  'latitude:${event.position.latitude},longitude:${event.position.longitude}')));
      log(event.marker.toString());
      emit(
          MarkerofmapOnMarking(marker: event.marker, polyLine: event.polyLine));
    });
    on<MarkerPerformSearching>((event, emit) async {
      try {
        List<Location> locations = await locationFromAddress(
          event.positonAddress,
        );
        final LatLng location =
            LatLng(locations[0].latitude, locations[0].longitude);

        add(MarkerPerform(
            marker: event.marker,
            polyLine: event.polyLine,
            position: location,
            markerId: event.markerId));
      } catch (e) {
        print("-----------------------------------${e.toString()}");
      }
    });
    // on<GetThePolyine>((event, emit) async {
    //   PolylinePoints points = PolylinePoints();
    //   log(event.marker.toString());

    //   final LatLng start = event.marker.toList()[0].position;
    //   final LatLng end = event.marker.toList()[1].position;
    //   try {
    //     final List<LatLng> pointsTaking = [];

    //     final result = await points.getRouteBetweenCoordinates(
    //         APICallings.apikey,
    //         PointLatLng(start.latitude, start.longitude),
    //         PointLatLng(end.latitude, end.longitude));
    //     print(result.points.length);
    //     if (result.status == "OK") {
    //       result.points.forEach((element) {
    //         print("object");
    //         pointsTaking.add(LatLng(element.latitude, element.longitude));
    //       });
    //     } else {
    //       print(result.errorMessage);
    //     }

    //     log(pointsTaking.toString());

    //     event.polyLine.add(Polyline(
    //         width: 10,
    //         color: Colors.red,
    //         polylineId: PolylineId("polyLine ${event.polyLine.length + 1}"),
    //         points: pointsTaking));
    //     emit(MarkerofmapOnMarking(
    //         marker: event.marker, polyLine: event.polyLine));
    //   } catch (e) {
    //     print(e.toString());
    //   }
    // });
    on<GetThePolyine>((event, emit) async {
      final List<LatLng> pointsTaking = [];

      log(pointsTaking.toString());
      final startPoint = event.marker.toList()[0].position;
      final endPoint = event.marker.toList()[1].position;

      event.polyLine.add(Polyline(
          width: 10,
          color: Colors.red,
          polylineId: PolylineId("polyLine ${event.polyLine.length + 1}"),
          points: [startPoint, endPoint]));
      final distaceBetween = Geolocator.distanceBetween(startPoint.latitude,
              startPoint.longitude, endPoint.latitude, endPoint.longitude) /
          1000;
      emit(MarkerofmapOnMarking(
          marker: event.marker,
          polyLine: event.polyLine,
          distance: distaceBetween));
    });
  }
}
