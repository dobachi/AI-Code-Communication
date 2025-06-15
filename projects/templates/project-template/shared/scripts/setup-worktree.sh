#!/bin/bash
# プロジェクト用worktree初期化スクリプト（新規・クローン・既存対応）

show_usage() {
    echo "使用法:"
    echo "  $0 <プロジェクト名> --new                    # 新規リポジトリ作成"
    echo "  $0 <プロジェクト名> --clone <リポジトリURL>   # リモートリポジトリをクローン"
    echo "  $0 <プロジェクト名> --existing <ローカルパス> # 既存ローカルリポジトリから"
    echo ""
    echo "例:"
    echo "  $0 my-project --new"
    echo "  $0 my-project --clone https://github.com/user/repo.git"
    echo "  $0 my-project --existing /path/to/existing/repo"
}

if [ $# -lt 2 ]; then
    show_usage
    exit 1
fi

PROJECT_NAME="$1"
MODE="$2"
SOURCE="$3"

PROJECT_DIR="projects/$PROJECT_NAME"
WORKSPACE_DIR="$PROJECT_DIR/workspace"

echo "=== Worktree環境セットアップ開始: $PROJECT_NAME ($MODE) ==="

# ワークスペースディレクトリ作成
mkdir -p "$WORKSPACE_DIR"
cd "$WORKSPACE_DIR"

# 1. President用リポジトリ準備
if [ ! -d "president" ]; then
    case "$MODE" in
        "--new")
            echo "新規リポジトリを作成します..."
            mkdir president
            cd president
            git init
            echo "# $PROJECT_NAME" > README.md
            git add README.md
            git commit -m "Initial commit for $PROJECT_NAME"
            echo "President用リポジトリを初期化しました: $PWD"
            cd ..
            ;;
        "--clone")
            if [ -z "$SOURCE" ]; then
                echo "エラー: リポジトリURLが指定されていません"
                show_usage
                exit 1
            fi
            echo "リモートリポジトリをクローンします: $SOURCE"
            git clone "$SOURCE" president
            if [ $? -ne 0 ]; then
                echo "エラー: クローンに失敗しました"
                exit 1
            fi
            echo "President用リポジトリをクローンしました: $PWD/president"
            ;;
        "--existing")
            if [ -z "$SOURCE" ]; then
                echo "エラー: 既存リポジトリパスが指定されていません"
                show_usage
                exit 1
            fi
            if [ ! -d "$SOURCE/.git" ]; then
                echo "エラー: $SOURCE は有効なGitリポジトリではありません"
                exit 1
            fi
            echo "既存リポジトリからコピーします: $SOURCE"
            cp -r "$SOURCE" president
            echo "President用リポジトリをコピーしました: $PWD/president"
            ;;
        *)
            echo "エラー: 無効なモード: $MODE"
            show_usage
            exit 1
            ;;
    esac
else
    echo "President用リポジトリは既に存在します: $PWD/president"
fi

# 2. リモートブランチの確認（クローンの場合）
cd president
if [ "$MODE" = "--clone" ]; then
    echo "リモートブランチを確認しています..."
    git fetch --all
    REMOTE_BRANCHES=$(git branch -r | grep -v HEAD | sed 's/origin\///' | xargs)
    echo "利用可能なリモートブランチ: $REMOTE_BRANCHES"
fi

# 3. Boss1用worktree作成
cd "$WORKSPACE_DIR"
if [ ! -d "boss1" ]; then
    cd president
    
    # integration/phase-1ブランチが既に存在するかチェック
    if git show-ref --verify --quiet refs/heads/integration/phase-1; then
        echo "既存のintegration/phase-1ブランチを使用します"
        git worktree add ../boss1 integration/phase-1
    elif git show-ref --verify --quiet refs/remotes/origin/integration/phase-1; then
        echo "リモートのintegration/phase-1ブランチから作成します"
        git worktree add ../boss1 -b integration/phase-1 origin/integration/phase-1
    else
        echo "新しいintegration/phase-1ブランチを作成します"
        git worktree add ../boss1 -b integration/phase-1
    fi
    
    echo "Boss1用worktreeを作成しました"
    cd ..
else
    echo "Boss1用worktreeは既に存在します"
fi

# 4. 既存のfeatureブランチがある場合の処理
cd president
echo "既存のfeatureブランチを確認しています..."
FEATURE_BRANCHES=$(git branch -a | grep 'feature/' | sed 's/.*feature\//feature\//' | sort -u)

if [ -n "$FEATURE_BRANCHES" ]; then
    echo "既存のfeatureブランチが見つかりました:"
    echo "$FEATURE_BRANCHES"
    echo ""
    echo "これらのブランチ用worktreeを作成したい場合は、以下のコマンドを実行してください:"
    
    WORKER_NUM=1
    for branch in $FEATURE_BRANCHES; do
        BRANCH_NAME=$(echo "$branch" | sed 's/feature\///')
        echo "git worktree add ../worker$WORKER_NUM $branch"
        WORKER_NUM=$((WORKER_NUM + 1))
        if [ $WORKER_NUM -gt 3 ]; then break; fi
    done
else
    echo "Worker用worktreeは具体的な機能が決まってから作成してください："
    echo "cd $WORKSPACE_DIR/president"
    echo "git worktree add ../worker1 -b feature/[scope]/[function-name]"
    echo "git worktree add ../worker2 -b feature/[scope]/[function-name]"
    echo "git worktree add ../worker3 -b feature/[scope]/[function-name]"
fi

cd "$WORKSPACE_DIR"
echo ""
echo "=== Worktree環境セットアップ完了 ==="
echo "プロジェクトディレクトリ: $PROJECT_DIR"
echo "ワークスペース: $WORKSPACE_DIR"
echo ""
echo "作成されたworktree:"
if [ -d "president" ]; then echo "  president/ (メインリポジトリ)"; fi
if [ -d "boss1" ]; then echo "  boss1/ (統合用)"; fi
for i in {1..3}; do
    if [ -d "worker$i" ]; then echo "  worker$i/ (作業用)"; fi
done