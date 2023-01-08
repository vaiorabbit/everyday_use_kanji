# coding: utf-8
# frozen_string_literal: true

# Usage: $ ruby generate_csv.rb [--force_2byte_codepoint]

if __FILE__ == $PROGRAM_NAME
  force_2byte_codepoint = ARGV[0] == '--force_2byte_codepoint'
  File.open('../src/regular_use/regular_use.txt', 'r') do |input_file|
    chars = (IO.read(input_file)).chars
    chars = chars.sort {|c0, c1| c0.ord <=> c1.ord}
    File.open("../regular_use#{force_2byte_codepoint ? '_force_2byte_codepoint' : ''}_utf8.csv", 'w') do |dst_file|
      chars.each_with_index do |char, idx|
        ucs = char.codepoints[0]
        # Special care to replace "𠮟" (codepoint 0x20b9f, added in 2010) into traditional form "叱" (codepoint 0x53f1, widely used still now)
        # - Its codepoint cannot be represented in 2-byte variable (e.g.: wchar_t).
        # - We can't find any link/information to the traditional form "叱" (codepoint 0x53f1) from entry, so we have to write this branching.
        ucs = 0x53F1 if force_2byte_codepoint && ucs == 0x20B9F
        dst_file << "#{idx + 1},#{ucs.chr(Encoding::UTF_8)}"
        dst_file << "\n" unless char == chars.last
      end
    end
  end

  File.open('../src/personal_name/personal_name.txt', 'r') do |input_file|
    chars = (IO.read(input_file)).chars
    chars = chars.sort {|c0, c1| c0.ord <=> c1.ord}
    File.open('../personal_name_utf8.csv', 'w') do |dst_file|
      chars.each_with_index do |char, idx|
        dst_file << "#{idx + 1},#{char}"
        dst_file << "\n" unless char == chars.last
      end
    end
  end
end
