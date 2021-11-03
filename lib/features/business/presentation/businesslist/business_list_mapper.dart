import 'package:collection/collection.dart';
import 'package:yelpexplorer/features/business/domain/model/business.dart';
import 'package:yelpexplorer/features/business/presentation/businesslist/business_list_ui_model.dart';
import 'package:yelpexplorer/features/business/presentation/helper/business_helper.dart' as BusinessHelper;

extension BusinessListUiMapper on List<Business> {
  List<BusinessListUiModel> toUiModels() {
    return mapIndexed(
      (index, business) => BusinessListUiModel(
        id: business.id,
        name: "${index + 1}. ${business.name.toUpperCase()}",
        photoUrl: business.photoUrl,
        ratingImage: BusinessHelper.getRatingImage(business.rating),
        reviewCount: "${business.reviewCount} reviews", // TODO i18n
        address: business.address,
        priceAndCategories: BusinessHelper.formatPriceAndCategories(business.price, business.categories),
      ),
    ).toList();
  }
}
