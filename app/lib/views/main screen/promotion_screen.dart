import 'package:app/viewmodels/promotion_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromotionScreen extends StatelessWidget {
  const PromotionScreen({super.key});
  // TODO push уведомление какое нибудь
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PromotionViewModel(),
      child: Consumer<PromotionViewModel>(
        builder: (context, viewModel, child) {
          return FutureBuilder(
            future: viewModel.fetchPromotions(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Ошибка: ${snapshot.error}'));
              }
              else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Новостей пока нет'));
              }
              else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final promotion = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.deepOrange),
                          color: Colors.deepOrange
                        ),
                        child: Column(
                          children: [
                            FadeInImage.assetNetwork(placeholder: 'lib/assets/placeholder.jpg', image: promotion.content),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(promotion.text, style: const TextStyle(fontSize: 16, color: Colors.white),),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                );
              }
            }
          );
        }
      ),
    );
  }
}
