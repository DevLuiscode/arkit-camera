import 'dart:async';

import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

class EarthPage extends StatefulWidget {
  @override
  _EarthPageState createState() => _EarthPageState();
}

class _EarthPageState extends State<EarthPage> {
  late ARKitController arkitController;
  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('AR')),
        body: Container(
          child: ARKitSceneView(
            onARKitViewCreated: onARKitViewCreated,
          ),
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    final material = ARKitMaterial(
      lightingModelName: ARKitLightingModel.lambert,
      diffuse: ARKitMaterialProperty.image('assets/inca.jpeg'),
    );
    final sphere = ARKitSphere(
      materials: [material],
      radius: 0.17,
    );

    final node = ARKitNode(
      name: 'hola',
      geometry: sphere,
      position: Vector3(0, 0, -0.5),
      eulerAngles: Vector3.zero(),
    );
    this.arkitController.add(node);

    timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      final rotation = node.eulerAngles;
      rotation.x += 0.0020;
      node.eulerAngles = rotation;
    });
  }
}
