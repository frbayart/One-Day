require 'rubygems'
require 'twitter'

Twitter::Search.new('chimay bleu').each { |r| puts r.text }