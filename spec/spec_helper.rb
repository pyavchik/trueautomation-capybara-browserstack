require 'bundler/setup'
require 'ostruct'
require 'selenium-webdriver'
require 'rspec'
require 'rspec-steps'
require 'capybara/rspec'
require 'true_automation/rspec'
require 'true_automation/driver/capybara'

username = 'your_username'
accesskey = 'your_accesskey'

def camelize(str)
  str.split('_').map {|w| w.capitalize}.join
end


spec_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(spec_dir)

$data = {}
Dir[File.join(spec_dir, 'fixtures/**/*.yml')].each {|f|
  title = File.basename(f, '.yml')
  $data[title] = OpenStruct.new(YAML::load(File.open(f)))
}

$data = OpenStruct.new($data)
Dir[File.join(spec_dir, 'support/**/*.rb')].each {|f| require f}

RSpec.configure do |config|
  Capybara.register_driver :true_automation_driver do |app|
    caps = Selenium::WebDriver::Remote::Capabilities.new
    caps['browser'] = 'Chrome'
    caps['browser_version'] = '71.0'
    caps['os'] = 'Windows'
    caps['os_version'] = '10'
    caps['resolution'] = '1024x768'

    TrueAutomation::Driver::Capybara.new(app, browser: :remote,
                                         url: 'http://' + username + ':' + accesskey + '@hub-cloud.browserstack.com/wd/hub',
                                         desired_capabilities: caps)

  end

  Capybara.configure do |capybara|
    capybara.run_server = false
    capybara.default_max_wait_time = 5

    capybara.default_driver = :true_automation_driver
  end

  config.include Capybara::DSL
  config.include TrueAutomation::DSL

  Dir[File.join(spec_dir, 'support/**/*.rb')].each {|f|
    base = File.basename(f, '.rb')
    klass = camelize(base)
    config.include Module.const_get(klass)
  }
end
