# NixOS Observability Configuration
#
# このFlakeはNixOS監視システムの設定ファイルを提供します。
# - Prometheusアラートルール
# - Grafanaダッシュボード
# - Fluent Bit設定ファイル生成関数
{
  description = "NixOS Observability Configuration - Alert rules, dashboards, and Fluent Bit config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {
      assets = {
        alertRules = ./assets/alert-rules.nix;
        dashboards = ./assets/dashboards;
      };

      lib = {
        fluentBit = {
          generator = ./lib/fluent-bit/generator.nix;
        };
      };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
