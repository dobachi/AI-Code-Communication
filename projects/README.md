# Projects Directory Structure

このディレクトリはgit worktreeを活用した並列作業に最適化された構造になっています。

## ディレクトリ構造

```
projects/
├── templates/
│   └── project-template/    # 新規プロジェクト用テンプレート
├── <プロジェクト名>/
│   ├── workspace/          # git worktree作業領域
│   │   ├── president/      # メインリポジトリ（president管理）
│   │   ├── boss1/         # 統合用worktree（boss1管理）
│   │   └── worker[1-3]/   # 各worker専用worktree
│   ├── checkpoint/        # プロジェクト専用チェックポイント
│   ├── instructions/      # プロジェクト固有指示書
│   ├── config/           # プロジェクト設定（worktree.yaml等）
│   └── shared/           # 共有リソース・スクリプト
```

## プロジェクト作成手順

### 1. プロジェクトディレクトリの準備
```bash
# テンプレートからコピー
cp -r templates/project-template projects/<プロジェクト名>
```

### 2. Worktree環境の初期化

#### 新規プロジェクト
```bash
cd projects/<プロジェクト名>
./shared/scripts/setup-worktree.sh <プロジェクト名> --new
```

#### 既存リポジトリをクローン
```bash
cd projects/<プロジェクト名>
./shared/scripts/setup-worktree.sh <プロジェクト名> --clone <リポジトリURL>
```

#### 既存ローカルリポジトリから
```bash
cd projects/<プロジェクト名>
./shared/scripts/setup-worktree.sh <プロジェクト名> --existing <ローカルパス>
```

### 3. 設定とブランチ戦略
1. `config/worktree.yaml` でプロジェクト固有設定を更新
2. boss1がブランチ戦略を立案
3. `shared/scripts/create-worker-worktree.sh` でworker用worktreeを作成

### 4. リモートとの同期（必要に応じて）
```bash
./shared/scripts/sync-with-remote.sh <プロジェクト名>
```

## 既存プロジェクト

- **dataspace-mcp**: データスペースMCPプロジェクト
- **sovity-edc-demo**: EDCデモプロジェクト

## 使用方法

各プロジェクトのREADMEとinstructions/を確認してください。