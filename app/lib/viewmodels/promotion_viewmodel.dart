import 'package:app/models/entities/promotion_entity.dart';
import 'package:app/models/services/promotion_service.dart';
import 'package:app/viewmodels/abstract_viewmodel.dart';
import 'package:flutter/foundation.dart';

class PromotionViewModel extends AbstractViewModel with ChangeNotifier {
  @override
  final PromotionService service = PromotionService();

  Future<List<PromotionEntity>> fetchPromotions() async {
    return await service.getPromotions();
  }
}