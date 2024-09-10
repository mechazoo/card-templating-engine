require 'webdrivers'

options = Selenium::WebDriver::Options.chrome(args: ['--headless=new'])

# options.add_argument('--force-device-scale-factor=2')

driver = Selenium::WebDriver.for :chrome, options: options

driver.get 'file://C:/Users/Chris/source/ruby/MechaZooCardCreator/template/card_template.html'

width = 770 # these values were derived from testing.
height = 1202

driver.manage.window.resize_to(width, height)

driver.save_screenshot("./selenium.png")