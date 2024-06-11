import 'package:app/models/entities/promotion_entity.dart';
import 'package:app/models/services/abstract_service.dart';

class PromotionService extends AbstractService {
  Future<List<PromotionEntity>> getPromotions() async {
    await apiProvider.getPromoMaterials();
    return [
      PromotionEntity(
          'Oh hi mark! Пицца со вкусом еды! Удивительно! Новое предложение!',
          "https://upload.wikimedia.org/wikipedia/commons/a/a3/Eq_it-na_pizza-margherita_sep2005_sml.jpg"
      ),
      PromotionEntity(
          'Oh hi mark! Пицца со вкусом еды! Удивительно! Новое предложение!',
          "https://upload.wikimedia.org/wikipedia/commons/a/a3/Eq_it-na_pizza-margherita_sep2005_sml.jpg"
      ),
      PromotionEntity(
          'Oh hi mark! Пицца со вкусом еды! Удивительно! Новое предложение!',
          "https://upload.wikimedia.org/wikipedia/commons/a/a3/Eq_it-na_pizza-margherita_sep2005_sml.jpg"
      ),
      PromotionEntity(
          'Oh hi mark! Пицца со вкусом еды! Удивительно! Новое предложение!',
          "https://upload.wikimedia.org/wikipedia/commons/a/a3/Eq_it-na_pizza-margherita_sep2005_sml.jpg"
      ),
      PromotionEntity(
          'Oh hi mark! Пицца со вкусом еды! Удивительно! Новое предложение!',
          "https://upload.wikimedia.org/wikipedia/commons/a/a3/Eq_it-na_pizza-margherita_sep2005_sml.jpg"
      ),
    ];
  }
}