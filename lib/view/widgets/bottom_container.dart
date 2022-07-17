import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemapimplementation/controller/bloc/map_marker/markerofmap_bloc.dart';

Container bottomContainer(
    {required double height,
    required Set<Marker> marker,
    required Set<Polyline> polyLine,
    required TextEditingController start,
    required TextEditingController end,
    required BuildContext context,
    required String text}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    height: height / 3.3,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    child: Column(
      children: [
        TextField(
          controller: start,
          decoration: textfieldDecoration(label: "Start"),
          onSubmitted: (value) {
            context.read<MarkerofmapBloc>().add(MarkerPerformSearching(
                marker: marker,
                polyLine: polyLine,
                positonAddress: value,
                markerId: "Start Position"));
          },
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: end,
          decoration: textfieldDecoration(label: "Destination"),
          onSubmitted: (value) {
            print("dddddddd");
            context.read<MarkerofmapBloc>().add(MarkerPerformSearching(
                marker: marker,
                polyLine: polyLine,
                positonAddress: value,
                markerId: "End Position"));
          },
        ),
        const SizedBox(
          height: 15,
        ),
        Text(text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(
          height: 20,
        ),
        Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: MaterialButton(
              onPressed: () {
                // GeoCodingTrying().getPlaceResult(start.text);
                if (start.text.isNotEmpty && end.text.isNotEmpty) {
                  context
                      .read<MarkerofmapBloc>()
                      .add(GetThePolyine(marker: marker, polyLine: polyLine));
                }
              },
              child: const Text(
                "Show Direction",
                style: TextStyle(fontSize: 27, color: Colors.white),
              ),
            ))
      ],
    ),
  );
}

InputDecoration textfieldDecoration({required String label}) {
  return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      labelText: label);
}
