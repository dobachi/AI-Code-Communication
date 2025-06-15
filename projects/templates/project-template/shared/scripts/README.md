# プロジェクト管理スクリプト

## setup-worktree.sh
Worktree環境の初期化スクリプト

### 使用法
```bash
# 新規プロジェクト
./setup-worktree.sh <プロジェクト名> --new

# リモートリポジトリをクローン
./setup-worktree.sh <プロジェクト名> --clone <リポジトリURL>

# 既存ローカルリポジトリから
./setup-worktree.sh <プロジェクト名> --existing <ローカルパス>
```

### 実行内容
1. President用リポジトリの準備（新規作成/クローン/コピー）
2. Boss1用worktreeの作成（integration/phase-1ブランチ）
3. 既存featureブランチの検出と案内
4. リモートブランチとの適切な連携

## create-worker-worktree.sh
Worker用worktreeの個別作成スクリプト

### 使用法
```bash
./create-worker-worktree.sh <プロジェクト名> <worker番号> <スコープ> <機能名>

# 例
./create-worker-worktree.sh my-webapp 1 frontend user-dashboard
```

### 実行内容
1. 指定されたブランチ名でworktreeを作成
2. config/worktree.yamlの更新案を表示

## sync-with-remote.sh
リモートリポジトリとの同期確認スクリプト

### 使用法
```bash
./sync-with-remote.sh <プロジェクト名>
```

### 実行内容
1. リモートの最新情報を取得
2. 各worktreeの同期状況を確認
3. 必要なgit操作のアドバイス表示

## 推奨ワークフロー

1. **プロジェクト開始**
   ```bash
   cp -r templates/project-template projects/my-project
   cd projects/my-project
   ./shared/scripts/setup-worktree.sh my-project --clone https://github.com/user/repo.git
   ```

2. **ブランチ戦略決定（boss1が実行）**
   ```bash
   # config/worktree.yamlを更新
   ./shared/scripts/create-worker-worktree.sh my-project 1 frontend user-auth
   ./shared/scripts/create-worker-worktree.sh my-project 2 backend api-server
   ```

3. **定期的な同期確認**
   ```bash
   ./shared/scripts/sync-with-remote.sh my-project
   ```