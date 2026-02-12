# Supabase Auth 接入前檢查報告

> **注意**：此文件專注於 Supabase Auth 的準備工作。  
> 其他後端 API 連接點請參考 `BACKEND_TODO.md`。

## 已準備好的部分

1. **Auth 頁面結構完整**
   - `login_page.dart` - 登入頁面
   - `login_form.dart` - 登入表單元件
   - `login_social_section.dart` - 第三方登入元件

2. **後端連接點已標記**
   - 所有需要連接 API 的地方都有 `// TODO:` 標記

## 需要改進的地方

### 1. 硬編碼顏色（已修復）
- ~~`login_page.dart` - `Color(0xffd6e2ea)`~~ → 已改為 `AppColors.background`
- ~~`login_form.dart` - `Colors.deepPurpleAccent`~~ → 已改為 `AppColors.accent`
- ~~`login_social_section.dart` - 硬編碼顏色~~ → 已改為使用 `AppColors`

### 2. 硬編碼使用者資訊
- `personal_header.dart:9-10` - 硬編碼 "Ethan" 和 "ethan@gmail.com"
  - 需要：從 Supabase 獲取當前使用者資訊

### 3. 缺少 Supabase 初始化
- `main.dart` - 沒有初始化 Supabase 客戶端
  - 需要：在 `main()` 中初始化 Supabase

### 4. 缺少 Auth State 管理
- `main.dart` - 沒有檢查登入狀態
  - 需要：根據 auth state 決定初始路由（已登入 → `/root`，未登入 → `/login`）

### 5. 登出功能不完整（已標記 TODO）
- `settings_page.dart:63-65` - 只有導航，沒有實際登出邏輯
  - 已添加 TODO 註釋
  - 需要：調用 Supabase 登出 API

### 6. 缺少路由保護
- `app_shell.dart` - 沒有檢查是否已登入
  - 需要：未登入時導航到登入頁

### 7. 測試帳號需要移除（已標記 TODO）
- `login_page.dart:117-118` - 硬編碼 "1234"/"1234"
  - 已添加 TODO 註釋說明
  - 需要：替換為 Supabase auth

### 8. 缺少錯誤處理
- `login_page.dart` - 沒有處理登入失敗的錯誤訊息
  - 需要：顯示 Supabase 錯誤訊息（如：Email 格式錯誤、密碼錯誤等）

### 9. 其他小問題（已修復）
- `result_panel.dart:121` - `debugPrint` → 已改為 TODO 註釋
- `input_section.dart:56` - 圖片選擇邏輯 → 已添加 TODO 註釋
- `personal_page.dart` - 多餘註釋 → 已清理

---

## 接入 Supabase Auth 的步驟建議

1. **初始化 Supabase**
   ```dart
   // main.dart
   await Supabase.initialize(...)
   ```

2. **建立 Auth Service**
   ```dart
   // lib/src/data/supabase/auth_service.dart
   class AuthService {
     static signInWithEmail(...)
     static signUp(...)
     static signOut()
     static getCurrentUser()
   }
   ```

3. **更新登入邏輯**
   - 替換 `login_page.dart:116-129` 的測試帳號邏輯
   - 使用 `AuthService.signInWithEmail()`

4. **更新登出邏輯**
   - 在 `settings_page.dart:63` 調用 `AuthService.signOut()`

5. **更新使用者資訊顯示**
   - `personal_header.dart` 從 Supabase 獲取使用者資料

6. **添加路由保護**
   - 在 `main.dart` 檢查 auth state
   - 在 `app_shell.dart` 添加 auth guard

7. **統一顏色使用**
   - 將硬編碼顏色改為使用 `AppColors`

