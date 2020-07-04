# Usage: > ruby generate_standalone_implementation.rb ../regular_use_force_2byte_codepoint+personal_name_utf8.txt -opt > GetGlyphRangesJapanese_standalone.cpp
require 'erb'
require "stringio"

def calculate_codepoint_pairs(characters_array_src, optimize=false)
  codepoint_pairs = []
  characters_array = optimize ? characters_array_src.sort_by {|chr| chr.codepoints[0]} : characters_array_src
  characters_array.each do |chr|
    codepoint_pairs << [chr.codepoints[0], chr.codepoints[0]]
  end

  if optimize
    codepoint_pairs_opt = []
    codepoint_pairs_opt << codepoint_pairs.shift
    current_index = 0
    codepoint_pairs.each do |pair|
      if pair[0] - codepoint_pairs_opt[current_index][1] == 1
        codepoint_pairs_opt[current_index][1] = pair[0]
      else
        codepoint_pairs_opt << pair
        current_index += 1
      end
    end
    return codepoint_pairs_opt
  else
    return codepoint_pairs
  end
end

if __FILE__ == $0
  # Analyze command line arguments
  list_filename = ARGV[0] # e.g.) regular_use_force_2byte_codepoint+personal_names_utf8.txt
  return if ARGV[0] == nil
  optimize = ARGV[1] == '-opt' ? true : false

  template_filename = "GetGlyphRangesJapanese_standalone.cpp.template"

  # ERB : template engine in the Ruby standard library
  erb_template = IO.read(template_filename)
  renderer = ERB.new(erb_template)

  # Convert list of kanjis into the array of codepoint pair
  characters = IO.read(list_filename).chars
  codepoint_pairs = calculate_codepoint_pairs(characters, optimize)

  # Build the actual string of accumulative offsets used in the C++ implementation code
  japanese_ranges_buf = StringIO.new("")
  codepoint_pairs.each_with_index do |pair, i|
    japanese_ranges_buf << "        " # indent
    japanese_ranges_buf << "0x#{pair[0].to_s(16).upcase()}, 0x#{pair[1].to_s(16).upcase()}, // "
    (pair[1] - pair[0] + 1).times do |i|
      japanese_ranges_buf << "#{(pair[0] + i).chr(Encoding::UTF_8)}"
    end
    japanese_ranges_buf << "\n"
  end

  # Write C++ implementation to the standard output
  japanese_ranges_code = japanese_ranges_buf.string
  output = renderer.result()

  puts output
end
