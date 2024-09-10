#! /usr/bin/env ruby
require './src/help'

if $PROGRAM_NAME == __FILE__ then
    if ARGV.length < 2 then
        print_help()
    else 
        puts 'you\'ve given enough args'
    end
end