# agqr.rb + upload.py
## まずはじめに
agqr.rbの方は[ybenjo/agqr.rb](https://gist.github.com/ybenjo/9904543)さんのソースを参考にしています。

## 使用方法
基本はybenjoさんのREADMEに書いてあるとおりなので少し仕様変更した点を記述します。
(pathはroot直下の/radioを仮定しています)
ファイルをcloneし配置したらcrontabで

`29,59 * * * sleep 55; ruby agqr.rb && python upload.py`

と指定します。

また、同ディレクトリに`file`ディレクトリを作成し`file`ディレクトリ直下に`tmp`ディレクトリを作成します
すると、

- `file`にflvファイル
- `file/tmp`にmp3 or mp4ファイル

が生成されます。

## 必要なもの
- Ruby 2.x系(1.9.xは未確認ですがおそらく動きます)
- rtmpdump
- ffmepeg
- cron
- Python3系
- PyDrive

## config.yaml と　PyDrive使用に必要ファイルについて
- `config.yaml`についてはybenjoさんの説明を参考にしてください
- `movie:true`の機能は実装されています
- PyDriveの認証ファイル系は`/radio`直下に配置してください
- [PyDrive使用方法](https://qiita.com/soup01/items/670107d8454274297b5d)

