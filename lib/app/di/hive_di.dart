import 'package:hive/hive.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/model/cart_local_model.dart';
import 'package:new_sai/presentation/pages/product_pages/product_search/model/last_search_local_model.dart';
import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/room_song_model.dart';
import 'package:path_provider/path_provider.dart';

initHive() async {
  final dir = await getApplicationDocumentsDirectory();
  Hive
    ..init(dir.path)
    ..registerAdapter<RoomSongModel>(RoomSongModelAdapter())
    ..registerAdapter(CartLocalModelAdapter())
    ..registerAdapter(LastSearchLocalModelAdapter());
  await Hive.openBox<RoomSongModel>("RoomSongModel");
  await Hive.openBox<CartLocalModel>("CartLocalModel");
  await Hive.openBox<LastSearchLocalModel>("LastSearchLocalModel");
}
