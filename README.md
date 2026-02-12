## This is Flutter version of L'amour

### React Native version => See [L'amour](https://github.com/vampuke/LamourReact)

## Packages

* [shared_preferences](https://pub.flutter-io.cn/packages/shared_preferences) Save key-value pairs, like Localstorage
* [dio](https://pub.flutter-io.cn/packages/dio) Http client
* [dio_cookie_manager](https://pub.flutter-io.cn/packages/dio_cookie_manager) Manage cookies
* [fluttertoast](https://pub.flutter-io.cn/packages/fluttertoast) Show toast
* [json_annotation](https://pub.flutter-io.cn/packages/json_annotation) Encode or decode JSON to dart
* [flutter_redux](https://pub.flutter-io.cn/packages/flutter_redux) Flutter version of redux
* [connectivity](https://pub.flutter-io.cn/packages/connectivity) To detect whether connect to internet
* [flutter_spinkit](https://pub.flutter-io.cn/packages/flutter_spinkit) Show spinkit when loading
* [event_bus](https://pub.flutter-io.cn/packages/event_bus) Pass event globally
* [package_info](https://pub.flutter-io.cn/packages/package_info) Get current package info
* [path_provider](https://pub.flutter-io.cn/packages/path_provider) To save downloaded apk, used for upgrade
* [install_plugin](https://pub.flutter-io.cn/packages/install_plugin) Install apk, used for upgrade
* [permission_handler](https://pub.flutter-io.cn/packages/permission_handler) Request permission for upgrade, like storage permission
* [jpush_flutter](https://pub.flutter-io.cn/packages/jpush_flutter) Receive push notification
* [flutter_rating_bar](https://pub.flutter-io.cn/packages/flutter_rating_bar) Display rating
## GitHub Actions 自动构建与发布

已添加工作流：`.github/workflows/flutter-build-release.yml`（以可稳定产出 APK 为目标，默认不强制 analyze/test）。

- 推送到 `master/main`：自动构建 Android `apk` 与 `aab`，并上传为 Actions Artifact。
- 推送 tag（如 `v1.0.0`）：在构建后自动创建 GitHub Release，并附加 `apk/aab` 文件。
- 支持手动触发：`workflow_dispatch`。

> 说明：若你需要发布到应用商店，还需额外配置签名与发布凭据（如 keystore、Google Play service account 等）。

## 如何下载构建好的 APK

1. 打开仓库 `Actions` 页面，选择 `Flutter Build APK & Release` 工作流。
2. 点击 `Run workflow`，`build_target` 选 `apk`（只构建 APK，速度更快）或 `both`（同时构建 APK+AAB）；`run_checks` 默认 `false`。
3. 任务成功后，在该次运行页面底部 `Artifacts` 区域下载 `android-apk-<run_number>`。
4. 若是打了 `v*` tag（例如 `v1.0.12`），还会自动创建 GitHub Release，可在 Release 页面直接下载 APK/AAB。


> 兼容旧项目代码：工作流默认使用 Flutter 1.22.6 + Java 8。
