import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart'; // HapticFeedback, SystemSound

// 全域音效工具： anywhere 直接叫 Sound.click() / Sound.success()
class Sound {
  Sound._(); // 不允許被 new
  // ===== 全域靜態方法 =====
  static bool enabled = true;// 音效開關：可在設定頁切換
  static double volume = 1.0;// 全域音量（0.0 ~ 1.0）

  // 播放器池：預設使用 3 個播放器，低延遲模式，播放完後停止，避免快速連點被截斷
  static final List<AudioPlayer> _pool = List.generate(
    3,
    (_) =>
        AudioPlayer()
          ..setPlayerMode(PlayerMode.lowLatency)  // 低延遲模式
          ..setReleaseMode(ReleaseMode.stop), // 播放完後停止
  ); 
  static int _i = 0;  // 當前使用的播放器索引

  // 內部：獲取下一個播放器，循環使用池中的播放器
  static AudioPlayer _next() {
    final p = _pool[_i];
    _i = (_i + 1) % _pool.length;
    return p;
  }

  // 內部：播放音效，確保每次從頭開始
  static Future<void> _play(String assetPath) async {
    if (!enabled) return; // 如果音效關閉，直接返回
    final p = _next();  // 獲取下一個播放器
    try {
      await p.stop(); // 確保每次從頭播
      await p.setVolume(volume);  // 設置音量
      await p.play(AssetSource(assetPath)); // 播放音效
    } catch (_) {
      // 如果播放失敗，可能是資源不存在或其他錯誤
      // print('Sound play error: $assetPath');
    }
  }

  // ===== 封裝好的快捷方法（可增減）=====

  static Future<void> click1() => _play('sounds/UI/button-click-289742.mp3');
  static Future<void> click2() => _play('sounds/UI/UI#2.mp3');
  static Future<void> click3() => _play('sounds/UI/UI#3.mp3');
  static Future<void> click5() => _play('sounds/UI/button-305770.mp3');
  static Future<void> fart1() => _play('sounds/Fart/fart1.wav');
  static Future<void> fart2() => _play('sounds/Fart/fart2.wav');
  static Future<void> fart3() => _play('sounds/Fart/fart3.wav');
  static Future<void> fart4() => _play('sounds/Fart/fart4.wav');
  static Future<void> fart5() => _play('sounds/Fart/fart5.wav');

  // 同時給觸覺/系統點擊（實機設定擋掉時仍有回饋）
  static Future<void> tactileClick() async {
    HapticFeedback.selectionClick();
    try {
      await SystemSound.play(SystemSoundType.click);
    } catch (_) {}
    await click1(); // 保底自家音效
  }

  // 釋放資源（通常不需要呼叫）
  static Future<void> dispose() async {
    for (final p in _pool) {
      await p.dispose();
    }
  }
}
