// To parse this JSON data, do
//
//     final ticketDetailsModel = ticketDetailsModelFromJson(jsonString);

import 'dart:convert';

TicketChatModel ticketDetailsModelFromJson(String str) =>
    TicketChatModel.fromJson(json.decode(str));

String ticketDetailsModelToJson(TicketChatModel data) =>
    json.encode(data.toJson());

class TicketChatModel {
  TicketChatModel({
    required this.ticketDetails,
    required this.allMessages,
  });

  TicketDetails ticketDetails;
  List<AllMessage> allMessages;

  factory TicketChatModel.fromJson(Map<String, dynamic> json) =>
      TicketChatModel(
        ticketDetails: TicketDetails.fromJson(json["ticket_details"]),
        allMessages: List<AllMessage>.from(
            json["all_messages"].map((x) => AllMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ticket_details": ticketDetails.toJson(),
        "all_messages": List<dynamic>.from(allMessages.map((x) => x.toJson())),
      };
}

class AllMessage {
  AllMessage({
    required this.id,
    required this.message,
    required this.notify,
    this.attachment,
    required this.type,
    required this.supportTicketId,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String message;
  String notify;
  dynamic attachment;
  String type;
  int supportTicketId;
  DateTime createdAt;
  DateTime updatedAt;

  factory AllMessage.fromJson(Map<String, dynamic> json) => AllMessage(
        id: json["id"],
        message: json["message"],
        notify: json["notify"],
        attachment: json["attachment"],
        type: json["type"],
        supportTicketId: json["support_ticket_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "notify": notify,
        "attachment": attachment,
        "type": type,
        "support_ticket_id": supportTicketId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class TicketDetails {
  TicketDetails({
    required this.id,
    required this.title,
    this.via,
    this.operatingSystem,
    required this.userAgent,
    required this.description,
    required this.subject,
    required this.status,
    required this.priority,
    required this.departments,
    required this.userId,
    this.adminId,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String title;
  String? via;
  dynamic operatingSystem;
  String userAgent;
  String description;
  String subject;
  String status;
  String priority;
  int departments;
  int userId;
  dynamic adminId;
  DateTime createdAt;
  DateTime updatedAt;

  factory TicketDetails.fromJson(Map<String, dynamic> json) => TicketDetails(
        id: json["id"],
        title: json["title"],
        via: json["via"],
        operatingSystem: json["operating_system"],
        userAgent: json["user_agent"],
        description: json["description"],
        subject: json["subject"],
        status: json["status"],
        priority: json["priority"],
        departments: json["departments"],
        userId: json["user_id"],
        adminId: json["admin_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "via": via,
        "operating_system": operatingSystem,
        "user_agent": userAgent,
        "description": description,
        "subject": subject,
        "status": status,
        "priority": priority,
        "departments": departments,
        "user_id": userId,
        "admin_id": adminId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
