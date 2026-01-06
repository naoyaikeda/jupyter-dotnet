# jupyter-dotnet

.NET Interactive に対応した、Singularity ベースの Jupyter Notebook 実行環境です。
Python の高速パッケージマネージャー [uv](https://github.com/astral.sh/uv) も統合しており、Python と .NET (C#, F#) の両方を単一のノートブックで利用できます。

## 構成

- **Base Image**: `python:3.12-slim`
- **.NET SDK**: `.NET 10.0`
- **Python Package Manager**: `uv`
- **Interactive Environment**: Jupyter Notebook with `.NET Interactive`
- **Shell**: `bash` with `starship` prompt

## 特徴

- **Polyglot Notebook**: C#, F#, PowerShell, Python などを単一のノートブック上で利用可能。
- **Singularity/Apptainer**: ホスト OS を汚さず、ポータブルな実行環境を提供。
- **.NET 10**: 最新の .NET 環境をコンテナ内に構築。
- **uv**: Python パッケージのインストールと管理を高速化。
- **Rich Console**: `starship` プロンプトを統合した、モダンで視認性の高いシェル環境。

## ディレクトリ構成

- `apps/`: アプリケーションコードを配置します。ビルド時にコンテナ内の `/apps` にコピーされます。
- `notebooks/`: Jupyter Notebook ファイル (`.ipynb`) を配置します。コンテナ起動時に `/apps/notebooks` にマウントされ、変更はホスト側に保存されます。
- `image.def`: Singularity コンテナの構成（OS、パッケージ、環境変数など）を定義するファイル。
- `makefile`: ビルドや実行を簡略化するためのコマンド集。
- `container_bashrc`: (`rich_console` 有効時) コンテナ内でのシェル環境をカスタマイズするための設定ファイル。

## 使い方

### 1. イメージのビルド

以下のコマンドを実行して、Singularity イメージ (`jupyter-dotnet.sif`) をビルドします。
※ ビルドには `sudo` 権限、または `fakeroot` が有効な環境が必要です。

```bash
make build
```

### 2. コンテナの起動

ビルドしたイメージを使用して、コンテナ内のシェルを起動します。

```bash
make run
```

### 3. Jupyter Notebook の起動

コンテナ内（または `singularity exec` 経由）で以下のコマンドを実行します。

```bash
cd /apps
jupyter notebook --ip 0.0.0.0 --no-browser
```

ターミナルに表示される URL (例: `http://127.0.0.1:8888/?token=...`) にブラウザからアクセスしてください。
ノートブックを新規作成する際に、カーネルとして `.NET (C#)` や `.NET (F#)` などを選択できます。

### 4. パッケージの追加・変更

このプロジェクトでは、環境の再現性を保つためにイメージの再ビルドを推奨しています。

1. `image.def` の `%post` セクションを編集し、`uv pip install` や `dotnet tool install` コマンドなどを追加します。
2. 再度 `make build` を実行してイメージを更新します。

## 開発のヒント

- **データの永続化**: `notebooks/` ディレクトリ配下のファイルはホスト OS と共有されるため、コンテナを終了しても消えることはありません。
- **カスタム設定**: `rich_console` が有効な場合、`container_bashrc` を編集することでコンテナ内のエイリアスなどをカスタマイズできます。

## ライセンス

[license.txt](license.txt) を参照してください。
