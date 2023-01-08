# Everyday use kanji #

*   Created : 2020-05-16
*   Last modified : 2023-01-08

## Features ##

*   Provides lists of everyday use kanji characters
*   Sourced from official information provided by the government agencies of Japan

## Contents ##

*   regular_use_utf8.csv and regular_use_force_2byte_codepoint_utf8.csv
    *   2136 kanjis for everyday use, announced officially by the Japanese Ministry of Education in 2010 ( 文化庁：常用漢字表 https://www.bunka.go.jp/kokugo_nihongo/sisaku/joho/joho/kakuki/14/tosin02/index.html )
*   personal_name_utf8.csv
    *   Additional 863 kanjis for personal name, announced officially by the Japanese Ministry of Justice ( 法務省：子の名に使える漢字 http://www.moj.go.jp/MINJI/minji86.html )
*   imgui/GetGlyphRangesJapanese.cpp, imgui/GetGlyphRangesJapanese_standalone.cpp
    *   Alternative implementation of ImGui::GetGlyphRangesJapanese() ( https://github.com/ocornut/imgui ) that can handle 2999 kanjis correctly
*   scripts/*.rb, src/**/*.rb, imgui/*.rb
    *   Ruby scripts used to obtain data and generate derivatives
    *   Run update.cmd (Windows) / update.sh (macOS) to regenerate codes

## Sources ##

This project uses official information provided by the government agencies of Japan.

**See 'LICENSE' for the terms of use.**

## Notes ##

### 2136, 𠮟 or 叱 (in regular_use.csv) ###

The only difference between 'regular_use_utf8.csv' and 'regular_use_force_2byte_codepoint_utf8.csv' is the character in the last line.

*   'regular_use_utf8.csv'

        2136,𠮟

*   'regular_use_force_2byte_codepoint_utf8.csv'

        2136,叱

*   𠮟 (codepoint 0x20b9f(==134047), encoded as F0 A0 AE 9F in UTF-8):
    *   was added as the regular-use kanjis in 2010.
    *   is the only regular use kanji that its codepoint *exceeds 2 bytes*.
*   叱 (codepoint 0x53f1(==21489), encoded as E5 8F B1 in UTF-8):
    *   is the traditional form of 「𠮟」.
    *   has been used before the modern form 「𠮟」 was added, and can be represented its codepoint in 2 bytes.

'regular_use_force_2byte_codepoint_utf8.csv' may be useful for environments that maintain codepoints with 2-byte storage (e.g. ImGui compiled with 'sizeof(ImWchar) == 2').

----------------------------------------------------------------------------------------------------

## 特徴 ##

*   日常利用する漢字のリスト
*   法務省・文化庁の提供する公式データを利用

## 内容 ##

*   regular_use_utf8.csv and regular_use_force_2byte_codepoint_utf8.csv
    *   常用漢字2136字のリスト ( 文化庁：常用漢字表 https://www.bunka.go.jp/kokugo_nihongo/sisaku/joho/joho/kakuki/14/tosin02/index.html )
*   personal_name_utf8.csv
    *   常用漢字外の人名用漢字863字 ( 法務省：子の名に使える漢字 http://www.moj.go.jp/MINJI/minji86.html )
*   imgui/GetGlyphRangesJapanese.cpp, imgui/GetGlyphRangesJapanese_standalone.cpp
    *   上記データを利用して ImGui ( https://github.com/ocornut/imgui ) の ImGui::GetGlyphRangesJapanese() の実装を修正し 2999 文字が正しく扱えるようにしたもの
*   scripts/*.rb, src/**/*.rb, imgui/*.rb
    *   以上を生成する Ruby スクリプト

## 情報の取得先 ##

法務省・文化庁の提供する公式データ

** 利用する際は 'LICENSE' を確認すること **

## メモ ##

### 2136, 𠮟 もしくは 叱 について (regular_use.csv を参照) ###

CSVファイル 'regular_use_utf8.csv' と 'regular_use_force_2byte_codepoint_utf8.csv' の差は最後の行にあるこの1文字のみ：

*   'regular_use_utf8.csv'

        2136,𠮟

*   'regular_use_force_2byte_codepoint_utf8.csv'

        2136,叱

*   𠮟 (コードポイント 0x20b9f(==134047), UTF-8 では F0 A0 AE 9F としてエンコード):
    *   2010年に常用漢字に追加
    *   現時点の常用漢字でコードポイントの保持に2バイトを*越える*領域が必要になる唯一の文字
*   叱 (コードポイント 0x53f1(==21489), UTF-8 では E5 8F B1 としてエンコード):
    *   「𠮟」の旧字体
    *   「𠮟」の追加前に使われてきたもので2バイトでコードポイントを保持可能

'regular_use_force_2byte_codepoint_utf8.csv' などは2バイトの変数でコードポイントを保持する環境での利用を想定している (例: 'sizeof(ImWchar) == 2' となるようコンパイルされたImGui)
