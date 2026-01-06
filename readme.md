# jupyter-dotnet

Singularity を使用した Jupyter Notebook 実行環境です。
[uv](https://github.com/astral.sh/uv) を使用して、高速かつ再現可能な Python パッケージ管理を実現しています。

## 構成

- **Base Image**: Python 3.12 (slim)
- **Package Manager**: [uv](https://github.com/astral-sh/uv)
- **Interactive**: Jupyter Notebook / Shell

## 特徴

- **Singularity/Apptainer**: ホスト OS を汚さず、ポータブルな実行環境を提供。
- **uv**: Python パッケージのインストールと管理を高速化。
- **Jupyter Notebook**: 最先端のデータ分析環境を即座に利用可能。
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
uv run jupyter notebook --ip 0.0.0.0 --no-browser
```

ターミナルに表示される URL (例: `http://127.0.0.1:8888/?token=...`) にブラウザからアクセスしてください。

### 4. パッケージの追加・変更

このプロジェクトでは、環境の再現性を保つためにイメージの再ビルドを推奨しています。

1. `image.def` の `%post` セクションを編集し、`uv add` コマンドなどを追加します。
2. 再度 `make build` を実行してイメージを更新します。

## 開発のヒント

- **データの永続化**: `notebooks/` ディレクトリ配下のファイルはホスト OS と共有されるため、コンテナを終了しても消えることはありません。
- **カスタム設定**: `rich_console` が有効な場合、`container_bashrc` を編集することでコンテナ内のエイリアスなどをカスタマイズできます。

## ライセンス

[license.txt](license.txt) を参照してください。
