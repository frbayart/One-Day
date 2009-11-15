require 'rubygems'
require 'openssl'
require 'net/imap'

Net::IMAP.debug = false
begin
  imap = Net::IMAP.new('FIXME_SERVER', 991 , true)
rescue Exception => e
  p "Error: could not create folder: #{e}"
  exit 1
end
imap.capability()
imap.authenticate('LOGIN', 'FIXME_USER', 'FIXME_PASS')
imap.examine('INBOX')
imap.search(["RECENT"]).each do |message_id|
 envelope = imap.fetch(message_id, "ENVELOPE")[0].attr["ENVELOPE"]
 puts "#{envelope.from[0].name}: \t#{envelope.subject}"
end
submit_check_result remote 'service name' 0 'OK test'