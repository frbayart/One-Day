def dir_recur(path)
  begin
    if ( path =~ /[\/]$/ )
      puts "oo"
      path = 
    end
  Dir.entries(path).each do |item|
    if (File.directory?("#{path}/#{item}") and ( item =~ /[^.]{1,2}/ ) )
      print "Dir : ",path ,"/",item,"/\n"
      dir_recur("#{path}/#{item}")
    elsif
      print "File : ",path,"/", item,"\n"
    end
  end
  rescue Exception => e
    print "ERROR ", path, e, " \n"
  end
end

dir_recur("/Users/francois/supervision/")