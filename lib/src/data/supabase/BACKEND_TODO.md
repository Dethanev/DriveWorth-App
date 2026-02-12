# 後端連接點標記

> **注意**：此文件涵蓋所有後端 API 連接點，不僅限於 Supabase。  
> 如果主要使用 Supabase，大部分 API 將通過 Supabase 實作。

## 🔴 需要連接後端 API 的地方

### 1. 分析功能 (`analyze_page.dart`)
- **行 70-79**: 分析 API 調用
  - 目前：模擬延遲和隨機結果
  - 需要：連接真實的分析 API
  ```dart
  // TODO: 連接分析 API
  // await Future.delayed(const Duration(seconds: 2));
  // final response = await analysisApi.analyze(_inputController.text, _tabIndex);
  ```

### 2. 登入功能 (`login_page.dart`) 🔐
> **Supabase Auth 相關** - 詳細準備工作請參考 `SUPABASE_PREP_CHECK.md`

- **行 118-131**: 登入驗證 API
  - 目前：硬編碼 "1234"/"1234"
  - 需要：使用 Supabase Auth `signInWithEmail()`
  ```dart
  // TODO: 連接 Supabase Auth
  // final response = await supabase.auth.signInWithPassword(
  //   email: _emailController.text,
  //   password: _passwordController.text,
  // );
  ```

- **行 177-182**: 註冊功能
  - 目前：顯示 "註冊功能開發中"
  - 需要：使用 Supabase Auth `signUp()`

- **行 90-107**: 第三方登入（Apple/Google）
  - 目前：顯示 "此功能開發中"
  - 需要：使用 Supabase Auth OAuth

### 3. 論壇功能 (`forum_post_detail_page.dart`)
- **行 35-44**: 點讚 API
  - 目前：僅更新本地狀態
  - 需要：同步到後端

- **行 47-72**: 發送留言 API
  - 目前：僅更新本地狀態
  - 需要：同步到後端

- **行 55**: 獲取當前登入使用者
  - 目前：硬編碼 '我'
  - 需要：從後端獲取使用者資訊

### 4. 論壇列表 (`forum_page.dart`)
- **行 20**: 論壇貼文列表 API
  - 目前：使用 `dummyForumPosts`
  - 需要：從後端獲取貼文列表

- **行 29-43**: 發文功能
  - 目前：顯示 "發文功能尚未實作"
  - 需要：實作發文 API

### 5. 分析歷史 (`analyze_history_sheet.dart`)
- **行 44**: 分析歷史紀錄 API
  - 目前：使用 `dummyAnalysisRecords`
  - 需要：從後端獲取歷史紀錄

- **行 86-91**: 查看詳細分析結果
  - 目前：顯示 "功能開發中"
  - 需要：連接詳細結果 API

### 6. 首頁 (`home_page.dart`)
- **行 76**: 查看全部紀錄功能
  - 目前：顯示 SnackBar
  - 需要：實作完整歷史頁面

### 7. 假資料來源
- **`analysis_record.dart:19`**: `dummyAnalysisRecords`
  - 需要替換為 API 調用

- **`forum_post.dart:45`**: `dummyForumPosts`
  - 需要替換為 API 調用

---

## 📝 註釋清理建議

### 可以移除的明顯註釋
- 編號註釋（如 "1. Segment Control", "2. Input Section"）
- 過於明顯的說明（如 "Hide keyboard", "收起鍵盤"）
- 分隔線註釋（如 "--- Rive 動畫控制器 ---"）
- 內部元件註釋（如 "內部元件：點讚按鈕"）

### 需要保留的註釋
- 後端連接點的 TODO 註釋
- 複雜邏輯的說明
- 特殊處理的原因說明

