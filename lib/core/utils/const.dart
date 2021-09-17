import 'package:flutter/foundation.dart';

const URL_REST = "https://api.yelp.com/v3";
const URL_GRAPHQL = "https://api.yelp.com/v3/graphql";

const NAMED_API_KEY = "apiKey";

enum DataLayer { rest, graphql, stub }

const _selectedDataLayer = DataLayer.graphql; // Change the data layer for the one you want to use
// Force Web to use stub data: https://github.com/matthieucoisne/YelpExplorer-Flutter/issues/18
const DATA_LAYER = kIsWeb ? DataLayer.stub : _selectedDataLayer;

const PATTERN_DATE_TIME = "yyyy-MM-dd HH:mm:ss";
const PATTERN_DATE = "M/d/yyyy";
const PATTERN_HOUR_MINUTE = "HHmm";
const PATTERN_TIME = "h:mm a";

const Map<int, String> days = {
  0: "Monday",
  1: "Tuesday",
  2: "Wednesday",
  3: "Thursday",
  4: "Friday",
  5: "Saturday",
  6: "Sunday",
}; // TODO i18n
