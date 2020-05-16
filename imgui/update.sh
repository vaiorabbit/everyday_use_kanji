#!/bin/sh

ruby generate_imgui_draw_implementation.rb ../regular_use_force_2byte+personal_name.txt > GetGlyphRangesJapanese.cpp
ruby generate_standalone_implementation.rb ../regular_use_force_2byte+personal_name.txt -opt > GetGlyphRangesJapanese_standalone.cpp
