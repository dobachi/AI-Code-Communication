# プロジェクトテンプレート

このディレクトリには、新規プロジェクト作成時に使用されるテンプレートが含まれています。

## 階層的指示書構造

```
AI-Code-Communication/
├── instructions/              # システム全体の指示書
│   ├── challenge/            # 創造的モード
│   ├── stable/              # 安定モード
│   └── iterative/           # 段階的モード
│       └── worker.md        # システムレベルのworker指示
│
└── projects/
    ├── templates/
    │   └── instructions/     # プロジェクトテンプレート
    │       └── worker.md     # 新規プロジェクト用のデフォルトworker指示
    │
    └── <project-name>/
        └── instructions/     # プロジェクト固有の指示書
            └── roles/
                ├── worker1.md # 生成されたworker1用指示書
                ├── worker2.md # 生成されたworker2用指示書
                └── worker3.md # 生成されたworker3用指示書
```

## 優先順位

1. **プロジェクト固有指示書** (`projects/<name>/instructions/roles/worker*.md`)
2. **テンプレート指示書** (`projects/templates/instructions/worker.md`)
3. **システム指示書** (`instructions/<mode>/worker.md`)

## カスタマイズ方法

1. `instructions/worker.md` を編集して、すべての新規workerのデフォルト動作を変更
2. プロジェクト固有の変更は、各プロジェクトの `instructions/roles/` で行う

## テンプレート変数

テンプレート内で以下の変数が使用可能：
- `{{WORKER_NUMBER}}` - worker番号（1, 2, 3...）
- `{{PROJECT_NAME}}` - プロジェクト名
- `{{CREATED_DATE}}` - 作成日
- `{{WORKER_COUNT}}` - 総worker数

## 使用例

```markdown
# あなたはworker{{WORKER_NUMBER}}です

プロジェクト: {{PROJECT_NAME}}
作成日: {{CREATED_DATE}}
総worker数: {{WORKER_COUNT}}
```