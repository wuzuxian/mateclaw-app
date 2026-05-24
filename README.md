# mateclaw_app

Mateclaw Flutter app.

## 开发环境初始化

首次拉取项目后执行：

```sh
flutter pub get
sh scripts/install_git_hooks.sh
```

`install_git_hooks.sh` 会把本仓库的 Git hook 目录配置为 `.githooks`，使提交前检查自动生效。

## 代码入库检测

项目通过 `custom_lint` 和 Git pre-commit hook 落地开发规约。提交代码时会自动执行：

```sh
dart run scripts/check_project_rules.dart --staged
flutter analyze
dart run custom_lint
```

当前检测覆盖：

- 禁止直接使用 `Navigator.push` 等命令式导航。
- 禁止硬编码 GoRouter 路由路径。
- 禁止 ViewModel 依赖 `BuildContext` 或 UI 库。
- 禁止 View 层直接 import Service / Repository。
- 禁止常见用户可见文案硬编码。
- 检查规约要求的基础依赖是否存在。

如需手动执行完整验证：

```sh
dart run scripts/check_project_rules.dart
flutter analyze
dart run custom_lint
flutter test
```

## 开发规约

每次开始开发前，先阅读项目开发规约，确认当前任务涉及的路由、架构、国际化、布局和测试规则。

- [项目开发规约](docs/1.项目开发规约.md)
- [代码入库检测探针](docs/2.代码入库检测探针.md)
