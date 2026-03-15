#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/.."

if [ -z "$SUPABASE_URL" ] || [ -z "$SUPABASE_ANON_KEY" ]; then
  echo "請設定環境變數：SUPABASE_URL、SUPABASE_ANON_KEY"
  echo "例：SUPABASE_URL=https://xxx.supabase.co SUPABASE_ANON_KEY=eyJ... ./scripts/build_apk.sh"
  exit 1
fi

flutter pub get
flutter build apk \
  --dart-define=SUPABASE_URL="$SUPABASE_URL" \
  --dart-define=SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY"

echo ""
echo "APK 輸出：build/app/outputs/flutter-apk/app-release.apk"
