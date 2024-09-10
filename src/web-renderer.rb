require 'webdrivers'
require 'erb'

class webRenderer 
    def initialize(width, height) 
        @width = width
        @height = height
        driverOptions = Selenium::WebDriver::Options.chrome(args: ['--headless=new'])
        @driver = Selenium::WebDriver.for :chrome, options: driverOptions
    end

    def performRender(data, filename) 
        @driver.get "data:text/html,#{ERB::Util.u data}"
        @driver.manage.window.resize_to @width, @height
        @driver.save_screenshot(filename)
    end
end