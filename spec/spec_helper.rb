GreenOnion.configure do |c|
  c.skins_dir = './spec/skins'
  c.driver = :selenium
  c.dimensions = { 
    :width => 1440, 
    :height => 768 
  }
end

RSpec.configure do |config|
  config.before(:each) do
    Capybara.page.driver.browser.manage.window.resize_to(1440, 768)
  end
end

def create_screenshots
  GreenOnion.skin_visual('http://localhost:8000/index.html')
end

def start_server_thread
  @server_thread = Thread.new do 
    root = Dir.pwd
    server = WEBrick::HTTPServer.new :Port => 8000, :DocumentRoot => root
    trap 'INT' do server.shutdown end
    server.start
  end
  sleep 2
end

def exit_server_thread
  @server_thread.exit
end
