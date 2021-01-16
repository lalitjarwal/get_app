import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final controller = Get.put(ColorScheme());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Color Generator Get App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 18.0),
                decoration: BoxDecoration(
                    color: controller.color,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(6, 6),
                          color: Colors.black26,
                          blurRadius: 6.0)
                    ],
                    borderRadius: BorderRadius.circular(12)),
                width: double.infinity,
                height: 200,
              );
            }),
            ObxValue((r) {
              return Slider(
                  min: 0.0,
                  max: 255.0,
                  activeColor: Colors.red,
                  value: r.value,
                  onChanged: (val) => controller.updateR(val));
            }, controller.r),
            ObxValue((g) {
              return Slider(
                  min: 0.0,
                  max: 255.0,
                  activeColor: Colors.green,
                  value: g.value,
                  onChanged: (val) => controller.updateG(val));
            }, controller.g),
            ObxValue((b) {
              return Slider(
                  min: 0.0,
                  max: 255.0,
                  activeColor: Colors.blue,
                  value: b.value,
                  onChanged: (val) => controller.updateB(val));
            }, controller.b),
            Obx(() => SelectableText(
                  'ColorHex: ${controller.color.toString().substring(10, 16)}',
                  textScaleFactor: 1.5,
                ))
          ],
        ),
      ),
    );
  }
}

class ColorScheme extends GetxController {
  var r = 0.0.obs;
  var g = 0.0.obs;
  var b = 0.0.obs;
  void updateR(double _r) {
    r.value = _r;
  }

  void updateG(double _g) {
    g.value = _g;
  }

  void updateB(double _b) {
    b.value = _b;
  }

  get color {
    return Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), 1);
  }
}
