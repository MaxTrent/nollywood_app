import 'package:flutter/widgets.dart';
import 'package:pmvvm/pmvvm.dart';
import "package:flutter/material.dart";

class ProducerRateAndReviewViewmodel extends ViewModel {
  bool isButtonActive = false;
  late TextEditingController ProducerActorReviewController;
 
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  

  void init() {
    super.init();
    ProducerActorReviewController = TextEditingController();
    
    ProducerActorReviewController.addListener(() {
      final newIsButtonActive = ProducerActorReviewController.text.isNotEmpty;
      if (isButtonActive != newIsButtonActive) {
        isButtonActive = newIsButtonActive;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    ProducerActorReviewController.dispose();
    super.dispose();
    notifyListeners();
  }

  


  
}
