#!/bin/bash
# リモートリポジトリとの同期スクリプト

PROJECT_NAME="$1"
if [ -z "$PROJECT_NAME" ]; then
    echo "使用法: $0 <プロジェクト名>"
    exit 1
fi

PROJECT_DIR="projects/$PROJECT_NAME"
WORKSPACE_DIR="$PROJECT_DIR/workspace"

if [ ! -d "$WORKSPACE_DIR/president" ]; then
    echo "エラー: President用リポジトリが見つかりません: $WORKSPACE_DIR/president"
    exit 1
fi

echo "=== リモートリポジトリとの同期開始 ==="

cd "$WORKSPACE_DIR/president"

# リモートリポジトリの確認
if ! git remote get-url origin > /dev/null 2>&1; then
    echo "警告: リモートリポジトリ(origin)が設定されていません"
    echo "リモートリポジトリを追加する場合は以下を実行してください:"
    echo "cd $WORKSPACE_DIR/president"
    echo "git remote add origin <リポジトリURL>"
    exit 0
fi

REMOTE_URL=$(git remote get-url origin)
echo "リモートリポジトリ: $REMOTE_URL"

# リモートの最新情報を取得
echo "リモートブランチ情報を取得中..."
git fetch --all --prune

# 各worktreeのブランチ状況を確認
echo ""
echo "=== 各worktreeの同期状況 ==="

# President (main branch)
echo "President (main):"
cd "$WORKSPACE_DIR/president"
CURRENT_BRANCH=$(git branch --show-current)
echo "  現在のブランチ: $CURRENT_BRANCH"
if git rev-parse --verify origin/$CURRENT_BRANCH > /dev/null 2>&1; then
    BEHIND=$(git rev-list --count HEAD..origin/$CURRENT_BRANCH)
    AHEAD=$(git rev-list --count origin/$CURRENT_BRANCH..HEAD)
    echo "  リモートより: $BEHIND コミット遅れ, $AHEAD コミット先行"
    
    if [ $BEHIND -gt 0 ]; then
        echo "  推奨アクション: git pull origin $CURRENT_BRANCH"
    fi
    if [ $AHEAD -gt 0 ]; then
        echo "  推奨アクション: git push origin $CURRENT_BRANCH"
    fi
else
    echo "  リモートブランチが存在しません"
fi

# Boss1
if [ -d "$WORKSPACE_DIR/boss1" ]; then
    echo ""
    echo "Boss1:"
    cd "$WORKSPACE_DIR/boss1"
    CURRENT_BRANCH=$(git branch --show-current)
    echo "  現在のブランチ: $CURRENT_BRANCH"
    if git rev-parse --verify origin/$CURRENT_BRANCH > /dev/null 2>&1; then
        BEHIND=$(git rev-list --count HEAD..origin/$CURRENT_BRANCH)
        AHEAD=$(git rev-list --count origin/$CURRENT_BRANCH..HEAD)
        echo "  リモートより: $BEHIND コミット遅れ, $AHEAD コミット先行"
    else
        echo "  リモートブランチが存在しません（新規ブランチ）"
        echo "  推奨アクション: git push -u origin $CURRENT_BRANCH"
    fi
fi

# Workers
for i in {1..3}; do
    WORKER_DIR="$WORKSPACE_DIR/worker$i"
    if [ -d "$WORKER_DIR" ]; then
        echo ""
        echo "Worker$i:"
        cd "$WORKER_DIR"
        CURRENT_BRANCH=$(git branch --show-current)
        echo "  現在のブランチ: $CURRENT_BRANCH"
        if git rev-parse --verify origin/$CURRENT_BRANCH > /dev/null 2>&1; then
            BEHIND=$(git rev-list --count HEAD..origin/$CURRENT_BRANCH)
            AHEAD=$(git rev-list --count origin/$CURRENT_BRANCH..HEAD)
            echo "  リモートより: $BEHIND コミット遅れ, $AHEAD コミット先行"
        else
            echo "  リモートブランチが存在しません（新規ブランチ）"
            echo "  推奨アクション: git push -u origin $CURRENT_BRANCH"
        fi
    fi
done

echo ""
echo "=== 同期完了 ==="
echo "各worktreeで必要に応じて git pull/push を実行してください"