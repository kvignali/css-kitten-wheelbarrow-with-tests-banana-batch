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
    puts 'Making comparison please wait...'
    create_screenshot
    @comparison = GreenOnion::Compare.new
    @solution = './spec/skins/index.html.png'
    @student = './spec/skins/index.html_fresh.png'
  end

  it 'all kittens are placed into the basket' do
    @comparison.percentage_diff(@solution, @student)
    if (@comparison.percentage_changed > 0.0)
      puts 'Not all of your cats are in the right place.'
      puts "We expected 0% difference to the solution and yours was off by #{@comparison.percentage_changed}%."
    end
    expect(@comparison.percentage_changed).to eq(0.0)
  end
end
