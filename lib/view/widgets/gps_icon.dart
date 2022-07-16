  import 'package:flutter/material.dart';

Padding gpsIcon() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: Colors.white60.withOpacity(0.8),
            borderRadius: BorderRadius.circular(3)),
        child: IconButton(
            onPressed: () {}, icon: const Icon(Icons.gps_fixed_outlined)),
      ),
    );
  }

