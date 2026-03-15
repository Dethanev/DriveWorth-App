# DriveWorth 前端

## 開發執行

```bash
cd frontend/app
flutter pub get
flutter run
```

## Release 測試

```bash
cd frontend/app
flutter pub get
flutter run --release --dart-define=SUPABASE_URL=你的_SUPABASE_URL --dart-define=SUPABASE_ANON_KEY=你的_SUPABASE_ANON_KEY
```
把 `你的_SUPABASE_URL`、`你的_SUPABASE_ANON_KEY` 換成實際值，整段複製即可跑 release。
