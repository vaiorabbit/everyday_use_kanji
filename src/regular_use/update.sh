#!/bin/sh
sh 00_download_pdf.sh
sh 01_extract_text.sh
ruby 02_cleanup_text.rb
