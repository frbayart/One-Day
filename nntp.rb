require 'rubygems'
require 'nntp'


Net::NNTP.start('news-europe.giganews.com', 563, 'FIXME_USER', 'FIXME_PASS') do |nntp|
    puts o 
	#nntp.post msgstr
end
