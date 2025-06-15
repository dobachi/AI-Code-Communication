#!/bin/bash
# Worker用worktree作成スクリプト

PROJECT_NAME="$1"
WORKER_NUM="$2"
SCOPE="$3"
FUNCTION_NAME="$4"

if [ $# -ne 4 ]; then
    echo "使用法: $0 <プロジェクト名> <worker番号> <スコープ> <機能名>"
    echo "例: $0 my-webapp 1 frontend user-dashboard"
    exit 1
fi

PROJECT_DIR="projects/$PROJECT_NAME"
WORKSPACE_DIR="$PROJECT_DIR/workspace"
BRANCH_NAME="feature/$SCOPE/$FUNCTION_NAME"
WORKER_DIR="worker$WORKER_NUM"

echo "=== Worker$WORKER_NUM用worktree作成開始 ==="

cd "$WORKSPACE_DIR/president"

# worktreeが既に存在するかチェック
if [ -d "../$WORKER_DIR" ]; then
    echo "エラー: $WORKER_DIR は既に存在します"
    exit 1
fi

# worktree作成
git worktree add "../$WORKER_DIR" -b "$BRANCH_NAME"

if [ $? -eq 0 ]; then
    echo "Worker$WORKER_NUM用worktreeを作成しました:"
    echo "  ディレクトリ: $WORKSPACE_DIR/$WORKER_DIR"
    echo "  ブランチ: $BRANCH_NAME"
    
    # worktree.yamlファイルの更新案を表示
    echo ""
    echo "config/worktree.yamlを以下のように更新してください:"
    echo "  worker$WORKER_NUM:"
    echo "    branch: $BRANCH_NAME"
    echo "    role: worker$WORKER_NUM"
    echo "    purpose: \"[担当機能の説明を記入]\""
else
    echo "エラー: worktreeの作成に失敗しました"
    exit 1
fi

echo "=== Worker$WORKER_NUM用worktree作成完了 ==="