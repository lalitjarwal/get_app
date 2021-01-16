import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final controller = Get.put(ColorScheme());
  final gridController = Get.put(GridController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Color Palate Generator Get App'),
        ),
        body: Obx(() => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 25),
                  Container(
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
                  ),
                  Slider(
                      min: 0.0,
                      max: 255.0,
                      divisions: 255,
                      activeColor: Colors.red,
                      value: controller.r.value,
                      onChanged: (val) => controller.updateR(val)),
                  Slider(
                      min: 0.0,
                      max: 255.0,
                      activeColor: Colors.green,
                      value: controller.g.value,
                      onChanged: (val) => controller.updateG(val)),
                  Slider(
                      min: 0.0,
                      max: 255.0,
                      activeColor: Colors.blue,
                      value: controller.b.value,
                      onChanged: (val) => controller.updateB(val)),
                  SizedBox(
                    width: 350,
                    child: RaisedButton(
                        child: Text('Add Color'),
                        onPressed: () {
                          gridController.addToList(Container(
                              width: 100,
                              height: 100,
                              color: controller.color));
                        }),
                  ),
                  Text(
                      '* long press the colored box to copy Hex coe of the Color'),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 4.0,
                        ),
                        borderRadius: BorderRadius.circular(12)),
                    width: double.infinity,
                    height: 300,
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: gridController._list.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onLongPress: () async {
                            await Clipboard.setData(ClipboardData(
                                text:
                                    '#${gridController.color(index).toString().substring(10, 16)}'));
                            gridController.copied(
                                index, gridController.color(index));
                            Get.snackbar('Copied', 'Color code copied');
                          },
                          child: gridController._list[index],
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                          crossAxisCount: 5),
                    ),
                  ),
                ],
              ),
            )),
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

class GridController extends GetxController {
  var _list = <Container>[].obs;
  void addToList(Container widget) {
    _list.add(widget);
  }

  get list {
    return _list;
  }

  Color color(int index) {
    return _list[index].color;
  }

  void copied(int index, Color color) {
    _list.removeAt(index);
    _list.insert(
        index,
        Container(
          width: 100,
          height: 100,
          color: color,
          child: Icon(Icons.check),
        ));
  }
}
