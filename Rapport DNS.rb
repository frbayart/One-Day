require 'rubygems'
require 'mysql.bundle'

MyConfig = YAML.load(IO.read(File.join(File.dirname(__FILE__), "Rapport DNS.yml")))
HOSTNAME = MyConfig["hostname"]
ROOTDN = MyConfig["ldap"]["user"]

puts Mysql::VERSION
#my = Mysql.new(hostname, username, password, databasename)
con = Mysql.new('FIXME_HOST', 'FIXME_USER', 'FIXME_PASS', 'FIXME_DB')
rs = con.query('select * from `domains_list` where `domainname` not like "%arpa" and `checkedState` = "ERROR"')
rs.each_hash do |h|
   puts h['domainname'].strip, " ",h['checkedState'].strip
end
con.close


