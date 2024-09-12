#! /usr/bin/env ruby
require './src/help'
require './src/renderer'

if $PROGRAM_NAME == __FILE__ then
    puts ARGV
    if ARGV.length < 2 then
        print_help()
    else 
        option, val = ARGV
        case option
        when 'set'
            renderer = Renderer.new val
            renderer.render_set
        when 'card'
            set, card = val.split('/')
            renderer = Renderer.new set
            renderer.render_card(card)
        else
            print_help()
        end
    end
end