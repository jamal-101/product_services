
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

/// Low-level socket wrapper (no GetX / no business logic)
class SocketService {
  SocketService._privateConstructor();
  static final SocketService _instance = SocketService._privateConstructor();
  static SocketService get instance => _instance;

  IO.Socket? _socket;
  Function? _onConnectedCallback;

  bool get isConnected => _socket?.connected ?? false;
  bool get isInitialized => _socket != null;

  /// Initialize socket and connect immediately
  /// Token is injected directly into the URL
  void initAndConnect({
    required String url,
    required String token,
    Function? onConnected,
  }) {
    if (_socket != null) {
      AppLogger.info('🔄 Disposing existing socket before reconnecting');
      dispose();
    }

    _onConnectedCallback = onConnected;

    // URL er moddhe token pass kora hochche (jemon: ws://api.url.com?token=abc)
    final connectionUrl = url.contains('?') ? '$url&token=$token' : '$url?token=$token';

    AppLogger.info('🔧 Initializing & Connecting Socket → $connectionUrl');

    _socket = IO.io(
      connectionUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // We connect manually right after initialization
          .enableForceNew()
          .setQuery({'token': token}) // Safe query parameter approach
          .setAuth({'token': token})  // Fallback for newer socket.io versions
          .build(),
    );

    _registerDefaultListeners();

    // Call instantly to connect
    connect();
  }

  void _registerDefaultListeners() {
    _socket?.onConnect((_) {
      AppLogger.info('🟢 Socket CONNECTED');
      _onConnectedCallback?.call();
    });

    _socket?.onDisconnect((_) {
      AppLogger.info('🔴 Socket DISCONNECTED');
    });

    _socket?.onConnectError((error) {
      AppLogger.error(error, title: '🔥 Socket CONNECT ERROR');
    });

    _socket?.onError((error) {
      AppLogger.error(error, title: '⚠️ Socket ERROR');
    });
  }

  void connect() {
    if (_socket == null) {
      AppLogger.error('Socket not initialized', title: 'Connect Failed');
      return;
    }

    if (_socket!.connected) {
      AppLogger.info('⚠️ Socket already connected');
      return;
    }

    AppLogger.info('🔌 Connecting socket...');
    _socket!.connect();
  }

  void disconnect() {
    if (_socket == null) return;

    AppLogger.info('🔌 Disconnecting socket...');
    _socket!.disconnect();
  }

  /// Listen event (replaces previous listener for same event)
  void onEvent(String eventName, Function(dynamic data) callback) {
    if (_socket == null) return;

    _socket!.off(eventName);
    AppLogger.info('👂 Listening event → $eventName');

    _socket!.on(eventName, (data) {
      AppLogger.info(data, title: 'Socket Event → $eventName'); // Changed to info based on standard logger, update if api() exists
      callback(data);
    });
  }

  /// Remove specific event listener
  void offEvent(String eventName) {
    if (_socket == null) return;
    AppLogger.info('🔇 Off event → $eventName');
    _socket!.off(eventName);
  }

  void emit(String eventName, dynamic data) {
    if (_socket == null || !_socket!.connected) {
      AppLogger.error('Socket not connected', title: 'Emit Failed');
      return;
    }

    AppLogger.info(data, title: '📤 Emit → $eventName'); // Changed to info based on standard logger
    _socket!.emit(eventName, data);
  }

  void dispose() {
    if (_socket == null) return;

    AppLogger.info('🧹 Disposing socket');
    _socket!
      ..offAny()
      ..disconnect()
      ..dispose();

    _socket = null;
    _onConnectedCallback = null;
  }
}



/// A globally accessible Custom Logger with an in-app Bottom Sheet Viewer
class AppLogger {
  AppLogger._privateConstructor();

  // In-memory storage for recent logs
  static final List<String> _sessionLogs = [];
  static const int _maxLogLimit = 100; // Prevents memory leak

  /// 🔵 Info Log
  static void info(dynamic message, {String title = 'INFO'}) {
    _processLog('\x1B[34m', title, message, Icons.info_outline, Colors.blue);
  }

  /// 🔴 Error Log
  static void error(dynamic message, {String title = 'ERROR'}) {
    _processLog('\x1B[31m', title, message, Icons.error_outline, Colors.red);
  }

  /// 🟢 Success Log
  static void success(dynamic message, {String title = 'SUCCESS'}) {
    _processLog('\x1B[32m', title, message, Icons.check_circle_outline, Colors.green);
  }

  /// 🟠 API / Network Log
  static void api(dynamic message, {String title = 'API'}) {
    _processLog('\x1B[33m', title, message, Icons.api, Colors.orange);
  }

  static void _processLog(String ansiColor, String title, dynamic message, IconData icon, Color uiColor) {
    final timestamp = DateTime.now().toString().split('.').first;
    final formattedMessage = '[$timestamp] [$title] $message';

    // 1. Print to console with ANSI colors
    developer.log('$ansiColor$formattedMessage\x1B[0m', name: 'AppLogger');

    // 2. Save to memory for the bottom sheet
    if (_sessionLogs.length >= _maxLogLimit) {
      _sessionLogs.removeLast(); // Remove oldest log
    }
    _sessionLogs.insert(0, formattedMessage); // Add newest at top
  }

  /// Shows the recent logs in a Modal Bottom Sheet
  static void showBottom(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1C1C1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "App Logs",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(color: Colors.grey),
                Expanded(
                  child: _sessionLogs.isEmpty
                      ? const Center(child: Text("No logs available", style: TextStyle(color: Colors.grey)))
                      : ListView.builder(
                          controller: scrollController,
                          itemCount: _sessionLogs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                _sessionLogs[index],
                                style: const TextStyle(color: Colors.greenAccent, fontFamily: 'monospace', fontSize: 12),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}