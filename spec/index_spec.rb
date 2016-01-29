require 'webrick'
require 'green_onion'
require 'rspec'
require 'spec_helper'

describe 'index.html' do

  before(:all) do
    start_server_thread
  end

  after(:all) do
    exit_server_thread
  end

  before(:each) do
    create_screenshot
    @comparison = GreenOnion::Compare.new
    @solution = './spec/skins/index.html.png'
    @student = './spec/skins/index.html_fresh.png'
  end

  it 'all kittens are placed into the basket' do
    @comparison.percentage_diff(@solution, @student)
    expect(@comparison.percentage_changed).to eq(0.0)
  end
end
