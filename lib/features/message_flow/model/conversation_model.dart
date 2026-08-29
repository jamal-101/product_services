
import 'dart:convert';

class ConversationModel {
    bool success;
    String message;
    ConversationDataModel data;
    Meta meta;

    ConversationModel({
        required this.success,
        required this.message,
        required this.data,
        required this.meta,
    });

    factory ConversationModel.fromRawJson(String str) => ConversationModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
        success: json["success"],
        message: json["message"],
        data: ConversationDataModel.fromJson(json["data"]),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
        "meta": meta.toJson(),
    };
}

class ConversationDataModel {
    List<Message> messages;
    List<dynamic> pinnedMessages;

    ConversationDataModel({
        required this.messages,
        required this.pinnedMessages,
    });

    factory ConversationDataModel.fromRawJson(String str) => ConversationDataModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ConversationDataModel.fromJson(Map<String, dynamic> json) => ConversationDataModel(
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
        pinnedMessages: List<dynamic>.from(json["pinnedMessages"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "pinnedMessages": List<dynamic>.from(pinnedMessages.map((x) => x)),
    };
}

class Message {
    String id;
    String chatId;
    Sender sender;
    String text;
    String image;
    bool read;
    String type;
    bool isDeleted;
    bool isPinned;
    DateTime createdAt;
    DateTime updatedAt;

    Message({
        required this.id,
        required this.chatId,
        required this.sender,
        required this.text,
        required this.image,
        required this.read,
        required this.type,
        required this.isDeleted,
        required this.isPinned,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"] ?? "",
        chatId: json["chatId"] ?? "",
        sender: json["sender"] is Map<String, dynamic>
            ? Sender.fromJson(json["sender"])
            : Sender(
                id: json["sender"] is String ? json["sender"] : "",
                name: "",
                role: "",
                activeRole: "",
                email: "",
                profileImage: "",
              ),
        text: json["text"] ?? "",
        image: json["image"] ?? "",
        read: json["read"] ?? false,
        type: json["type"] ?? "",
        isDeleted: json["isDeleted"] ?? false,
        isPinned: json["isPinned"] ?? false,
        createdAt: json["createdAt"] != null
            ? (DateTime.tryParse(json["createdAt"].toString()) ?? DateTime.now())
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? (DateTime.tryParse(json["updatedAt"].toString()) ?? DateTime.now())
            : DateTime.now(),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "chatId": chatId,
        "sender": sender.toJson(),
        "text": text,
        "image": image,
        "read": read,
        "type": type,
        "isDeleted": isDeleted,
        "isPinned": isPinned,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Sender {
    String id;
    String name;
    String role;
    String activeRole;
    String email;
    String profileImage;

    Sender({
        required this.id,
        required this.name,
        required this.role,
        required this.activeRole,
        required this.email,
        required this.profileImage,
    });

    factory Sender.fromRawJson(String str) => Sender.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        role: json["role"] ?? "",
        activeRole: json["activeRole"] ?? "",
        email: json["email"] ?? "",
        profileImage: json["profileImage"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "role": role,
        "activeRole": activeRole,
        "email": email,
        "profileImage": profileImage,
    };
}

class Meta {
    int limit;
    int page;
    int total;
    int totalPage;

    Meta({
        required this.limit,
        required this.page,
        required this.total,
        required this.totalPage,
    });

    factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        limit: json["limit"],
        page: json["page"],
        total: json["total"],
        totalPage: json["totalPage"],
    );

    Map<String, dynamic> toJson() => {
        "limit": limit,
        "page": page,
        "total": total,
        "totalPage": totalPage,
    };
}
