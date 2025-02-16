import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:bonfire/bonfire.dart';

///
import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/widgets/action_button/action_button.dart';

///
import 'package:moodexample/views/settings/laboratory/game/mini_fantasy/components/human_player.dart';
import 'package:moodexample/views/settings/laboratory/game/mini_fantasy/components/light.dart';
import 'package:moodexample/views/settings/laboratory/game/mini_fantasy/components/orc.dart';

class MiniFantasyPage extends StatefulWidget {
  const MiniFantasyPage({super.key});

  @override
  State<MiniFantasyPage> createState() => _MiniFantasyPageState();
}

class _MiniFantasyPageState extends State<MiniFantasyPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF6F8FA),
          foregroundColor: Colors.black87,
          shadowColor: Colors.transparent,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
          title: const Text("MiniFantasy"),
          leading: ActionButton(
            decoration: BoxDecoration(
                color: AppTheme.backgroundColor1,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(18.w))),
            child: Icon(
              Remix.arrow_left_line,
              size: 24.sp,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: const SafeArea(
          child: Game(),
        ),
      ),
    );
  }
}

class Game extends StatelessWidget {
  const Game({super.key});
  static const assetsPath = 'game/mini_fantasy';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final tileSize = max(constraints.maxHeight, constraints.maxWidth) / 20;
      return BonfireTiledWidget(
        constructionMode: false,
        showCollisionArea: false,
        joystick: Joystick(
          keyboardConfig: KeyboardConfig(
            acceptedKeys: [
              LogicalKeyboardKey.space,
            ],
          ),
          directional: JoystickDirectional(),
          actions: [
            JoystickAction(
              actionId: 1,
              color: Colors.deepOrange,
              margin: const EdgeInsets.all(65),
            )
          ],
        ), // required
        map: TiledWorldMap(
          '$assetsPath/tiles/map.json',
          forceTileSize: Size(tileSize, tileSize),
          objectsBuilder: {
            'light': (properties) => Light(
                  properties.position,
                  properties.size,
                ),
            'orc': (properties) => Orc(properties.position),
          },
        ),
        player: HumanPlayer(Vector2(4 * tileSize, 4 * tileSize)),
        lightingColorGame: Colors.black.withOpacity(0.7),
        progress: Container(
          color: Colors.black,
          child: const Center(
            child: Text(
              '载入中...',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        overlayBuilderMap: {
          'miniMap': (context, game) => MiniMap(
                game: game,
                margin: const EdgeInsets.all(20),
                borderRadius: BorderRadius.circular(100),
                size: Vector2.all(constraints.maxHeight / 5),
                border: Border.all(color: Colors.white.withOpacity(0.5)),
                playerColor: Colors.green,
                enemyColor: Colors.red,
                npcColor: Colors.red,
              ),
        },
        initialActiveOverlays: const [
          'miniMap',
        ],
      );
    });
  }
}
