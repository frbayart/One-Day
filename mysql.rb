require 'rubygems'
require 'mysql.bundle'

puts Mysql::VERSION
#my = Mysql.new(hostname, username, password, databasename)
con = Mysql.new('FIXME_HOST', 'FIXME_USER', 'FIXME_PASS', 'FIXME_DB')
rs = con.query('select * from `domains_list` where `domainname` not like "%arpa" limit 0, 5')
rs.each_hash do |h|
   puts h['domainname']
end
con.close


