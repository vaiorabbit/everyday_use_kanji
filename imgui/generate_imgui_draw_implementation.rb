# Usage: > ruby generate_imgui_draw_implementation.rb ../regular_use_force_2byte+personal_name.txt > GetGlyphRangesJapanese.cpp
require 'erb'
require "stringio"

def calculate_accumulative_offsets(characters_array, base_codepoint = 0x4e00)
  accumulative_offsets_array = []
  characters_sorted_array = characters_array.sort_by {|chr| chr.codepoints[0]}
  characters_sorted_array.each do |chr|
    ofs = chr.codepoints[0] - base_codepoint
    accumulative_offsets_array << ofs
    base_codepoint += ofs
  end

  return accumulative_offsets_array
end

if __FILE__ == $0
  # Analyze command line arguments
  list_filename = ARGV[0] # e.g.) regular_use_force_2byte+personal_names.txt
  return if ARGV[0] == nil
  base_codepoint = ARGV[1] ? ARGV[1].to_i(16) : 0x4E00
  fold_count = ARGV[2] ? ARGV[2].to_i : 70
  template_filename = "GetGlyphRangesJapanese_imgui_draw.cpp.template"

  # ERB : template engine in the Ruby standard library
  erb_template = IO.read(template_filename)
  renderer = ERB.new(erb_template)

  # Convert list of kanjis into the array of accumulative offsets
  characters = IO.read(list_filename).chars
  accumulative_offsets_array = calculate_accumulative_offsets(characters, base_codepoint)

  # Build the actual string of accumulative offsets used in the C++ implementation code
  accumulative_offsets_buf = StringIO.new("")
  start_new_line = true
  accumulative_offsets_array.each_with_index do |ofs, i|
    if start_new_line
      accumulative_offsets_buf << "        " # indent
      start_new_line = false
    end
    accumulative_offsets_buf << "#{ofs},"
    if i > 0 && i % fold_count == 0
      accumulative_offsets_buf << "\n"
      start_new_line = true
    end
  end

  # Write C++ implementation to the standard output
  base_offset_code = base_codepoint.to_s(16).upcase()
  accumulative_offsets_code = accumulative_offsets_buf.string
  output = renderer.result()

  puts output
end
