import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_service/features/message_flow/model/conversation_model.dart';
import 'package:product_service/log/app_log.dart';
import 'package:product_service/services/api/api_service.dart';
import 'package:product_service/services/socket_service.dart';
import 'package:product_service/services/storage/storage_service.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';
import 'package:product_service/utils/helpers/media_permission_helper.dart';

class ConversationController extends GetxController {
  final RxList<Message> messages = <Message>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadMoreLoading = false.obs;
  RxBool hasMore = true.obs;

  final TextEditingController textController = TextEditingController();
  final Rxn<File> selectedImage = Rxn<File>();

  int page = 1;
  int limit = 20;
  int totalPage = 1;
  String? chatId;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments is Map) {
        final args = Get.arguments as Map<String, dynamic>;
        chatId = args['chatId'];
      } else if (Get.arguments is String) {
        chatId = Get.arguments;
      }
    }
    if (chatId != null && chatId!.isNotEmpty) {
      getConversation(chatId!);
      _setupSocketListeners();
    }
    scrollController.addListener(_scrollListener);
    super.onInit();
  }

  @override
  void onClose() {
    _removeSocketListeners();
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    textController.dispose();
    super.onClose();
  }

  void _setupSocketListeners() {
    final userId = LocalStorage.userId;

    void handleSocketMessage(dynamic data) {
      AppLogger.info(data, title: "Socket New Message Received");
      try {
        final rawData = data is String ? jsonDecode(data) : data;
        if (rawData is Map<String, dynamic>) {
          final msgJson = rawData['data'] ?? rawData['message'] ?? rawData;
          if (msgJson is Map<String, dynamic>) {
            final incomingMessage = Message.fromJson(msgJson);

            final isAlreadyAdded = messages.any((m) =>
                (m.id.isNotEmpty && m.id == incomingMessage.id) ||
                (m.text.isNotEmpty &&
                    m.text == incomingMessage.text &&
                    m.createdAt
                            .difference(incomingMessage.createdAt)
                            .abs()
                            .inSeconds <
                        5));

            if (!isAlreadyAdded) {
              messages.insert(0, incomingMessage);
              messages.refresh();
            }
          }
        }
      } catch (e) {
        appLog("Error handling socket message: $e");
      }
    }

    if (userId.isNotEmpty) {
      SocketService.instance.onEvent("newMessage::$userId", handleSocketMessage);
    }
    if (chatId != null && chatId!.isNotEmpty) {
      SocketService.instance.onEvent("newMessage::$chatId", handleSocketMessage);
    }
    SocketService.instance.onEvent("newMessage", handleSocketMessage);
  }

  void _removeSocketListeners() {
    final userId = LocalStorage.userId;
    if (userId.isNotEmpty) {
      SocketService.instance.offEvent("newMessage::$userId");
    }
    if (chatId != null && chatId!.isNotEmpty) {
      SocketService.instance.offEvent("newMessage::$chatId");
    }
    SocketService.instance.offEvent("newMessage");
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMoreConversation();
    }
  }

  Future<void> pickImage(BuildContext context) async {
    final file = await MediaPermissionHelper.showImageSourceBottomSheet(context);
    if (file != null) {
      selectedImage.value = file;
    }
  }

  void removeSelectedImage() {
    selectedImage.value = null;
  }

  RxBool isSending = false.obs;

  Future<void> sendMessage() async {
    final messageText = textController.text.trim();
    final imageFile = selectedImage.value;

    if (chatId == null ||
        chatId!.isEmpty ||
        (messageText.isEmpty && imageFile == null) ||
        isSending.value) {
      return;
    }

    try {
      isSending.value = true;

      Map<String, dynamic> bodyData = {
        "data": {"text": messageText}
      };

      Map<String, File?> files = {};
      if (imageFile != null) {
        files["image"] = imageFile;
      }

      final response = await ApiService.multipartRequest(
        "${ApiEndPoint.sendMessage}/$chatId",
        bodyData: bodyData,
        files: files,
      );

      if (response.isSuccess) {
        textController.clear();
        selectedImage.value = null;

        try {
          final resData = response.data as Map<String, dynamic>;
          Message? createdMessage;

          if (resData["data"] != null && resData["data"] is Map<String, dynamic>) {
            final dataMap = resData["data"] as Map<String, dynamic>;
            final msgObj = dataMap["message"] ?? dataMap;
            if (msgObj is Map<String, dynamic> && msgObj["_id"] != null) {
              createdMessage = Message.fromJson(msgObj);
            }
          }

          createdMessage ??= Message(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            chatId: chatId!,
            sender: Sender(
              id: LocalStorage.userId,
              name: "",
              role: "",
              activeRole: "",
              email: "",
              profileImage: "",
            ),
            text: messageText,
            image: imageFile != null ? imageFile.path : "",
            read: true,
            type: imageFile != null ? "image" : "text",
            isDeleted: false,
            isPinned: false,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          messages.insert(0, createdMessage);
        } catch (e) {
          appLog(e.toString());
        }
      }
    } catch (e) {
      appLog(e.toString());
    } finally {
      isSending.value = false;
    }
  }

  Future<void> getConversation(String cId, {bool isRefresh = false}) async {
    if (isRefresh) {
      page = 1;
      hasMore.value = true;
    }

    try {
      if (isRefresh || messages.isEmpty) {
        isLoading.value = true;
      }
      final response = await ApiService.get(
        "${ApiEndPoint.message}/$cId?page=$page&limit=$limit",
      );
      if (response.isSuccess) {
        final conversationModel = ConversationModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        totalPage = conversationModel.meta.totalPage;

        if (page == 1) {
          messages.assignAll(conversationModel.data.messages);
        } else {
          messages.addAll(conversationModel.data.messages);
        }

        hasMore.value = page < totalPage;
      }
    } catch (e) {
      appLog(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreConversation() async {
    if (isLoadMoreLoading.value ||
        isLoading.value ||
        !hasMore.value ||
        chatId == null ||
        chatId!.isEmpty) {
      return;
    }

    try {
      isLoadMoreLoading.value = true;
      page++;

      final response = await ApiService.get(
        "${ApiEndPoint.message}/$chatId?page=$page&limit=$limit",
      );
      if (response.isSuccess) {
        final conversationModel = ConversationModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        totalPage = conversationModel.meta.totalPage;

        messages.addAll(conversationModel.data.messages);
        hasMore.value = page < totalPage;
      } else {
        page--;
      }
    } catch (e) {
      page--;
      appLog(e.toString());
    } finally {
      isLoadMoreLoading.value = false;
    }
  }
}

