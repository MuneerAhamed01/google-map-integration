import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Container bottomContainer(double height,Set<Marker> marker,TextEditingController start,TextEditingController end) {
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
          
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: end,
          decoration: textfieldDecoration(label: "Destination"),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text("DISTANCE : 383.43Km",
            style: TextStyle(
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
