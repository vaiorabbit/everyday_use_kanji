@echo off
setlocal enabledelayedexpansion

ruby generate_imgui_draw_implementation.rb ../regular_use_force_2byte_codepoint+personal_name_utf8.txt > GetGlyphRangesJapanese.cpp
ruby generate_standalone_implementation.rb ../regular_use_force_2byte_codepoint+personal_name_utf8.txt -opt > GetGlyphRangesJapanese_standalone.cpp
