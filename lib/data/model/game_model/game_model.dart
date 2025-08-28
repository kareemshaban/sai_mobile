import 'package:get/get_rx/src/rx_types/rx_types.dart';

class GameResponse {
  final Config config;
  final List<Game> gameList;

  GameResponse({
    required this.config,
    required this.gameList,
  });

  factory GameResponse.fromJson(Map<String, dynamic> json) {
    return GameResponse(
      config: Config.fromJson(json['config']),
      gameList:
          (json['game_list'] as List).map((e) => Game.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'config': config.toJson(),
      'game_list': gameList.map((game) => game.toJson()).toList(),
    };
  }
}

class Config {
  final String appChannel;
  final String appId;
  final String userId;
  final String code;
  final int roomId;
  final int gameMode;
  final int language;
  final GameConfig gameConfig;
  final int gsp;

  Config({
    required this.appChannel,
    required this.appId,
    required this.userId,
    required this.code,
    required this.roomId,
    required this.gameMode,
    required this.language,
    required this.gameConfig,
    required this.gsp,
  });

  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      appChannel: json['appChannel'],
      appId: json['appId'],
      userId: json['userId'],
      code: json['code'],
      roomId: json['roomId'],
      gameMode: json['gameMode'],
      language: json['language'],
      gameConfig: GameConfig.fromJson(json['gameConfig']),
      gsp: json['gsp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'appChannel': appChannel,
      'appId': appId,
      'userId': userId,
      'code': code,
      'roomId': roomId,
      'gameMode': gameMode,
      'language': language,
      'gameConfig': gameConfig.toJson(),
      'gsp': gsp,
    };
  }
}

class GameConfig {
  final int sceneMode;
  final String currencyIcon;

  GameConfig({
    required this.sceneMode,
    required this.currencyIcon,
  });

  factory GameConfig.fromJson(Map<String, dynamic> json) {
    return GameConfig(
      sceneMode: json['sceneMode'],
      currencyIcon: json['currencyIcon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sceneMode': sceneMode,
      'currencyIcon': currencyIcon,
    };
  }
}

class Game {
  final int id;
  final String name;
  final String icon;
  final String url;
  final int active;

  Game({
    required this.id,
    required this.name,
    required this.icon,
    required this.url,
    required this.active,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      url: json['url'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'url': url,
      'active': active,
    };
  }
}

class GameItem {
  final Game game;
  RxBool isActive;

  GameItem({required this.game}) : isActive = (game.active == 1).obs;
}
