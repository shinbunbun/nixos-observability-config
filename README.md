# nixos-observability-config

NixOS監視システムの設定ファイルを提供するFlakeです。

## 概要

このリポジトリには以下の設定ファイルが含まれています：

- **Prometheusアラートルール** - システム監視用のアラート定義
- **Grafanaダッシュボード** - メトリクス可視化用のダッシュボード
- **Lokiルール** - ログベースのアラート定義
- **SNMPエクスポーター設定** - RouterOS監視用のSNMP設定
- **Fluent Bit設定生成関数** - ログ収集設定の生成

## 使用方法

```nix
{
  inputs = {
    nixos-observability-config = {
      url = "github:shinbunbun/nixos-observability-config";
    };
  };
}
```

### 利用可能なアセット

```nix
# Prometheusアラートルール
inputs.nixos-observability-config.assets.alertRules

# Grafanaダッシュボード
inputs.nixos-observability-config.assets.dashboards

# Lokiルール
inputs.nixos-observability-config.assets.lokiRules

# SNMPエクスポーター設定
inputs.nixos-observability-config.assets.snmpConfig
```

### Fluent Bit設定生成

```nix
fluentBitConfigs = import inputs.nixos-observability-config.lib.fluentBit.generator {
  inherit pkgs;
  cfg = yourConfig;
  hostname = config.networking.hostName;
};
```

## 関連リポジトリ

- [nixos-observability](https://github.com/shinbunbun/nixos-observability) - NixOS監視スタックのモジュール

## ライセンス

MIT License
