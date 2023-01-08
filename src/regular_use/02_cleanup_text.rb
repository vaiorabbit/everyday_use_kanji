# coding: utf-8
# frozen_string_literal: true

# Usage: $ ruby 02_cleanup_text.rb

if __FILE__ == $PROGRAM_NAME
  kanjis = ''
  File.open('./joyokanjihyo_20101130.txt', 'r') do |raw_text|
    lines = IO.readlines(raw_text)
    lines.filter! {|raw_line| raw_line[0] != ' ' } # remove lines start with space
    lines.filter! {|raw_line| !raw_line.strip.empty? } # remove empty lines
    lines.collect! {|raw_line| raw_line.lstrip } # remove line feed found as left most character
    lines.collect! {|raw_line| raw_line[0] } # remove line feed found as left most character
    lines.shift # remove first line "漢   字"
    raise RuntimeError 'The number of filtered lines does not match the number of Joyo Kanji' if lines.length != 2136
    kanjis = lines.join
  end
  File.open('./joyokanji_2136.txt', 'w') do |clean_text|
    clean_text << kanjis
  end
end
