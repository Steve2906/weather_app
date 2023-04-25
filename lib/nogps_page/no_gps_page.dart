import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/weather_page/weather_page.dart';

class noGPSPage extends StatefulWidget {
  const noGPSPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _noGPSPageState();
  }
}

class _noGPSPageState extends State<noGPSPage> {
  var location = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherApp',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: Icon(
                    Icons.gpp_bad,
                    size: 60.0,
                    color: Colors.blue,
                  )),
              const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                  child: Text(
                    "Please give permission to use geolocation in the app settings.",
                    textAlign: TextAlign.center,
                  )),
              Visibility(
                visible: !location,
                child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: MaterialButton(
                        color: Colors.blue,
                        onPressed: requestpermission,
                        textColor: Colors.white,
                        child: const Text("Request permission"))),
              ),
              Visibility(
                visible: location,
                child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: MaterialButton(
                        color: Colors.blue,
                        onPressed: () {Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const WeatherPage()));},
                        textColor: Colors.white,
                        child: const Text("Continue"))),
              )
            ],
          ),
        ),
      )),
    );
  }

  void checkpermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {}
    if (status.isGranted) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const WeatherPage()));
    }
  }

  void requestpermission() async {
    await Permission.location.request();
    location = true;
    print(location);
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    checkpermission();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }
}
