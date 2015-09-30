#!/usr/bin/env ruby
puts "Files with names that matches <#{ARGV[0]}>"
files = `find . | grep #{ARGV[0]}`.split(/\n/)
wanted_files = files.map { |file| file if (file =~ /(\.rb$)|(\.erb$)|(\.js$)|(\.css$)|(\.html$)|(\.yml$)|(\.txt$)/) }
wanted_files.compact!
wanted_files.each { |file| puts "  " + file}
puts "*" * 50
puts "Files with content that matches <#{ARGV[0]}>"
all_files = `find .`.split(/\n/).keep_if { |file| file =~ /(\.rb$)|(\.erb$)|(\.js$)|(\.css$)|(\.html$)|(\.yml$)|(\.txt$)/ }.sort
all_files.each { |file|
             lines = `cat #{file} | grep -n #{ARGV[0]}`.split(/\n/).compact
             if lines.length > 0
               puts file
               lines.each { |line| puts "  " + line}
               if file != all_files.last
                 puts "-" * 50
               end
             end
           }
