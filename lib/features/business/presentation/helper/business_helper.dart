import 'package:flutter/material.dart';

AssetImage getRatingImage(num rating) {
  String assetName;
  if (rating == 5) {
    assetName = "assets/stars_small_5.png";
  } else if (rating == 4.5) {
    assetName = "assets/stars_small_4_half.png";
  } else if (rating == 4) {
    assetName = "assets/stars_small_4.png";
  } else if (rating == 3.5) {
    assetName = "assets/stars_small_3_half.png";
  } else if (rating == 3) {
    assetName = "assets/stars_small_3.png";
  } else if (rating == 2.5) {
    assetName = "assets/stars_small_2_half.png";
  } else if (rating == 2) {
    assetName = "assets/stars_small_2.png";
  } else if (rating == 1.5) {
    assetName = "assets/stars_small_1_half.png";
  } else if (rating == 1) {
    assetName = "assets/stars_small_1.png";
  } else {
    assetName = "assets/stars_small_0.png";
  }
  return AssetImage(assetName);
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

const Map<int, String> days = {
  0: "Monday",
  1: "Tuesday",
  2: "Wednesday",
  3: "Thursday",
  4: "Friday",
  5: "Saturday",
  6: "Sunday",
}; // TODO i18n
