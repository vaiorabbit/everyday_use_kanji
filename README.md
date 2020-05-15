# Contents #

*   regular_use.csv
    *   2136 kanjis for everyday use, announced officially by the Japanese Ministry of Education in 2010 ( 文化庁：常用漢字表 https://www.bunka.go.jp/kokugo_nihongo/sisaku/joho/joho/kakuki/14/tosin02/index.html )
*   personal_name_1.csv and personal_name_2.csv 
    *   863 kanjis for personal name, announced officially by the Japanese Ministry of Justice ( 法務省：子の名に使える漢字 http://www.moj.go.jp/MINJI/minji86.html )

# Sources #

This project uses the dataset provided by Information-technology Promotion Agency (IPA) Japan.
See 'LICENSE' for the terms of use.

*   MJ文字情報API
    *   https://mojikiban.ipa.go.jp/mji/
*   MJ文字情報一覧表
    *   https://mojikiban.ipa.go.jp/1311.html

[NOTE] The acronym "MJ" stands for "Moji-Joho (文字情報)", meaning "character infromation".

# Notes #

## 830,𠮟,叱 (regular_use.csv) ##

'regular_use_2byte.txt' may be useful for environments with 'sizeof(wchar_t) == 2'.
In 'regular_use_2byte.txt', a kanji 「𠮟」 in 'regular_use.txt' is substituted to the traditional form 「叱」.
It's the only difference between 'regular_use.txt' and 'regular_use_2byte.txt'.

*   「𠮟 (codepoint 134047, #o405637, #x20b9f)」:
   *   was added as the regular-use kanjis in 2010.
   *   is the only regular use kanji that *exceeds 2 bytes*.
*   「叱 (codepoint 21489, #o51761, #x53f1)」:
    *   is the traditional form of 「𠮟」.
    *   have been used before the modern form 「𠮟」 was added, and can be represented in 2 bytes.

