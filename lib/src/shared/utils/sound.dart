import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class Sound {
  Sound._();

  static bool enabled = true;
  static double volume = 1.0;

  static final List<AudioPlayer> _pool = List.generate(
    3,
    (_) => AudioPlayer()
      ..setPlayerMode(PlayerMode.lowLatency)
      ..setReleaseMode(ReleaseMode.stop),
  );
  static int _i = 0;

  static AudioPlayer _next() {
    final p = _pool[_i];
    _i = (_i + 1) % _pool.length;
    return p;
  }

  static Future<void> _play(String assetPath) async {
    if (!enabled) return;
    final p = _next();
    try {
      await p.stop();
      await p.setVolume(volume);
      await p.play(AssetSource(assetPath));
    } catch (_) {}
  }

  static Future<void> click() => _play('sounds/ui/ui_click.mp3');

  static Future<void> clickAlt1() => _play('sounds/ui/ui_click_alt_1.mp3');
  static Future<void> clickAlt2() => _play('sounds/ui/ui_click_alt_2.mp3');
  static Future<void> clickAlt3() => _play('sounds/ui/ui_click_alt_3.mp3');
  static Future<void> clickAlt4() => _play('sounds/ui/ui_click_alt_4.mp3');

  static Future<void> fart1() => _play('sounds/fart/fart1.wav');
  static Future<void> fart2() => _play('sounds/fart/fart2.wav');
  static Future<void> fart3() => _play('sounds/fart/fart3.wav');
  static Future<void> fart4() => _play('sounds/fart/fart4.wav');
  static Future<void> fart5() => _play('sounds/fart/fart5.wav');

  static Future<void> laugh() => _play(
    'sounds/laugh/laugh.mp3',
  );

  static Future<void> tactileClick() async {
    HapticFeedback.selectionClick();
    try {
      await SystemSound.play(SystemSoundType.click);
    } catch (_) {}
    await click();
  }

  static Future<void> dispose() async {
    for (final p in _pool) {
      await p.dispose();
    }
  }
}
