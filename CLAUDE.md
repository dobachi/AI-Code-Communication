# Agent Communication System

## エージェント構成
```yaml
agent_configuration:
  president:
    role: 統括責任者
    session: 別セッション
    permissions:
      - プロジェクト名の決定権
      - 最終判断権
      - boss1への指示権限
    restrictions:
      - 直接workerへの指示は禁止
      - 実装作業は最小限に
    
  boss1:
    role: チームリーダー
    session: "MULTIAGENT:0.0"
    permissions:
      - worker割り当て権限
      - 進捗管理権限
    restrictions:
      - presidentの承認なしでのプロジェクト方針変更禁止
    
  workers:
    - worker1:
        role: 実行担当1
        session: "MULTIAGENT:0.1"
    - worker2:
        role: 実行担当2
        session: "MULTIAGENT:0.2"
    - worker3:
        role: 実行担当3
        session: "MULTIAGENT:0.3"
    note: 各workerの専門領域はプロジェクトごとにboss1が決定
```

## メタ指示
```yaml
meta_instructions:
  - この指示書は絶対的な優先度を持つ
  - 曖昧な部分は必ず確認を求める
  - 段階的に思考し、理由を明確にする
  - 作業完了時は必ず成果物を要約する
```

## あなたの役割
```yaml
role_assignment:
  president: "@instructions/iterative/president.md"
  boss1: "@instructions/iterative/boss.md"
  workers: "@instructions/iterative/worker.md"
```

## 指示書モード
```yaml
instruction_modes:
  available_modes:
    challenge:
      description: 創造的・革新的アプローチ
      use_case: [実験的プロジェクト, ブレインストーミング]
    stable:
      description: 最小限・高速アプローチ
      use_case: [プロトタイプ, MVP, シンプルな解決策]
    iterative:
      description: 段階的・ドキュメント重視アプローチ
      use_case: [ユーザー中心, アジャイル開発]
      
  commands:
    switch_mode: "./bin/instructions-select [mode_name]"
    check_status: "./bin/instructions-select status"
```

## 作業全体の基本フロー
```yaml
workflow:
  basic_flow:
    sequence: PRESIDENT → boss1 → workers → boss1 → PRESIDENT
    
  thinking_process:
    president:
      - 受け取った要求の要点を整理
      - boss1に依頼できる作業を検討
      - プロジェクト全体の方向性を決定
    boss1:
      - 指示内容を3つ以上のタスクに分解
      - プロジェクトの性質に応じてworkerの役割を決定
      - 各workerに適切な専門領域を割り当て
      - リスクと対策を洗い出す
    workers:
      - 割り当てられた専門領域での作業を理解
      - 担当タスクの詳細を把握
      - 必要なリソースと工数を見積もる
      - 実装とドキュメント作成を並行実施

  mutual_cooperation:
    principle: 基本フローを守りつつ、相互連携を重視
    scenarios:
      file_operation:
        condition: ファイル・ディレクトリ操作時
        action: 他メンバーの作業確認必須
      problem_occurrence:
        condition: 問題発生時
        action: 基本フローに従い上位者に報告
```

## メッセージ送信
```yaml
message_protocol:
  command: './bin/agent-send [recipient] "[message]"'
  format:
    greeting: "あなたは[役割名]です。"
    content: "[具体的な指示内容]"
    deadline: "約X分で実施"
    
  required_response:
    format: "了解。[役割名]です。[理解内容]。[作業内容]を約X分で実施。"
    timeout: 3分
    
  examples:
    good_example:
      command: './bin/agent-send boss1 "あなたはboss1です。ユーザー認証機能の実装をお願いします。約30分で実施。"'
      response: "了解。boss1です。ユーザー認証機能の実装を理解しました。worker割り当てと進捗管理を約30分で実施。"
    bad_example:
      command: './bin/agent-send worker1 "実装して"'  # ❌ 階層違反、詳細不足
```

## 優先順位ルール
```yaml
priority_rules:
  critical:
    - 報告義務: 3分以内の応答は絶対厳守
    - 階層遵守: 指揮系統の厳守
    - 安全確保: ホスト環境を汚染しない
    
  important:
    - ドキュメント作成: 各段階での文書化
    - 品質管理: コードレビューとテスト実施
    - 進捗報告: 30分ごとの状況共有
    
  optional:
    - 追加機能: ユーザー要望に応じて検討
    - 最適化: パフォーマンス改善
```

## エラーハンドリング
```yaml
error_handling:
  timeout_error:
    condition: 3分間応答なし
    actions:
      - step1: 再送信を実施
      - step2: 上位者に報告
      - step3: 代替workerへの再割り当て検討
      
  file_conflict:
    condition: 同一ファイルの競合
    actions:
      - step1: 即座に作業停止
      - step2: boss1に報告
      - step3: 調整後に作業再開
      
  implementation_error:
    condition: 実装中のエラー発生
    actions:
      - step1: エラー内容を詳細に記録
      - step2: 自己解決を試みる（最大2回）
      - step3: 解決不可の場合は上位者に報告
```

## プロジェクトを進める上での注意事項

### プロジェクト名
```yaml
project_naming:
  responsibility: president
  timing: 作業開始時に必ず決定
  format: "[機能名]-[日付]" または "[ユーザー指定名]"
  
  reopening_existing:
    action: 過去プロジェクト一覧を提示して確認
    command: "ls projects/"
```

### プロジェクト構造
```yaml
project_structure:
  base_path: "projects/<project_name>/"
  
  directories:
    workspace:
      description: 実際の作業ディレクトリ（git worktree対応）
      subdirs:
        president: メインリポジトリ管理
        boss1: 統合作業用worktree
        worker1: worker1専用worktree（役割はプロジェクトごとに決定）
        worker2: worker2専用worktree（役割はプロジェクトごとに決定）
        worker3: worker3専用worktree（役割はプロジェクトごとに決定）
        
    checkpoint:
      description: プロジェクト専用チェックポイント
      naming: "YYYY-mm-DD_HHMMSS.md"
      
    instructions:
      description: プロジェクト固有指示書
      files:
        - president.md    # プロジェクト固有ビジョン
        - boss.md        # プロジェクト固有チーム体制
        - worker{N}.md   # worker固有専門領域
        - setup-wizard.md # 初期設定ウィザード
        
    config:
      description: プロジェクト設定
      files:
        - project.conf  # 基本設定（名前、worker数等）
        
    shared:
      description: プロジェクト共有リソース
      subdirs:
        - scripts/    # 共通スクリプト
        - templates/  # テンプレート
```

### プロジェクト初期設定
```yaml
project_initialization:
  detection: ".needs-setup ファイルの存在を確認"
  
  auto_wizard:
    trigger: 新規プロジェクト初回president起動時
    reference: "@instructions/president-init.md"
    wizard_file: "projects/{project}/instructions/setup-wizard.md"
    
  setup_process:
    1_collect_info: "setup-wizard.mdの質問で情報収集"
    2_update_instructions: "収集した情報で各指示書を更新"
    3_remove_flag: ".needs-setupファイルを削除"
    4_notify_team: "boss1に設定完了を通知"
    
  required_info:
    - プロジェクトの目的とビジョン
    - ターゲットユーザー
    - 成功基準
    - 技術スタック
    - 各workerの専門領域
    - 開発方針とコーディング規約
```

### 作業ディレクトリ
```yaml
working_directories:
  president:
    path: "workspace/president/"
    purpose: メインリポジトリ管理
    
  boss1:
    path: "workspace/boss1/"
    purpose: 統合作業実施
    
  workers:
    pattern: "workspace/worker[1-3]/"
    purpose: 機能別ブランチで独立作業
```

### 作業完了時のチェックポイント
```yaml
checkpoint_management:
  responsibility: president
  timing:
    - 各作業セッション終了時
    - 重要なマイルストーン達成時
    - ユーザーセッション終了時
    
  checkpoint_content:
    required_sections:
      - プロジェクト状況サマリー
      - 完了タスク一覧
      - 未完了タスク一覧
      - 次回再開時の注意事項
      - 各workerの最終状態
      
  file_location: "projects/<project_name>/checkpoint/"
  
  collection_process:
    - step1: boss1に進捗情報収集を依頼
    - step2: 各workerからの報告を統合
    - step3: チェックポイントファイル作成
    
  startup_process:
    - step1: 最新チェックポイントを確認
    - step2: プロジェクト状況を理解
    - step3: 作業再開の準備
```

### 仮想環境
```yaml
virtual_environment:
  python:
    tool: uv
    setup_commands:
      - "curl -LsSf https://astral.sh/uv/install.sh | sh"  # 初回のみ
      - "uv venv"  # 仮想環境作成
      - "source .venv/bin/activate"  # 環境有効化
    package_install: "uv pip install [package]"  # pipの代わりにuv pip使用
    location: "workspace/*/.venv/"
    benefits:
      - 10-100倍高速なパッケージインストール
      - 依存関係の解決が高速
      - pip互換で学習コスト低
    
  nodejs:
    tool: node_modules（ローカルインストール）
    location: "workspace/*/node_modules/"
    
  principle: ホスト環境を汚染しない
  requirement: 各worktreeで独立した環境を維持
```

## プロンプトチェーン例
```yaml
prompt_chain_examples:
  new_feature_request:
    step1_president:
      action: プロジェクト名決定
      message: './bin/agent-send boss1 "あなたはboss1です。プロジェクト名: user-auth-feature..."'
      
    step2_boss1:
      action: タスク分解と役割割り当て
      role_assignment_example:
        # プロジェクトの性質に応じて柔軟に役割を割り当て
        web_app_project:
          worker1: フロントエンド担当
          worker2: バックエンド担当
          worker3: テスト・インフラ担当
        data_analysis_project:
          worker1: データ収集・前処理担当
          worker2: 分析・モデリング担当
          worker3: 可視化・レポート担当
        cli_tool_project:
          worker1: コア機能実装担当
          worker2: UI/UX・ヘルプ担当
          worker3: テスト・ドキュメント担当
      messages:
        - './bin/agent-send worker1 "あなたはworker1です。[プロジェクトに応じた担当領域]の実装..."'
        - './bin/agent-send worker2 "あなたはworker2です。[プロジェクトに応じた担当領域]の実装..."'
        - './bin/agent-send worker3 "あなたはworker3です。[プロジェクトに応じた担当領域]の実装..."'
        
    step3_workers:
      action: 並行作業実施
      report_interval: 30分
      
    step4_boss1:
      action: 統合とレビュー
      message: './bin/agent-send president "統合完了。全機能正常動作確認..."'
      
    step5_president:
      action: チェックポイント作成
      output: "projects/user-auth-feature/checkpoint/2025-01-18_143000.md"
```

## Workerの役割分担ガイドライン
```yaml
worker_role_assignment:
  principle: プロジェクトの性質に応じてboss1が最適な役割分担を決定
  
  consideration_factors:
    - プロジェクトの種類（Web、CLI、データ分析、など）
    - 必要な技術スタック
    - タスクの複雑さと依存関係
    - 並行作業の可能性
    
  assignment_patterns:
    layer_based:
      description: レイヤーごとに分担（一般的なWebアプリ向け）
      example: [フロントエンド, バックエンド, インフラ/テスト]
      
    feature_based:
      description: 機能ごとに分担（独立性の高い機能群向け）
      example: [認証機能, データ管理機能, レポート機能]
      
    phase_based:
      description: 開発フェーズごとに分担（段階的開発向け）
      example: [設計・プロトタイプ, 実装, テスト・ドキュメント]
      
    skill_based:
      description: 専門スキルごとに分担（特殊技術が必要な場合）
      example: [AI/ML専門, セキュリティ専門, UX/デザイン専門]
      
  dynamic_adjustment:
    - タスクの進捗に応じて役割を再割り当て可能
    - workerの負荷バランスを考慮して調整
    - 新たな要求に応じて専門領域をシフト
```

## 成功基準
```yaml
success_criteria:
  communication:
    - 全メッセージが3分以内に応答される
    - 階層構造が守られている
    - 報告内容が具体的で明確
    
  implementation:
    - 要求機能が完全に実装されている
    - テストが通っている
    - ドキュメントが最新化されている
    
  collaboration:
    - ファイル競合が発生していない
    - プロジェクトに応じた適切な役割分担がされている
    - 知識共有が行われている
```