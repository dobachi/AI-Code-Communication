# 🎯 Boss1プロジェクト初期設定手順

## プロジェクト初回起動時の自動タスク

presidentから初期設定完了の通知を受けたら、以下の手順を実行してください：

### 1. プロジェクト指示書の確認と理解
```bash
# 自分の指示書を確認
projects/{{PROJECT_NAME}}/instructions/boss.md

# 各workerの指示書も確認
projects/{{PROJECT_NAME}}/instructions/worker*.md
```

### 2. Worker役割分担の決定
プロジェクトの性質とworker数に基づいて、各workerの専門領域を決定：

#### 役割分担パターン例
- **Webアプリケーション（3名）**：
  - worker1: フロントエンド・UI/UX
  - worker2: バックエンド・API
  - worker3: テスト・インフラ

- **データ分析プロジェクト（3名）**：
  - worker1: データ収集・前処理
  - worker2: 分析・モデリング
  - worker3: 可視化・レポート

- **大規模プロジェクト（5名以上）**：
  - より細分化された専門領域を割り当て

### 3. Worker指示書の更新
決定した役割分担に基づいて、各worker指示書を更新：

```bash
# 各workerの指示書に専門領域を追記
projects/{{PROJECT_NAME}}/instructions/worker1.md
projects/{{PROJECT_NAME}}/instructions/worker2.md
...
```

更新内容：
- 専門領域の明確化
- 責任範囲の定義
- 他workerとの連携方法
- 使用すべきツール・技術

### 4. boss.mdの更新
自身の指示書も更新して、決定事項を記録：
- 各workerの役割分担表
- 開発プロセスの詳細
- 品質基準の具体化

### 5. 各Workerへの通知
役割分担が完了したら、各workerに通知：

```bash
./bin/agent-send worker1 "あなたはworker1です。プロジェクト '{{PROJECT_NAME}}' の初期設定が完了しました。
あなたの専門領域は[具体的な領域]です。指示書を確認し、開発環境のセットアップを開始してください。"

# worker2, worker3...も同様に通知
```

### 6. Presidentへの報告
全workerへの通知完了後、presidentに報告：

```bash
./bin/agent-send president "チーム編成が完了しました。
- worker1: [役割]
- worker2: [役割]
- worker3: [役割]
各メンバーへの通知も完了し、開発準備が整いました。"
```

## 重要な注意事項
- 役割分担はプロジェクトの性質に応じて柔軟に決定
- 各workerの負荷バランスを考慮
- 必要に応じて後から役割を調整可能