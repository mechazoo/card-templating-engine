require 'webdrivers'
require 'yaml'
require 'erb'
require 'fileutils'
require_relative 'webRenderer.rb'

class Renderer 
    def initialize()
        @rendererContext = WebRenderer.new 772, 1203
    end

    def render_set(setname)
        Dir.each_child("sets/#{setname}/cards/") do |card|
            render_card(setname, File.basename(card, File.extname(card)))
        end
    end
    
    def render_card(setname, cardname)
        file_content = File.read("sets/#{setname}/cards/#{cardname}.yaml")
        content = YAML.safe_load(file_content)
        template_name = YAML.safe_load(File.read("sets/#{setname}/set.yaml"))["template"]
        template_file = File.read("templates/#{template_name}/card_template.erb")
        erb_handler = ERB.new template_file
        Dir.mkdir('out') unless Dir.exist?('out')
        Dir.mkdir("out/#{setname}") unless Dir.exist?("out/#{setname}")
        File.write("templates/#{template_name}/temp.html", erb_handler.result_with_hash(content))
        @rendererContext.performRender(
            template_name,
            "out/#{setname}/#{cardname}.png"
        )
        FileUtils.rm_f("templates/#{template_name}/temp.html")
    end
end