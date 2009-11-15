require 'rubygems'
require 'Dnsruby'
require 'mysql.bundle'

con = Mysql.new('FIXME_HOST', 'FIXME_USER', 'FIXME_PASS', 'FIXME_DB')

res   = Dnsruby::Resolver.new

rs = con.query('select * from `domains_list` where `domainname` not like "%arpa" AND `checkedDate` < NOW() - INTERVAL 1 DAY and `domaintype`="master" limit 0, 15')
rs.each_hash do |h|
  dname = h['domainname']
  begin
    ns_req = res.query(dname, 'NS')
  rescue Exception => e
    print "DELETE ", dname, e, " \n"
    con.query("update `domains_list` set `checkedState`='ERROR',`checkedDate`=NOW() where `domainname`='#{dname}'")
    next
  end
  if (ns_req.header.ancount == 0)
    print "No nameservers found for #{dname}\n"
    con.query("update `domains_list` set `checkedState`='ERROR',`checkedDate`=NOW() where `domainname`='#{dname}'")
    next
  end 

  (ns_req.answer.select {|r| r.type == "NS"}).each do |nsrr| ns = nsrr.domainname
    begin
      if ( ns.to_s =~ /^ns[1-3].ipow.net$/ )
        print "OK ", dname, ns, " \n"
        con.query("update `domains_list` set `checkedState`='OK',`checkedDate`=NOW() where `domainname`='#{dname}'")
        break
      else
        print "ERROR ", dname, ns," \n"
        con.query("update `domains_list` set `checkedState`='ERROR',`checkedDate`=NOW() where `domainname`='#{dname}'")
      end
    rescue Exception => e
      print e
    end
  end
end
con.close