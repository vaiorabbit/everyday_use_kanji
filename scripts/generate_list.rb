# coding: utf-8
# frozen_string_literal: true

# Usage: $ ruby generate_list.rb

require 'csv'

if __FILE__ == $PROGRAM_NAME
  regular_use = CSV.read("../regular_use_utf8.csv")
  regular_use_force_2byte_codepoint = CSV.read("../regular_use_force_2byte_codepoint_utf8.csv")
  personal_name = CSV.read("../personal_name_utf8.csv")

  File.open("../regular_use+personal_name_utf8.txt", "w") do |dst_file|
    regular_use.each do |entry| # entry == [index, character]
      dst_file << entry[1]
    end
    personal_name.each do |entry| # entry == [index, character]
      dst_file << entry[1]
    end
  end

  File.open("../regular_use_force_2byte_codepoint+personal_name_utf8.txt", "w") do |dst_file|
    regular_use_force_2byte_codepoint.each do |entry| # entry == [index, character]
      dst_file << entry[1]
    end
    personal_name.each do |entry| # entry == [index, character]
      dst_file << entry[1]
    end
  end
end
