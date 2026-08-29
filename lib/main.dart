import 'package:flutter/cupertino.dart';
import 'package:product_service/services/socket_service.dart';
import 'package:product_service/services/storage/storage_service.dart';
import 'package:product_service/utils/constants/api_enpoint.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.getAllPrefData();
  if (LocalStorage.token.isNotEmpty) {
    SocketService.instance.initAndConnect(
      url: ApiEndPoint.imageUrl,
      token: LocalStorage.token,
    );
  }
  runApp(const MyApp());
}