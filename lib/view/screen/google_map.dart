import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemapimplementation/controller/bloc/map_marker/markerofmap_bloc.dart';
import 'package:location/location.dart';

import '../../controller/permission_handling/location_permission.dart';
import '../widgets/bottom_container.dart';
import '../widgets/gps_icon.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  LocationData? _currentLocation;
  static double? _currentLatitude;
  static double? _currentLongitude;
  TextEditingController controllerOne = TextEditingController();
  TextEditingController controllerTwo = TextEditingController();

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((value) {
      setState(() {
        _currentLocation = value;
        _currentLatitude = value.latitude;
        _currentLongitude = value.longitude;
      });
    });
  }

  @override
  void initState() {
    askPermissionLocation();

    getCurrentLocation();
    super.initState();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(_currentLatitude!, _currentLongitude!),
    zoom: 14.4746,
  );
// Set<Marker> _ markers = s
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : BlocBuilder<MarkerofmapBloc, MarkerofmapState>(
              builder: (context, state) {
                state as MarkerofmapOnMarking;
                return SafeArea(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      GoogleMap(
                        myLocationEnabled: true,
                        markers: state.marker,
                        initialCameraPosition: _kGooglePlex,
                        mapType: MapType.normal,
                        onTap: (position) {
                          context.read<MarkerofmapBloc>().add(MarkerPerform(
                              position: position, marker: state.marker));
                        },
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          gpsIcon(),
                          bottomContainer(height, state.marker,controllerOne,controllerTwo),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
