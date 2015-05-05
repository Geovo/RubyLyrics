require './parselyrics.rb'
require 'benchmark'

describe Lyrical do

  before :each do
    @interpreter = "Metallica"
    @song = "Nothing else matters"
    @tester = Lyrical.new(@interpreter, @song)
    @modint = @interpreter.gsub(/[^\w\_]+/, "").downcase
    @modsong = @song.gsub(/[^\w\_]+/, "").downcase
  end
  
  it 'sets the artist Metallica and the song to NeM' do
    expect(@tester.artist).to eq('metallica')
    expect(@tester.songname).to eq('nothingelsematters')
  end

  it 'should create a folder and create the right file in it' do
    expect(Dir.pwd).to equal "/Users/pentahack/desktop/lyrical/"
    expect(Dir.exist?("/Users/pentahack/desktop/lyrical/lyrics/#{@modint}")).to be true
    expect(File.exist?("#{@modsong}.txt")).to be true
  end

end