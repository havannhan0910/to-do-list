import 'dart:math';

import 'package:flutter/material.dart';

dynamic mainScreenList = [
  'assets/image-5.jpg',
  'assets/image-11.jpg',
];


class RandomImage {
  AssetImage mainList() {
    int min = 0;
    int max = mainScreenList.length;

    int _random1 = Random().nextInt(max-min);
    String _imgName = mainScreenList[_random1].toString();
    return AssetImage(_imgName);
  }
}


