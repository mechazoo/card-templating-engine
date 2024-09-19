require 'selenium-webdriver'
require 'yaml'
require 'erb'
require 'fileutils'
require 'base64'
require 'redcarpet'
require_relative 'webRenderer.rb'

class Renderer 
    @@css_cache = {}
    @@erb_template_cache = {}
    @@set_cache = {}
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
        card_data = YAML.safe_load_file "sets/#{@set_name}/cards/#{cardname}.yaml", fallback: {}
        if card_data.key? 'template_override' then
            card_data['css_data'] = Renderer.getCSS card_data['template_override']
        else
            card_data['css_data'] = Renderer.getCSS @template_name
        end
        if card_data.key? 'text' and card_data['text'].start_with? "md\n" then
            md = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: false, tables: false)
            card_data['text'] = md.render(card_data['text'].sub("md\n", ""))
        end
        Renderer.ensureOutputDirectory @set_name
        handler = ERB.new Renderer.getERB @template_name 
        @renderer_context.performStringRender(
            handler.result_with_hash(card_data)
            "out/#{@set_name}/#{cardname}.png"
        )
    end
    def Renderer.getCSS(template_name)
        @@css_cache[template_name] ||= Base64.encode64(File.read("templates/#{template_name}/card_template.css"))
    end 
    def Renderer.getERB(template_name)
        @@erb_template_cache[template_name] ||= File.read("templates/#{template_name}/card_template.erb")
    end
    def Renderer.ensureOutputDirectory(set_name)
        unless @@set_cache[set_name]
            unless Dir.exist? "out/#{set_name}"
                FileUtils.mkdir_p("out/#{set_name}")
                @@set_cache[set_name] = true
            end
        end
    end
end
