import 'dart:convert';

class ChatModel {
  bool success;
  String message;
  Data data;
  Meta meta;

  ChatModel({
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory ChatModel.fromRawJson(String str) =>
      ChatModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
    "meta": meta.toJson(),
  };
}

class Data {
  List<Chat> chats;
  int unreadChatsCount;
  int totalUnreadMessages;

  Data({
    required this.chats,
    required this.unreadChatsCount,
    required this.totalUnreadMessages,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
    unreadChatsCount: json["unreadChatsCount"],
    totalUnreadMessages: json["totalUnreadMessages"],
  );

  Map<String, dynamic> toJson() => {
    "chats": List<dynamic>.from(chats.map((x) => x.toJson())),
    "unreadChatsCount": unreadChatsCount,
    "totalUnreadMessages": totalUnreadMessages,
  };
}

class Chat {
  String id;
  List<Participant> participants;
  LastMessage? lastMessage;
  bool read;
  List<String> readBy;
  List<dynamic> deletedBy;
  bool isDeleted;
  String status;
  List<dynamic> pinnedMessages;
  String communicationType;
  String referenceId;
  DateTime createdAt;
  DateTime updatedAt;
  bool isRead;
  int unreadCount;

  Chat({
    required this.id,
    required this.participants,
    this.lastMessage,
    required this.read,
    required this.readBy,
    required this.deletedBy,
    required this.isDeleted,
    required this.status,
    required this.pinnedMessages,
    required this.communicationType,
    required this.referenceId,
    required this.createdAt,
    required this.updatedAt,
    required this.isRead,
    required this.unreadCount,
  });

  factory Chat.fromRawJson(String str) => Chat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["_id"] ?? "",


    participants: json["participants"] != null
        ? List<Participant>.from(
      json["participants"].map((x) => Participant.fromJson(x)),
    )
        : [],

    lastMessage: json["lastMessage"] != null
        ? LastMessage.fromJson(json["lastMessage"])
        : null,

    read: json["read"] ?? false,
    readBy: List<String>.from(json["readBy"].map((x) => x)),
    deletedBy: List<dynamic>.from(json["deletedBy"].map((x) => x)),
    isDeleted: json["isDeleted"] ?? false,
    status: json["status"] ?? "",
    pinnedMessages: List<dynamic>.from(json["pinnedMessages"].map((x) => x)),
    communicationType: json["communicationType"] ?? "",
    referenceId: json["referenceId"] ?? "",
    createdAt: DateTime.parse(json["createdAt"] ?? ""),
    updatedAt: DateTime.parse(json["updatedAt"] ?? ""),
    isRead: json["isRead"] ?? false,
    unreadCount: json["unreadCount"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
    // "lastMessage": lastMessage.toJson(),
    "lastMessage": lastMessage?.toJson(),
    "read": read,
    "readBy": List<dynamic>.from(readBy.map((x) => x)),
    "deletedBy": List<dynamic>.from(deletedBy.map((x) => x)),
    "isDeleted": isDeleted,
    "status": status,
    "pinnedMessages": List<dynamic>.from(pinnedMessages.map((x) => x)),
    "communicationType": communicationType,
    "referenceId": referenceId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "isRead": isRead,
    "unreadCount": unreadCount,
  };
}

class LastMessage {
  String id;
  String chatId;
  String sender;
  String text;
  String image;
  bool read;
  String type;
  bool isDeleted;
  bool isPinned;
  DateTime createdAt;
  DateTime updatedAt;

  LastMessage({
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

  factory LastMessage.fromRawJson(String str) =>
      LastMessage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    id: json["_id"] ?? "",
    chatId: json["chatId"] ?? "",
    sender: json["sender"] ?? "",
    text: json["text"] ?? "",
    image: json["image"] ?? "",
    read: json["read"] ?? false,
    type: json["type"] ?? "",
    isDeleted: json["isDeleted"] ?? false,
    isPinned: json["isPinned"] ?? false,
    createdAt: DateTime.parse(json["createdAt"] ?? ""),
    updatedAt: DateTime.parse(json["updatedAt"] ?? ""),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "chatId": chatId,
    "sender": sender,
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

class Participant {
  String id;
  String name;
  String role;
  String activeRole;
  String email;
  String profileImage;

  Participant({
    required this.id,
    required this.name,
    required this.role,
    required this.activeRole,
    required this.email,
    required this.profileImage,
  });

  factory Participant.fromRawJson(String str) =>
      Participant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
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
