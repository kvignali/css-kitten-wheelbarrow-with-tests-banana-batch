GreenOnion.configure do |c|
  c.skins_dir = './spec/skins'
  c.threshold = 20
  c.skin_name = {
    :match => /[\/]/, 
    :replace => "_", 
    :prefix => nil,
    :root => "root"
  }
  c.dimensions = { :width => 1440, :height => 900 }
  c.driver = :selenium
end

def create_screenshot
  # Create a fresh student shot.
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