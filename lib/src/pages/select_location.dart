import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:prestador_final/src/usuario.dart' as globals;

class SelectLocation extends StatefulWidget {
  SelectLocation({Key key}) : super(key: key);

  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  LocationResult _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 10),
          child: Column(
            children: <Widget>[
              Container(
                width: 200,
              ),
              _pickedLocation == null
                  ? GestureDetector(
                      onTap: () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        LocationResult result = await showLocationPicker(
                          context,
                          "AIzaSyCFQdixGYejzWGNYygW5H9KIHRAk2p2Ld0",
                          initialCenter: LatLng(31.1975844, 29.9598339),
//                      automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
                          myLocationButtonEnabled: true,
                          layersButtonEnabled: true,

//                      resultCardAlignment: Alignment.bottomCenter,
                        );
                        print("result uno = $result");
                        setState(() {
                          _pickedLocation = result;
                          globals.direccion = result.address.toString();
                          globals.a=result.latLng.latitude.toDouble();
                          globals.b=result.latLng.longitude.toDouble();
                          print(globals.a);
                          print(globals.b);
                          //print(globals.direccion);
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Icon(Icons.add_location,
                                size: MediaQuery.of(context).size.height / 15,
                                color: Color.fromRGBO(31, 56, 96, 1),)
                          ),
                          Container(
                            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/50),
                            child: Text('Agregar mi ubicación',
                                style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      ))
                  : GestureDetector(
                      onTap: () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        LocationResult result = await showLocationPicker(
                          context,
                          "AIzaSyCFQdixGYejzWGNYygW5H9KIHRAk2p2Ld0",
                          initialCenter: LatLng(31.1975844, 29.9598339),
//                      automaticallyAnimateToCurrentLocation: true,
//                      mapStylePath: 'assets/mapStyle.json',
                          myLocationButtonEnabled: true,
                          layersButtonEnabled: true,

//                      resultCardAlignment: Alignment.bottomCenter,
                        );
                        print(result.address);
                        setState(() {
                          _pickedLocation = result;
                          print("result=$result");
                          globals.direccion = result.address.toString();
                          print(globals.direccion);
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(LineIcons.map_marker),
                          Expanded(
                            child: Text(
                              _pickedLocation == null
                                  ? ''
                                  : _pickedLocation.address.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
