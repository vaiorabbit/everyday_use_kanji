#!/bin/sh

ruby get_mj_source.rb
ruby generate_csv.rb
ruby generate_csv.rb --force_2byte_codepoint
ruby generate_list.rb
