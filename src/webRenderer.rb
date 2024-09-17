require 'selenium-webdriver'
require 'erb'
require 'base64'

class WebRenderer 
    def initialize(width, height) 
        @width = width
        @height = height
        driverOptions = Selenium::WebDriver::Options.chrome(args: ['--headless=new'])
        @driver = Selenium::WebDriver.for :chrome, options: driverOptions
    end

    def performRender(template_name, filename) 
        @driver.get "file://#{__dir__.sub('/src', '')}/templates/#{template_name}/temp.html"
        @driver.manage.window.resize_to @width, @height
        @driver.save_screenshot(filename)
    end
    def performStringRender(data, filename)
        @driver.get "data:text/html,#{ERB::Util.u(data)}"
        @driver.manage.window.resize_to @width, @height
        @driver.save_screenshot(filename)
    end
end