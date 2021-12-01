#!/usr/bin/ruby

require 'pg'

begin

    con = PG.connect :dbname => 'university', :user => 'postgres', :password => 'Oranges224'
    
    rs = con.exec "SELECT * FROM instructor LIMIT 5"
    
    puts con.methods

    rs.each do |row|
      puts "%s %s %s %s" % [ row['id'], row['name'], row['dept_name'], row['salary'] ]
    end

rescue PG::Error => e

    puts e.message 
    
ensure

    rs.clear if rs
    con.close if con
    
end