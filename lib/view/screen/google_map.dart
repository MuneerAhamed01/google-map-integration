import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemapimplementation/controller/bloc/map_marker/markerofmap_bloc.dart';
import 'package:location/location.dart' as locate;

import '../../controller/permission_handling/location_permission.dart';
import '../widgets/bottom_container.dart';
import '../widgets/gps_icon.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  locate.LocationData? _currentLocation;
  static double? _currentLatitude;
  static double? _currentLongitude;
  TextEditingController controllerOne = TextEditingController();
  TextEditingController controllerTwo = TextEditingController();
  // Completer<GoogleMapController> _controller = Completer();
  // late GoogleMapController _googleMapController;

  void getCurrentLocation() async {
    locate.Location location = locate.Location();

    final locate.LocationData locationData = await location.getLocation();
    final address = await placemarkFromCoordinates(
        locationData.latitude!, locationData.longitude!);
    setState(() {
      _currentLocation = locationData;
      _currentLatitude = locationData.latitude;
      _currentLongitude = locationData.longitude;
      controllerOne.text =
          "${address[0].subAdministrativeArea!} ,${address[0].locality!}";
    });
    // _bloc.add(MarkerPerformSearching(positonAddress: address[0].subAdministrativeArea!, marker: state, polyLine: polyLine))
  }

  // final _bloc = MarkerofmapBloc();
  @override
  void initState() {
    askPermissionLocation();
    // getLocationAddress();

    getCurrentLocation();
    // _bloc.add(MarkerPerformSearching(positonAddress: , marker: marker, polyLine: polyLine))
    super.initState();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(_currentLatitude!, _currentLongitude!),
    zoom: 10.12,
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
                if (state.marker.isEmpty) {
                  context.read<MarkerofmapBloc>().add(MarkerPerformSearching(
                      positonAddress: controllerOne.text,
                      marker: state.marker,
                      polyLine: state.polyLine,
                      markerId: "Start Position"));
                }
                return SafeArea(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      GoogleMap(
                        // onMapCreated: (GoogleMapController controller) {
                        //   _googleMapController = controller;
                        // },
                        myLocationEnabled: true,
                        markers: state.marker,
                        polylines: state.polyLine,
                        initialCameraPosition: _kGooglePlex,
                        mapType: MapType.normal,
                        // onTap: (position) {
                        //   context.read<MarkerofmapBloc>().add(MarkerPerform(
                        //       position: position,
                        //       marker: state.marker,
                        //       polyLine: state.polyLine));
                        //   print(
                        //       "-------------------------${state.marker.length}");
                        // },
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // gpsIcon(),
                          bottomContainer(
                              text: state.distance != null
                                  ? "DISTANCE : ${state.distance!.floorToDouble()}Km"
                                  : 'DISTANCE : 0.00Km',
                              context: context,
                              end: controllerTwo,
                              height: height,
                              marker: state.marker,
                              polyLine: state.polyLine,
                              start: controllerOne),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }

  // void getLocationAddress() {}
}
