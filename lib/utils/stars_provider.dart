import 'package:flutter/material.dart';

AssetImage getRatingImage(num rating) {
  String assetName;
  if (rating == 1) {
    assetName = "assets/stars_small_1.png";
  } else if (rating == 1.5) {
    assetName = "assets/stars_small_1_half.png";
  } else if (rating == 2) {
    assetName = "assets/stars_small_2.png";
  } else if (rating == 2.5) {
    assetName = "assets/stars_small_2_half.png";
  } else if (rating == 3) {
    assetName = "assets/stars_small_3.png";
  } else if (rating == 3.5) {
    assetName = "assets/stars_small_3_half.png";
  } else if (rating == 4) {
    assetName = "assets/stars_small_4.png";
  } else if (rating == 4.5) {
    assetName = "assets/stars_small_4_half.png";
  } else if (rating == 5) {
    assetName = "assets/stars_small_5.png";
  } else {
    assetName = "assets/stars_small_0.png";
  }
  return AssetImage(assetName);
}
