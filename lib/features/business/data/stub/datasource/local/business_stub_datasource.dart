import 'dart:convert';

import 'package:yelpexplorer/features/business/data/graphql/model/business_graphql_model.dart';

// For simplicity, the BusinessStubDataSource uses the GraphQL data and models
class BusinessStubDataSource {
  Future<BusinessListGraphQLModel> getBusinessList() {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => BusinessListGraphQLModel.fromJson(_businessList),
    );
  }

  Future<BusinessDetailsGraphQLModel> getBusinessDetails() {
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => BusinessDetailsGraphQLModel.fromJson(_businessDetailsAndReviews),
    );
  }
}

final Map<String, dynamic> _businessList = jsonDecode("""
{
  "search": {
    "total": 441,
    "business": [
      {
        "id": "IRIlwpomRvnXvpkeaGaM2A",
        "name": "Saint Sushi Plateau",
        "photos": [
          "https://s3-media3.fl.yelpcdn.com/bphoto/p_dKe_-P6QhcK7hVRxEF7Q/o.jpg"
        ],
        "rating": 4.5,
        "review_count": 346,
        "location": {
          "address1": "424 Avenue Duluth E",
          "city": "Montreal"
        },
        "price": "\$\$",
        "categories": [
          {
            "title": "Sushi Bars"
          },
          {
            "title": "Japanese"
          }
        ]
      },
      {
        "id": "wzugmCevnXuCMCF4upAf0w",
        "name": "Kazu",
        "photos": [
          "https://s3-media4.fl.yelpcdn.com/bphoto/IndU-qV2BQxkGrDBO0FoCg/o.jpg"
        ],
        "rating": 4.5,
        "review_count": 670,
        "location": {
          "address1": "1844 Rue Sainte-Catherine O",
          "city": "Montreal"
        },
        "price": "\$\$",
        "categories": [
          {
            "title": "Japanese"
          }
        ]
      },
      {
        "id": "5rWS10zVUc2Lqv4BVgrjJw",
        "name": "Ryú",
        "photos": [
          "https://s3-media3.fl.yelpcdn.com/bphoto/z2rL_G647Wy2UGgRYj-KHw/o.jpg"
        ],
        "rating": 4.0,
        "review_count": 75,
        "location": {
          "address1": "1468 Rue Peel",
          "city": "Montreal"
        },
        "price": "\$\$",
        "categories": [
          {
            "title": "Sushi Bars"
          },
          {
            "title": "Japanese"
          }
        ]
      },
      {
        "id": "tNT5kMf9JSmVXTYrKI-1OA",
        "name": "Okeya Kyujiro",
        "photos": [
          "https://s3-media1.fl.yelpcdn.com/bphoto/pvGgGF4WpJlYTNAe1hw3gw/o.jpg"
        ],
        "rating": 5.0,
        "review_count": 5,
        "location": {
          "address1": "1227 Rue de la Montagne",
          "city": "Montreal"
        },
        "price": null,
        "categories": [
          {
            "title": "Sushi Bars"
          }
        ]
      },
      {
        "id": "y32M2Hkr7GsUqGG6KwOhZw",
        "name": "KINKA IZAKAYA MONTREAL",
        "photos": [
          "https://s3-media4.fl.yelpcdn.com/bphoto/8JwCaciOuUpDHllshUQphg/o.jpg"
        ],
        "rating": 4.0,
        "review_count": 333,
        "location": {
          "address1": "1624 Rue Sainte-Catherine Ouest",
          "city": "Montreal"
        },
        "price": "\$\$",
        "categories": [
          {
            "title": "Japanese"
          },
          {
            "title": "Pubs"
          },
          {
            "title": "Tapas Bars"
          }
        ]
      },
      {
        "id": "BFzagTyKW_2_mAEuuAOyVg",
        "name": "KYO",
        "photos": [
          "https://s3-media1.fl.yelpcdn.com/bphoto/VwgwpMCx76D-Qht96FPwmg/o.jpg"
        ],
        "rating": 4.0,
        "review_count": 205,
        "location": {
          "address1": "711 Côte de la Place d'Armes",
          "city": "Montreal"
        },
        "price": "\$\$",
        "categories": [
          {
            "title": "Japanese"
          },
          {
            "title": "Sushi Bars"
          }
        ]
      },
      {
        "id": "d5wuEghsTR3rB1VXQKq1GA",
        "name": "YEN Cuisine Japonaise",
        "photos": [
          "https://s3-media3.fl.yelpcdn.com/bphoto/u9omLQLR-7W-xgLY7Wa4dw/o.jpg"
        ],
        "rating": 4.5,
        "review_count": 44,
        "location": {
          "address1": "2157 Rue Mackay",
          "city": "Montreal"
        },
        "price": null,
        "categories": [
          {
            "title": "Japanese"
          }
        ]
      },
      {
        "id": "LhxfGvL-0AWf8vkwy9NGPw",
        "name": "Sushi Yu Mi",
        "photos": [
          "https://s3-media4.fl.yelpcdn.com/bphoto/JJNkTmwCO4DaL6tVUj3KdQ/o.jpg"
        ],
        "rating": 4.5,
        "review_count": 34,
        "location": {
          "address1": "5124-A Rue Sherbrooke O",
          "city": "Montreal"
        },
        "price": "\$\$",
        "categories": [
          {
            "title": "Sushi Bars"
          }
        ]
      },
      {
        "id": "4akrn-j1hBYieWJWkoODfQ",
        "name": "Casa Kaizen",
        "photos": [
          "https://s3-media3.fl.yelpcdn.com/bphoto/STLfIoh-nDy0yyI9sKry3A/o.jpg"
        ],
        "rating": 5.0,
        "review_count": 4,
        "location": {
          "address1": "16 Avenue des Pins E",
          "city": "Montreal"
        },
        "price": null,
        "categories": [
          {
            "title": "Asian Fusion"
          }
        ]
      },
      {
        "id": "_mVKYE-xcor1omFJa1BtGA",
        "name": "Sushi Sama",
        "photos": [
          "https://s3-media4.fl.yelpcdn.com/bphoto/2Ic07H0fd7Wr35K7O8pJSQ/o.jpg"
        ],
        "rating": 5.0,
        "review_count": 5,
        "location": {
          "address1": "5200A Chemin de la Côte-des-Neiges",
          "city": "Montreal"
        },
        "price": null,
        "categories": [
          {
            "title": "Sushi Bars"
          },
          {
            "title": "Poke"
          }
        ]
      },
      {
        "id": "CEsh0ScOKlL3mpvjypqszA",
        "name": "Ichigo Ichie",
        "photos": [
          "https://s3-media1.fl.yelpcdn.com/bphoto/eSL3hQ7-IYIb5dqqXb6Scg/o.jpg"
        ],
        "rating": 4.5,
        "review_count": 99,
        "location": {
          "address1": "360 Rue Rachel E",
          "city": "Montreal"
        },
        "price": "\$\$",
        "categories": [
          {
            "title": "Japanese"
          },
          {
            "title": "Pubs"
          }
        ]
      },
      {
        "id": "GUEWBcErEzW-YYREq4ct6w",
        "name": "Nippon Sushi",
        "photos": [
          "https://s3-media1.fl.yelpcdn.com/bphoto/HtA25JnuolWz2-5gBmcqxw/o.jpg"
        ],
        "rating": 4.0,
        "review_count": 26,
        "location": {
          "address1": "1104 Boulevard de Maisonneuve O",
          "city": "Montreal"
        },
        "price": "\$\$",
        "categories": [
          {
            "title": "Sushi Bars"
          }
        ]
      },
      {
        "id": "6w7HK7E01WUzXd4mqOLD7Q",
        "name": "I Sushi",
        "photos": [
          "https://s3-media2.fl.yelpcdn.com/bphoto/cAJ2YG0qBBOGO8320Gz0Ag/o.jpg"
        ],
        "rating": 4.5,
        "review_count": 9,
        "location": {
          "address1": "447 Avenue Viger O",
          "city": "Montreal"
        },
        "price": "\$\$",
        "categories": [
          {
            "title": "Sushi Bars"
          }
        ]
      },
      {
        "id": "FI3PVYBuz5fioko7qhsPZA",
        "name": "Jun I",
        "photos": [
          "https://s3-media4.fl.yelpcdn.com/bphoto/cDgDrZ-0g_du0V-gM4OBhA/o.jpg"
        ],
        "rating": 4.0,
        "review_count": 81,
        "location": {
          "address1": "156 Avenue Laurier O",
          "city": "Montreal"
        },
        "price": "\$\$\$",
        "categories": [
          {
            "title": "Sushi Bars"
          },
          {
            "title": "Japanese"
          }
        ]
      },
      {
        "id": "zMfu7V8pSmRzGPGh08NvDA",
        "name": "Sushi Sama",
        "photos": [
          "https://s3-media1.fl.yelpcdn.com/bphoto/aYN_Gq4fZ-iqKmTthpDvfg/o.jpg"
        ],
        "rating": 4.5,
        "review_count": 24,
        "location": {
          "address1": "1889 Rue Beaubien E",
          "city": "Montreal"
        },
        "price": "\$\$",
        "categories": [
          {
            "title": "Sushi Bars"
          }
        ]
      },
      {
        "id": "KNjsF_1OqxHFL3TnZOG_yA",
        "name": "Sushi Inbox",
        "photos": [
          "https://s3-media4.fl.yelpcdn.com/bphoto/EvrR_aizR5_Jtbgo6aSaPQ/o.jpg"
        ],
        "rating": 4.0,
        "review_count": 30,
        "location": {
          "address1": "2045 Avenue Union",
          "city": "Montreal"
        },
        "price": "\$",
        "categories": [
          {
            "title": "Sushi Bars"
          }
        ]
      },
      {
        "id": "p41wAz-zZtps7tTh0g_oiQ",
        "name": "Kasumi",
        "photos": [
          "https://s3-media3.fl.yelpcdn.com/bphoto/Qc7BXly4wcGBYy_pgbs8tw/o.jpg"
        ],
        "rating": 4.5,
        "review_count": 18,
        "location": {
          "address1": "1429 Rue Amherst",
          "city": "Montreal"
        },
        "price": "\$\$\$",
        "categories": [
          {
            "title": "Sushi Bars"
          },
          {
            "title": "Japanese"
          }
        ]
      },
      {
        "id": "CrsbO0pzNWliL8l0Vng6zw",
        "name": "Izu Sushi",
        "photos": [
          "https://s3-media1.fl.yelpcdn.com/bphoto/mZ2jd2hoJgyYLWLemlaDog/o.jpg"
        ],
        "rating": 4.5,
        "review_count": 12,
        "location": {
          "address1": "921 Rue Rachel E",
          "city": "Montreal"
        },
        "price": "\$\$",
        "categories": [
          {
            "title": "Sushi Bars"
          }
        ]
      },
      {
        "id": "CLmTdEou9tYeUP7fuF4CIA",
        "name": "Boîte Geisha",
        "photos": [
          "https://s3-media3.fl.yelpcdn.com/bphoto/PZd2MN-FXTHxbvyypqHPwQ/o.jpg"
        ],
        "rating": 4.5,
        "review_count": 24,
        "location": {
          "address1": "1209 Mount Royal Avenue E",
          "city": "Montreal"
        },
        "price": "\$\$",
        "categories": [
          {
            "title": "Japanese"
          },
          {
            "title": "Sushi Bars"
          }
        ]
      },
      {
        "id": "chej-VaGefS8GJEeWKMN9w",
        "name": "Sushi Sama",
        "photos": [
          "https://s3-media4.fl.yelpcdn.com/bphoto/pdA9XDkRUY_vN8QqhctOdw/o.jpg"
        ],
        "rating": 4.5,
        "review_count": 14,
        "location": {
          "address1": "1303 Rue Sainte-Catherine E",
          "city": "Montreal"
        },
        "price": "\$\$",
        "categories": [
          {
            "title": "Poke"
          },
          {
            "title": "Sushi Bars"
          },
          {
            "title": "Japanese"
          }
        ]
      }
    ]
  }
}
""");

final Map<String, dynamic> _businessDetailsAndReviews = jsonDecode("""
{
  "business": {
    "id": "FI3PVYBuz5fioko7qhsPZA",
    "name": "Jun I",
    "photos": [
      "https://s3-media4.fl.yelpcdn.com/bphoto/cDgDrZ-0g_du0V-gM4OBhA/o.jpg"
    ],
    "rating": 4.0,
    "review_count": 81,
    "location": {
      "address1": "156 Avenue Laurier O",
      "city": "Montreal"
    },
    "price": "\$\$\$",
    "categories": [
      {
        "title": "Sushi Bars"
      },
      {
        "title": "Japanese"
      }
    ],
    "display_phone": "+1 514-276-5864",
    "hours": [
      {
        "open": [
          {
            "day": 0,
            "start": "1800",
            "end": "2200"
          },
          {
            "day": 1,
            "start": "1130",
            "end": "1400"
          },
          {
            "day": 1,
            "start": "1800",
            "end": "2200"
          },
          {
            "day": 2,
            "start": "1130",
            "end": "1400"
          },
          {
            "day": 2,
            "start": "1800",
            "end": "2200"
          },
          {
            "day": 3,
            "start": "1130",
            "end": "1400"
          },
          {
            "day": 3,
            "start": "1800",
            "end": "2200"
          },
          {
            "day": 4,
            "start": "1130",
            "end": "1400"
          },
          {
            "day": 4,
            "start": "1800",
            "end": "2300"
          },
          {
            "day": 5,
            "start": "1800",
            "end": "2300"
          }
        ]
      }
    ],
    "reviews": [
      {
        "user": {
          "name": "Amy Yu T.",
          "image_url": "https://s3-media4.fl.yelpcdn.com/photo/IDXRipzG6ci0kdsR8Lqa0A/o.jpg"
        },
        "text": "I can easily say that Jun-I is the best traditional sushi joint in the city.",
        "rating": 5,
        "time_created": "2020-10-18 14:40:47"
      },
      {
        "user": {
          "name": "Meg A.",
          "image_url": "https://s3-media1.fl.yelpcdn.com/photo/7440LfxTXYWIlVVA_oYLgA/o.jpg"
        },
        "text": "Everything about our evening was made special by the exquisite care Juni and his staff put into our experience and meal. One of the best pieces of advice I...",
        "rating": 5,
        "time_created": "2020-03-01 08:40:54"
      },
      {
        "user": {
          "name": "Kate G.",
          "image_url": "https://s3-media1.fl.yelpcdn.com/photo/ykG9ZfdiZGsAISFnZNQqHA/o.jpg"
        },
        "text": "My boyfriend and I wanted to go somewhere fancy when he came to visit. I asked my foodie friend and he recommended Jun I - and then a bunch of dishes,...",
        "rating": 5,
        "time_created": "2018-05-11 10:36:20"
      }
    ]
  }
}
""");
