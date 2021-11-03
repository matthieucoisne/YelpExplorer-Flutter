import 'package:flutter/material.dart';

AssetImage getRatingImage(num rating) {
  String assetName;
  if (rating.floor() == rating) {
    assetName = "stars_small_${"$rating".replaceAll('.0', '')}.png";
  } else {
    assetName = "stars_small_${"$rating".replaceAll('.5', '_half')}.png";
  }
  return AssetImage("assets/$assetName");
}

String formatPriceAndCategories(String price, List<String> categories) {
  String separator;
  if (price.isNotEmpty && categories.length > 0) {
    separator = "\u0020\u0020\u2022\u0020\u0020"; // "  •  "
  } else {
    separator = "";
  }
  return "$price$separator${categories.join(", ")}"; // "$$  •  Sushi, Poke"
}
