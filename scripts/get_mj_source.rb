# coding: utf-8
# frozen_string_literal: true

#
# Usage: $ ruby get_mj_source.rb
# Ref.: MJ文字情報API https://mojikiban.ipa.go.jp/mji/
#
require 'net/http'
require 'json'

$request_url = URI('https://mojikiban.ipa.go.jp/mji/q')
# $param = { '漢字施策' => '常用漢字' }
$param = { '漢字施策' => '人名用漢字' } # [NOTE] '常用漢字' (regular use kanji) is a subset of '人名用漢字' (kanji for personal name).

if __FILE__ == $PROGRAM_NAME
  $request_url.query = URI.encode_www_form($param)
  responce = Net::HTTP.get_response($request_url)
  if responce.is_a?(Net::HTTPSuccess)
    File.open('../mj_source.json', 'w') do |dst_file|
      dst_file << responce.body
    end
  end
end
