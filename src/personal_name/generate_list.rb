# coding: utf-8
# frozen_string_literal: true

kanji_characters = []

['001131003_page-1.txt', '001131003_page-2.txt', '001131003_page-3.txt'].each do |src_name|
  File.open(src_name, 'r:UTF-8') do |input_file|
    lines = IO.readlines(input_file)
    lines.collect! {|line| line.gsub(/　|｜|\n/, '')} # remove "\n", etc
    lines.each do |line|
      kanji_characters.concat line.chars
    end
  end
end

['001131003_page-4.txt', '001131003_page-5.txt'].each do |src_name|
  File.open(src_name, 'r:UTF-8') do |input_file|
    lines = IO.readlines(input_file)
    lines.each_with_index do |line, row|
      line.chars.each_with_index do |char, col|
        next if char == '　' || char == '︵' || char == '︶' || char == "\n" # skip empty characters
        if (1 <= row && row < lines.length - 1)
          next if lines[row-1][col] == '︵' && lines[row+1][col] == '︶' # skip regular use characters
        end
        kanji_characters << char
      end
    end
  end
end

kanji_characters.sort_by! {|chr| chr.codepoints[0]}

File.open('../../personal_name_utf8.txt', 'w:UTF-8') do |dst|
  dst.puts kanji_characters.join
end


