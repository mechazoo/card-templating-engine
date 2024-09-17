require 'selenium-webdriver'
require 'yaml'
require 'erb'
require 'fileutils'
require 'base64'
require_relative 'webRenderer.rb'

class Renderer 
    def initialize(setname)
        set_map = YAML.safe_load(File.read("sets/#{setname}/set.yaml"))
        @template_name = set_map['template']
        @set_name = setname
        @width = set_map['width']
        @height = set_map['height']
        @renderer_context = WebRenderer.new @width, @height
        @output_ensured = false
    end

    def render_set()
        Dir.each_child("sets/#{@set_name}/cards/") do |card|
            render_card(File.basename(card, File.extname(card)))
        end
    end
    
    def render_card(cardname)
        file_content = File.read("sets/#{@set_name}/cards/#{cardname}.yaml")
        content = YAML.safe_load(file_content, fallback: {})
        template_name = YAML.safe_load(File.read("sets/#{@set_name}/set.yaml"))["template"]
        template_name = content['template_override'] if content.key? 'template_override'
        template_file = File.read("templates/#{template_name}/card_template.erb")
        content['css_data'] = Base64.encode64(File.read("templates/#{template_name}/card_template.css"))
        erb_handler = ERB.new template_file
        unless @output_ensured
            Dir.mkdir('out') unless Dir.exist?('out')
            Dir.mkdir("out/#{@set_name}") unless Dir.exist?("out/#{@set_name}")
            @output_ensured = true
        end
        @renderer_context.performStringRender(
            erb_handler.result_with_hash(content),
            "out/#{@set_name}/#{cardname}.png"
        )
    end
end