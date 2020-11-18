# YelpExplorer-Flutter

[![build](https://github.com/matthieucoisne/YelpExplorer-Flutter/workflows/build/badge.svg)](https://github.com/matthieucoisne/YelpExplorer-Flutter/blob/main/.github/workflows/build.yml)

[Try the web app](https://matthieucoisne.github.io/YelpExplorer-Flutter/)

## Project Description

YelpExplorer-Flutter is a Flutter application that shows a list of business, their details and latest reviews using [Yelp](https://www.yelp.com/)'s API.

The goal of this project is to demonstrate the differences between using a REST API versus a GraphQL API in a modern Flutter application, that has a scalable, maintainable and testable architecture.

## Project Characteristics

* Multiplatform project using [Flutter](https://flutter.dev/) and [Dart](https://dart.dev/)
* Modern architecture (Clean Architecture, BLoC, Service Locator)
* Testing
* Material design
* Continuous Integration with GitHub [Actions](https://github.com/matthieucoisne/YelpExplorer-Flutter/actions)
* Project management with GitHub [Project Board](https://github.com/matthieucoisne/YelpExplorer-Flutter/projects/1)

## Tech Stack

* Tech Stack
    * [Flutter](https://flutter.dev/) and [Dart](https://dart.dev/)
    * [Flutter BLoC](https://pub.dev/packages/flutter_bloc)
    * [Equatable](https://pub.dev/packages/equatable)
    * [GetIt](https://pub.dev/packages/get_it)
    * [GraphQL Flutter](https://pub.dev/packages/graphql_flutter)
    * [Http Client](https://pub.dev/packages/http)

## Development Setup

### Yelp API Key

If you want to build and run this project on physical device, a simulator/emulator, or a web browser, you need to obtain your own API key from Yelp and provide it to the app.

1. Clone this project using Git or download the source code
2. Request your API key: https://www.yelp.com/developers/documentation/v3/authentication \
   Note: You might need to join the developer beta to use GraphQL
3. Create a json file `config/app_config.json` located at the root of the project and add your API key like this:
   ```
   {
     "api_key": "YOUR_API_KEY"
   }
   ```

Alternatively, you can play with the web version of the app [https://matthieucoisne.github.io/YelpExplorer-Flutter/](https://matthieucoisne.github.io/YelpExplorer-Flutter/)

### REST vs GraphQL


This project allows you to either use the GraphQL API or the REST API of Yelp to retrieve data.\
To switch between one or the other, you can change the value of `USE_GRAPHQL` in `lib/core/utils/const.dart`

## Author

[![Follow me](https://img.shields.io/twitter/follow/matthieucoisne?style=social)](https://twitter.com/matthieucoisne)

## License
```
Copyright 2020 Matthieu Coisne

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
