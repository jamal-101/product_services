import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_service/config/route/app_route.dart';
import 'package:product_service/features/message_flow/model/chat_model.dart';
import 'package:product_service/log/app_log.dart';
import 'package:product_service/services/api/api_service.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';

class MessageController extends GetxController {
  void goToConversation(String shopName) {
    Get.toNamed(AppRoutes.conversationScreen, arguments: shopName);
  }

  final Rxn<ChatModel?> chatList = Rxn<ChatModel?>();
  final RxList<Chat> chats = <Chat>[].obs;

  RxBool messageListLoading = false.obs;
  RxBool isLoadMoreLoading = false.obs;
  RxBool hasMore = true.obs;

  int page = 1;
  int limit = 20;
  int totalPage = 1;
  String? searchTerms;
  Timer? _searchDebounce;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    getChatList();
    scrollController.addListener(_scrollListener);
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    _searchDebounce?.cancel();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMoreChats();
    }
  }

  void onSearchChanged(String query) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      searchTerms = query.trim();
      getChatList(isRefresh: true);
    });
  }

  Future<void> getChatList({bool isRefresh = false}) async {
    if (isRefresh) {
      page = 1;
      hasMore.value = true;
    }

    try {
      if (isRefresh || chats.isEmpty) {
        messageListLoading.value = true;
      }

      String url = "${ApiEndPoint.chats}?page=$page&limit=$limit";
      if (searchTerms != null && searchTerms!.isNotEmpty) {
        url += "&searchTerm=${Uri.encodeComponent(searchTerms!)}";
      }

      final response = await ApiService.get(url);
      if (response.isSuccess) {
        final chatModel = ChatModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        chatList.value = chatModel;
        totalPage = chatModel.meta.totalPage;

        if (page == 1) {
          chats.assignAll(chatModel.data.chats);
        } else {
          chats.addAll(chatModel.data.chats);
        }

        hasMore.value = page < totalPage;
      }
    } catch (e) {
      appLog(e.toString());
    } finally {
      messageListLoading.value = false;
    }
  }

  Future<void> loadMoreChats() async {
    if (isLoadMoreLoading.value || messageListLoading.value || !hasMore.value) {
      return;
    }

    try {
      isLoadMoreLoading.value = true;
      page++;

      String url = "${ApiEndPoint.chats}?page=$page&limit=$limit";
      if (searchTerms != null && searchTerms!.isNotEmpty) {
        url += "&searchTerm=${Uri.encodeComponent(searchTerms!)}";
      }

      final response = await ApiService.get(url);
      if (response.isSuccess) {
        final chatModel = ChatModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        chatList.value = chatModel;
        totalPage = chatModel.meta.totalPage;

        chats.addAll(chatModel.data.chats);
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

  Future<void> createChat({
    required String participantId,
    required String communicationType,
    required String referenceId,
    required String shopName,
  }) async {
    try {
      final body = {
        "participant": participantId,
        "communicationType": communicationType,
        "referenceId": referenceId,
      };

      final response = await ApiService.post(
        "${ApiEndPoint.chats}/create-chat",
        body: body,
      );

      if (response.isSuccess) {
        String? chatId;
        if (response.data != null && response.data['data'] != null) {
          chatId = response.data['data']['_id'];
        }

        if (chatId != null) {
          Get.toNamed(
            AppRoutes.conversationScreen,
            arguments: {'chatId': chatId, 'shopName': shopName},
          );
        }
      } else {
        Get.snackbar(
          "Error",
          response.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      appLog("Create chat error: $e");
    }
  }
}
