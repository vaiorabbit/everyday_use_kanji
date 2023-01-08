You can find resoures to generate "personal_name.txt":
* several shell scripts I used to get source PDF file and images for OCR
* text files I made from images
* ruby script to convert text files into "personal_name.txt"

* Make sure you can run `ruby` and `pdftoppm`. `pdftoppm` can be set up via Homebrew on macOS:
  * `$ brew install poppler`
* Then run:
  * `download_pdf.sh` to get the source file `001131003.pdf`
  * `extract_image.sh` to get images from source PDF file.
  * `generate_list.rb` to get `personal_name.txt`


## Notes on how I prepared `001131003_page-1.txt`, etc.

Unfortunately `001131003.pdf` contains its information with own custom font encoding, meaning that we cannot extract characters from this file.

To make 001131003_page-1.txt ~ 001131003_page-5.txt, I followed these steps:

1. Convert all pages of `001131003.pdf` into images (`extract_image.sh`)
2. Send these images to my iPhone via Airdrop
3. Extract texts with OCR feature of [Microsoft Pix](https://www.microsoft.com/ja-jp/microsoftpix)
   * This may seem to be too roundabout though, extracted results I got were a bit better than other solutions.
4. Send extract texts back to macOS
5. Compare the PDF images to the scanned result and fix incorrectly scanned text by hand.
   * These sites were useful to search confusable variations of kanji characters:
     * Unicode Utilities: Character Properties
       * <https://util.unicode.org/UnicodeJsps/character.jsp>
     * Unihan Database Lookup
       * <https://www.unicode.org/charts/unihan.html>
     * GlyphWiki
       * <https://glyphwiki.org/wiki/>
   * From these sites we can also find the codepoint of each characters. To input correct character, I used codepoint information for [Emacs' built-in function called insert-char](https://www.gnu.org/software/emacs/manual/html_node/emacs/Inserting-Text.html) (`C-x 8 RET`). We can directly input one character by using codepoint information.
