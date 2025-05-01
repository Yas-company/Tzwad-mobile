import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import '../../model/ticket_chat_model.dart';
import '../../service/common_service.dart';
import 'package:http/http.dart' as http;

import '../view/utils/constant_name.dart';

class TicketChatService with ChangeNotifier {
  List<AllMessage> messagesList = [];
  TicketDetails? ticketDetails;
  bool isLoading = false;
  String message = '';
  File? pickedImage;
  bool notifyViaMail = false;
  bool noMessage = false;
  bool msgSendingLoading = false;

  setIsLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  setMsgSendingLoading() {
    msgSendingLoading = true;
    notifyListeners();
  }

  setMessage(value) {
    message = value;
    notifyListeners();
  }

  clearAllMessages() {
    messagesList = [];
    pickedImage = null;
    notifyViaMail = false;
    noMessage = false;
    ticketDetails = null;
    notifyListeners();
  }

  setPickedImage(value) {
    pickedImage = value;
    notifyListeners();
  }

  toggleNotifyViaMail(value) {
    notifyViaMail = !notifyViaMail;
    notifyListeners();
  }

  Future fetchSingleTickets(id) async {
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      'Content-Type': 'application/json',
      "Authorization": "Bearer $globalUserToken",
    };
    // print('searching in progress');
    final url = Uri.parse('$baseApiUrl/user/ticket/$id');
    // print(url);
    try {
      final response = await http.get(url, headers: header);

      if (response.statusCode == 200) {
        var data = TicketChatModel.fromJson(jsonDecode(response.body));
        messagesList = data.allMessages.reversed.toList();
        ticketDetails = data.ticketDetails;
        noMessage = data.allMessages.isEmpty;

        // print(isLoading);
        // print(messagesList.toString() + '-------------------');
        setIsLoading(false);
        // setNoProduct(resultMeta!.total == 0);

        notifyListeners();
      } else {
        return jsonDecode(response.body)['message'];
      }
    } catch (error) {
      // print(error);

      rethrow;
    }
  }

  Future sendMessage(id) async {
    // print('sending------------------');
    final url = Uri.parse('$baseApiUrl/user/ticket/chat/send/$id');

    Map<String, String> fieldss = {
      'user_type': 'mobile',
      'message': message,
      'send_notify_mail': notifyViaMail ? 'on' : 'off',
    };

    var request = http.MultipartRequest('POST', url);

    fieldss.forEach((key, value) {
      request.fields[key] = value;
    });

    request.headers.addAll(
      {
        "Accept": "application/json",
        "Authorization": "Bearer $globalUserToken",
      },
    );

    // print(url);
    try {
      if (pickedImage != null) {
        // print(pickedImage!.path);
        var multiport = await http.MultipartFile.fromPath(
          'file',
          pickedImage!.path,
        );

        request.files.add(multiport);
      }
      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);
      // print(response.statusCode);
      if (response.statusCode == 200) {
        await fetchOnlyMessages(id);
        // var data = TicketChatModel.fromJson(jsonDecode(response.body));

        // setNoProduct(resultMeta!.total == 0);
        message = '';
        pickedImage = null;

        notifyListeners();
      } else {
        return jsonDecode(response.body);
      }
    } catch (error) {
      // print(error);

      rethrow;
    }
  }

  Future fetchOnlyMessages(id) async {
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Authorization": "Bearer $globalUserToken",
    };
    // print('searching in progress');
    final url = Uri.parse('$baseApiUrl/user/ticket/chat/$id');
    // print(url);
    try {
      final response = await http.get(url, headers: header);

      if (response.statusCode == 200) {
        List<AllMessage> data = [];
        jsonDecode(response.body).forEach((element) {
          data.add(AllMessage.fromJson(element));
        });
        messagesList = data.reversed.toList();
        setIsLoading(false);
        // setNoProduct(resultMeta!.total == 0);
        noMessage = messagesList.isEmpty;
        notifyListeners();
      } else {}
    } catch (error) {
      // print(error);

      rethrow;
    }
  }
}

// To parse this JSON data, do
//
//     final onlyMessagesModel = onlyMessagesModelFromJson(jsonString);

List<OnlyMessagesModel> onlyMessagesModelFromJson(String str) =>
    List<OnlyMessagesModel>.from(
        json.decode(str).map((x) => OnlyMessagesModel.fromJson(x)));

String onlyMessagesModelToJson(List<OnlyMessagesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnlyMessagesModel {
  OnlyMessagesModel({
    required this.id,
    required this.message,
    this.notify,
    this.attachment,
    this.type,
    required this.supportTicketId,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String message;
  Notify? notify;
  String? attachment;
  Type? type;
  int supportTicketId;
  DateTime createdAt;
  DateTime updatedAt;

  factory OnlyMessagesModel.fromJson(Map<String, dynamic> json) =>
      OnlyMessagesModel(
        id: json["id"],
        message: json["message"],
        notify: notifyValues.map[json["notify"]],
        attachment: json["attachment"],
        type: typeValues.map[json["type"]],
        supportTicketId: json["support_ticket_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "notify": notifyValues.reverse![notify],
        "attachment": attachment,
        "type": typeValues.reverse![type],
        "support_ticket_id": supportTicketId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum Notify { ON, OFF }

final notifyValues = EnumValues({"off": Notify.OFF, "on": Notify.ON});

enum Type { MOBILE, ADMIN }

final typeValues = EnumValues({"admin": Type.ADMIN, "mobile": Type.MOBILE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
