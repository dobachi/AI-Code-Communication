# 🤖 AI-Code-Communication エージェント通信システム

複数のAIが協力して働く、まるで会社のような開発システムです

## 🙏 謝辞

このプロジェクトは、[Akira-Papa](https://github.com/Akira-Papa)さんと[nishimoto265](https://github.com/nishimoto265)さんの[Claude-Code-Communication](https://github.com/Akira-Papa/Claude-Code-Communication)から着想を得て開発されました。複数のAIエージェントが協調して作業するという革新的なアイデアに感謝します。

## 📌 これは何？

**3行で説明すると：**
1. 複数のAIエージェント（社長・マネージャー・作業者）が協力して開発
2. それぞれ異なるターミナル画面で動作し、メッセージを送り合う
3. 人間の組織のように役割分担して、効率的に開発を進める

**実際の成果：**
- 3時間で完成したアンケートシステム（EmotiFlow）
- 12個の革新的アイデアを生成
- 100%のテストカバレッジ

## 🚀 セットアップとプロジェクト開始

このシステムは、**プロジェクト管理用のリポジトリ**の中に、**開発対象のソースコードを独立したリポジトリ**として配置する構成を推奨しています。

### 必要なもの
- Mac または Linux
- tmux（ターミナル分割ツール）
- AI CLI (Claude または Gemini)

### 1. プロジェクト管理コンテナの準備 (初回のみ)

まず、このエージェントシステム自体をダウンロードします。

```bash
# このリポジトリをクローン
git clone https://github.com/your-username/AI-Code-Communication.git

# ディレクトリに移動
cd AI-Code-Communication
```

### 2. 新規プロジェクトの開始方法

新しい開発プロジェクトを始めるときの典型的な流れです。

#### ステップ1: プロジェクト管理環境の作成

`./bin/project create` コマンドで、新しいプロジェクトのための管理環境（ディレクトリ構造、tmuxセッションなど）を作成します。

```bash
# "sample-agent-project" という名前の管理環境を作成
./bin/project create sample-agent-project
```

#### ステップ2: 開発対象リポジトリのクローン

次に、実際に開発したいアプリケーションのソースコードを、所定の場所にクローンします。

1.  **President用のディレクトリに移動**
    Presidentはメインブランチを管理します。
    ```bash
    cd projects/sample-agent-project/workspace/president
    ```

2.  **開発対象リポジトリをクローン**
    ここに、開発したいリポジトリを `source` という名前でクローンするのが推奨です。
    ```bash
    # "sample-application-code.git" をクローン
    git clone git@github.com:your-username/sample-application-code.git source
    ```
    *   **Note:** `source` ディレクトリは `.gitignore` で管理対象外に設定されています。

#### ステップ3: エージェントの起動

管理環境名（`sample-agent-project`）を指定して、AIエージェントたちを起動します。

```bash
# Claude エージェントを起動する場合
./bin/claude-startup sample-agent-project

# Gemini エージェントを起動する場合
./bin/gemini-startup sample-agent-project
```

#### ステップ4: 作業開始の指示

Presidentのターミナルで、最初の指示を与えます。

```
あなたはpresidentです。指示書に従って、プロジェクトを開始してください。
```

これで、設定された開発環境でエージェントたちが自律的に作業を開始します。

### 補足: Git Worktreeによる並行作業

このシステムは `git worktree` を活用し、`boss` や `worker` たちが同じリポジトリで安全に並行作業できる環境を自動で構築します。

-   `workspace/president`: `main` ブランチを担当
-   `workspace/boss1`: `boss1` ブランチで作業
-   `workspace/worker1`: `worker1` ブランチで作業

これにより、各エージェントは他の作業者の変更に影響されることなく、独立してタスクを進めることができます。

## 🏢 登場人物（エージェント）

### 👑 社長（PRESIDENT）
- **役割**: 全体の方針を決める
- **特徴**: ユーザーの本当のニーズを理解する天才
- **口癖**: 「このビジョンを実現してください」

### 🎯 マネージャー（boss1）
- **役割**: チームをまとめる中間管理職
- **特徴**: メンバーの創造性を引き出す達人
- **口癖**: 「革新的なアイデアを3つ以上お願いします」

### 👷 作業者たち（worker1, 2, 3）
- **worker1**: デザイン担当（UI/UX）
- **worker2**: データ処理担当
- **worker3**: テスト担当

## 💬 どうやってコミュニケーションする？

### メッセージの送り方
```bash
./bin/agent-send [相手の名前] "[メッセージ]"

# 例：マネージャーに送る
./bin/agent-send boss1 "新しいプロジェクトです"

# 例：作業者1に送る
./bin/agent-send worker1 "UIを作ってください"
```

### 実際のやり取りの例

**社長 → マネージャー：**
```
あなたはboss1です。

【プロジェクト名】アンケートシステム開発

【ビジョン】
誰でも簡単に使えて、結果がすぐ見られるシステム

【成功基準】
- 3クリックで回答完了
- リアルタイムで結果表示

革新的なアイデアで実現してください。
```

**マネージャー → 作業者：**
```
あなたはworker1です。

【プロジェクト】アンケートシステム

【チャレンジ】
UIデザインの革新的アイデアを3つ以上提案してください。

【フォーマット】
1. アイデア名：[キャッチーな名前]
   概要：[説明]
   革新性：[何が新しいか]
```

## 📁 重要なファイルの説明

### コマンドツール（bin/）
ユーザー向けの実行コマンドです
- **quick-start**: プロジェクト作成からAI起動まで一括実行（最速セットアップ）
- **project**: 統合プロジェクト管理（作成・セットアップ・切替・停止など）
- **agent-send**: エージェント間メッセージ送信
- **claude-startup**: Claude Codeエージェントの一括起動
- **gemini-startup**: Gemini Codeエージェントの一括起動

### 指示書（instructions/）
各エージェントの行動マニュアルです

**president.md** - 社長の指示書
```markdown
# あなたの役割
最高の経営者として、ユーザーのニーズを理解し、
ビジョンを示してください

# ニーズの5層分析
1. 表層：何を作るか
2. 機能層：何ができるか  
3. 便益層：何が改善されるか
4. 感情層：どう感じたいか
5. 価値層：なぜ重要か
```

**boss.md** - マネージャーの指示書
```markdown
# あなたの役割
天才的なファシリテーターとして、
チームの創造性を最大限に引き出してください

# 10分ルール
10分ごとに進捗を確認し、
困っているメンバーをサポートします
```

**worker.md** - 作業者の指示書
```markdown
# あなたの役割
専門性を活かして、革新的な実装をしてください

# タスク管理
1. やることリストを作る
2. 順番に実行
3. 完了したら報告
```

### CLAUDE.md
システム全体の設定ファイル
```markdown
# Agent Communication System

## エージェント構成
- PRESIDENT: 統括責任者
- boss1: チームリーダー  
- worker1,2,3: 実行担当

## メッセージ送信
./bin/agent-send [相手] "[メッセージ]"
```

## 🎨 実際に作られたもの：EmotiFlow

### 何ができた？
- 😊 絵文字で感情を表現できるアンケート
- 📊 リアルタイムで結果が見られる
- 📱 スマホでも使える

### 試してみる
```bash
cd emotiflow-mvp
python -m http.server 8000
# ブラウザで http://localhost:8000 を開く
```

### ファイル構成
```
emotiflow-mvp/
├── index.html    # メイン画面
├── styles.css    # デザイン
├── script.js     # 動作ロジック
└── tests/        # テスト
```

## 🔧 困ったときは

### Q: エージェントが反応しない
```bash
# 状態を確認
./bin/project list

# 現在のプロジェクトを確認
./bin/project current

# AIを再起動
./bin/claude-startup # または ./bin/gemini-startup
```

### Q: メッセージが届かない
```bash
# ログを見る
cat logs/send_log.txt

# 手動でテスト
./bin/agent-send boss1 "テスト"
```

### Q: 最初からやり直したい
```bash
# 全部リセット
tmux kill-server
rm -rf ./tmp/*
./bin/project setup    # デフォルトセッション再作成
```

## 🚀 自分のプロジェクトを作る

### 最速で始める（推奨）
```bash
# プロジェクト作成→AI起動まで全自動
./bin/quick-start my-new-project

# Git管理付きで作成
./bin/quick-start my-project --git --remote git@github.com:user

# デフォルトセッションで始める
./bin/quick-start --default
```

### 手動でプロジェクトを作成
```bash
# 新しいプロジェクトを作成
./bin/project create my-new-project

# Git管理を含める場合
./bin/project create my-project --git --remote git@github.com:user
```

### 🆕 複数プロジェクトの並行実行

このシステムは複数のプロジェクトを同時に実行できます：

```bash
# プロジェクト1を開始
./bin/project create project1   # プロジェクト作成＆環境構築
./bin/claude-startup            # AIエージェント起動 (または ./bin/gemini-startup)

# プロジェクト2を開始（project1は動いたまま）
./bin/project create project2   # 別のプロジェクトを作成
./bin/claude-startup            # project2のAIエージェント起動 (または ./bin/gemini-startup)

# 統合プロジェクト管理コマンドを使用
./bin/project list              # 実行中のプロジェクト一覧
./bin/project current           # 現在のプロジェクトを確認

# プロジェクトを切り替えてメッセージ送信
./bin/project switch project1
./bin/agent-send boss1 "プロジェクト1のタスク"

./bin/project switch project2
./bin/agent-send boss1 "プロジェクト2のタスク"
```

**仕組み：**
- 各プロジェクトは独立したtmuxセッション（`project1-multiagent`、`project1-president`など）
- `.current-project`ファイルで現在のプロジェクトコンテキストを管理
- `agent-send`は自動的に現在のプロジェクトのエージェントにメッセージを送信

### 🎮 統合プロジェクト管理コマンド

すべてのプロジェクト管理操作を`./bin/project`コマンドで統一しました：

**基本的な使い方：**
```bash
./bin/project help              # ヘルプを表示
./bin/project setup             # デフォルトセッション作成
./bin/project create <project>  # プロジェクト作成
./bin/project list              # 実行中のプロジェクト一覧
./bin/project list --all        # 全プロジェクト一覧（停止中も含む）
./bin/project current           # 現在のプロジェクトを表示
./bin/project switch <project>  # プロジェクトを切り替え
./bin/project attach <agent>    # エージェントにアタッチ
./bin/project stop <project>    # プロジェクトを停止
./bin/project delete <project>  # プロジェクトを完全削除（要確認）
```

**プロジェクト管理：**
```bash
# プロジェクト状態の確認
./bin/project list              # 全プロジェクトと実行状態
./bin/project current           # 現在アクティブなプロジェクト

# プロジェクトの切り替え
./bin/project switch project1   # project1に切り替え
./bin/project switch --clear    # プロジェクトコンテキストをクリア
```

**セッションアタッチ：**
```bash
# 現在のプロジェクトのエージェントにアタッチ
./bin/project attach president  # presidentセッション
./bin/project attach boss1      # multiagentのboss1ペイン
./bin/project attach multiagent # 4分割画面全体
./bin/project attach            # 利用可能なエージェント一覧
```

**セッション停止・削除：**
```bash
# セッションの停止
./bin/project stop --current    # 現在のプロジェクトを停止
./bin/project stop project1     # 特定のプロジェクトを停止
./bin/project stop --all        # 全プロジェクトを停止

# プロジェクトの削除（危険：データも削除）
./bin/project delete project1   # 特定のプロジェクトを完全削除
./bin/project delete --current  # 現在のプロジェクトを削除
# ⚠️ 削除時は二重確認（yes入力＋プロジェクト名入力）が必要
```

**活用例：**
```bash
# プロジェクト1で作業開始（最速）
./bin/quick-start project1      # 作成→AI起動まで全自動
./bin/project attach boss1      # boss1の作業を確認

# プロジェクト2を追加
./bin/quick-start project2 --git # Git付きで作成
./bin/project attach president  # project2のpresidentにアタッチ

# 状態確認と終了
./bin/project list              # 実行中のプロジェクト確認
./bin/project stop project1     # project1を停止
```

**エイリアス設定（推奨）：**
```bash
# ~/.bashrc または ~/.zshrc に追加
alias qs='./bin/quick-start'
alias pj='./bin/project'

# 使用例
qs myproject                    # 最速でプロジェクト開始
pj list                         # プロジェクト一覧
pj switch myproject             # プロジェクト切り替え
pj attach boss1                 # エージェントにアタッチ
```

### 簡単な例：TODOアプリを作る

社長（PRESIDENT）で入力：
```
あなたはpresidentです。
TODOアプリを作ってください。
シンプルで使いやすく、タスクの追加・削除・完了ができるものです。
```

すると自動的に：
1. マネージャーがタスクを分解
2. worker1がUI作成
3. worker2がデータ管理
4. worker3がテスト作成
5. 完成！

## 📊 システムの仕組み（図解）

### 画面構成
```
┌─────────────────┐
│   PRESIDENT     │ ← 社長の画面（紫色）
└─────────────────┘

┌────────┬────────┐
│ boss1  │worker1 │ ← マネージャー（赤）と作業者1（青）
├────────┼────────┤
│worker2 │worker3 │ ← 作業者2と3（青）
└────────┴────────┘
```

### コミュニケーションの流れ
```
社長
 ↓ 「ビジョンを実現して」
マネージャー
 ↓ 「みんな、アイデア出して」
作業者たち
 ↓ 「できました！」
マネージャー
 ↓ 「全員完了です」
社長
```

### 進捗管理の仕組み
```
./tmp/
├── worker1_done.txt     # 作業者1が完了したらできるファイル
├── worker2_done.txt     # 作業者2が完了したらできるファイル
├── worker3_done.txt     # 作業者3が完了したらできるファイル
└── worker*_progress.log # 進捗の記録
```

## 💡 なぜこれがすごいの？

### 従来の開発
```
人間 → AI → 結果
```

### このシステム
```
人間 → AI社長 → AIマネージャー → AI作業者×3 → 統合 → 結果
```

**メリット：**
- 並列処理で3倍速い
- 専門性を活かせる
- アイデアが豊富
- 品質が高い

## 🎓 もっと詳しく知りたい人へ

### プロンプトの書き方

**良い例：**
```
あなたはboss1です。

【プロジェクト名】明確な名前
【ビジョン】具体的な理想
【成功基準】測定可能な指標
```

**悪い例：**
```
何か作って
```

### カスタマイズ方法

**新しい作業者を追加：**
1. `instructions/worker4.md`を作成
2. `bin/project`の`cmd_create`と`cmd_setup`関数を編集してペインを追加
3. `bin/agent-send`にマッピングを追加

**タイマーを変更：**
```bash
# instructions/boss.md の中の
sleep 600  # 10分を5分に変更するなら
sleep 300
```

## 🌟 まとめ

このシステムは、複数のAIが協力することで：
- **3時間**で本格的なWebアプリが完成
- **12個**の革新的アイデアを生成
- **100%**のテストカバレッジを実現

ぜひ試してみて、AIチームの力を体験してください！

---

**作者**: [GitHub](https://github.com/dobachi/AI-Code-Communication)
**ライセンス**: MIT
**質問**: [Issues](https://github.com/dobachi/AI-Code-Communication/issues)へどうぞ！