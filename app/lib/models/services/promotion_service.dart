import 'dart:convert';

import 'package:app/models/entities/promotion_entity.dart';
import 'package:app/models/providers/api_links.dart';
import 'package:app/models/services/abstract_service.dart';

class PromotionService extends AbstractService {
  Future<List<PromotionEntity>> getPromotions() async {
    final token = await storageProvider.loadToken();
    final response = await apiProvider.getPromoMaterials(token!);
    final List<PromotionEntity> promotions= [];
    for (var promoJson in jsonDecode(response.body)) {
      promotions.add(PromotionEntity(promoJson["text"], ApiLinks.baseUrl + promoJson["content"]));
    }
    return promotions;
  }
}