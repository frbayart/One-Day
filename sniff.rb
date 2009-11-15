require 'open-uri'
open('http://www.famipow.com/contact.html','User-Agent' => 'A-Kaser') {|f|
     f.each_line {|line| 
         puts line.match(/([^@\s*]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})/i)
   }
 }
