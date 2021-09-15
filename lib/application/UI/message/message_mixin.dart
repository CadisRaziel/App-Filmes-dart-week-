import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin MessageMixin on GetxController {
  void messageListener(Rxn<MessageModel> message) {
    ever<MessageModel?>(message, (model) {
      if (model != null) {
        Get.snackbar(
          model.title,
          model.message,
          backgroundColor: model.type.color(),
          //*Fazendo a extension, eu posso remover essse ternario abaixo e adicionar o seguinte código 'model.type.color(),'
          // (model.type == MessageType.error ? Colors.red : Colors.blue),
        );
      }
    });
  }
}

class MessageModel {
  final String title;
  final String message;
  final MessageType type;

  MessageModel({
    required this.title,
    required this.message,
    required this.type,
  });

//*Repare que ao criar o enum, eu pude colocar mais 2 construtor com a informação que coloquei no enum 'error, info'
  MessageModel.error({
    required this.title,
    required this.message,
  }) : type = MessageType.error;

  MessageModel.info({
    required this.title,
    required this.message,
  }) : type = MessageType.info;
}

enum MessageType { error, info }

//*Estension adiciona comportamento em classe existentes, pode ser nossas como classes do proprio dart
extension MessageTypeExtension on MessageType {
  //*aqui eu posso adicionar ações
  Color color() {
    switch (this) {
      case MessageType.error:
        return Colors.red[200] ?? Colors.red;
      case MessageType.info:
        return Colors.blue[200] ?? Colors.blue;
    }
  }
}

//*Sempre que usamos um Rx ele não deixa que o valor seja nullo ou vazio...
//*Para isso precisamos utilizar o 'Rxn'
// var name = Rxn<String>();