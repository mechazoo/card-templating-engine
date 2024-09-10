#! /usr/bin/env ruby
require './src/help'
require './src/renderer'

if $PROGRAM_NAME == __FILE__ then
    puts ARGV
    if ARGV.length < 2 then
        print_help()
    else 
        option, val = ARGV
        renderer = Renderer.new
        case option
        when 'set'
            renderer.render_set(val)
        when 'card'
            set, card = val.split('/')
            puts set, card
            renderer.render_card(set, card)
        else
            print_help()
        end
    end
end