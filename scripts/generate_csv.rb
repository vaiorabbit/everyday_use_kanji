# coding: utf-8
# frozen_string_literal: true

# Usage: $ ruby generate_csv.rb [--force_2byte]

require 'json'
require 'csv'

if __FILE__ == $PROGRAM_NAME
  force_2byte = ARGV[0] == '--force_2byte'
  File.open('../mj_source.json', 'r') do |json_file|
    json = JSON.parse(IO.read(json_file))
    personal_name_kanji_entries = json['results'].select { |entry| entry['漢字施策']['常用漢字'] == false && entry['漢字施策']['人名用漢字'] == true }
    regular_use_kanji_entries = json['results'].select { |entry| entry['漢字施策']['常用漢字'] == true }
    regular_use_kanji_entries -= personal_name_kanji_entries

    File.open("../regular_use#{force_2byte ? '_force_2byte' : ''}.csv", 'w') do |dst_file|
      regular_use_kanji_entries.each_with_index do |entry, i|
        ucs = entry['UCS']['対応するUCS'].gsub(/^U\+/, '').to_i(16)
        # Special care to replace "𠮟" (codepoint 0x20b9f, added in 2010) into traditional form "叱" (codepoint 0x53f1, widely used still now)
        # - Its codepoint cannot be represented in 2-byte variable (e.g.: wchar_t).
        # - We can't find any link/information to the traditional form "叱" (codepoint 0x53f1) from entry, so we have to write this branching.
        ucs = 0x53F1 if force_2byte && ucs == 0x20B9F
        dst_file.print("#{i + 1},#{ucs.chr(Encoding::UTF_8)}")
        dst_file.puts unless i == regular_use_kanji_entries.length - 1
      end
    end

    File.open('../personal_name.csv', 'w') do |dst_file|
      personal_name_kanji_entries.each_with_index do |entry, i|
        has_variation = !entry['UCS']['対応する互換漢字'].nil?
        ucs = if has_variation
                entry['UCS']['対応する互換漢字'].gsub(/^U\+/, '').to_i(16)
              else
                entry['UCS']['対応するUCS'].gsub(/^U\+/, '').to_i(16)
        end
        dst_file.print("#{i + 1},#{ucs.chr(Encoding::UTF_8)}")
        dst_file.puts unless i == personal_name_kanji_entries.length - 1
      end
    end
  end
end
