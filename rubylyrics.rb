require 'rubygems'
require 'nokogiri'
require 'net/http'


class Lyrical
   attr_reader :artist, :songname, :songlyr
  def initialize(artist, song)
    setup(artist,song)
    puts "Lyrics reference:"
    puts "http://www.azlyrics.com/lyrics/#{@artist}/#{@songname}.html"
    Dir.chdir("./lyrics")
    if main_check
      get_song
      dir_check
    else
      puts "Sorry, no such lyrics found at Azlyrics"
    end
  end
  
  def main_check
    @content = Nokogiri::HTML(@page)
    head = @content.css('body div.container.main-page div div.col-xs-12.col-lg-8.text-center div.lyricsh h2')
    if head.to_s.include?("#{@checker} LYRICS") 
	  value = true
    else
      value = false
    end
    return value
  end
  
  def get_song 
    @songlyr = @content.css('body div.container.main-page div div.col-xs-12.col-lg-8.text-center div:nth-child(8)').to_s.gsub(/<.+>/, " ").gsub(/\[.+\]/, "\n").sub(/[\s]+/, "")
  end
  
  def dir_check
    if Dir.exist?("#{@artist}")
	  Dir.chdir("./#{@artist}")
	  if File::exist?("#{@songname}.txt")
		puts "The file already exists!"
	  else
		output_into_file(@songlyr)
	  end
	else
	  Dir.mkdir("#{@artist}")
	  Dir.chdir("./#{@artist}")	  
	  output_into_file(@songlyr)
	end
  end
  
  def output_into_file(song)
    f = File.open("#{@songname}.txt", "w")
	f.puts song
#	f.puts @content.css 'body div.container.main-page div div.col-xs-12.col-lg-8.text-center'
	f.close
	puts "Check out your new lyrics at: #{Dir.pwd}"
  end
  
        def find_by_name input

            dirty_track_names = %x(osascript -e "tell application \\"iTunes\\" to artist of tracks of library playlist 1")
            p track_names = dirty_track_names.split(',').map(&:strip).uniq!
			p %x(osascript -e "tell application \\"iTunes\\" to name of tracks of artist is \\"#{@artist}\\"")
            matching_names = track_names.select{|v| v.downcase.match(/#{input.downcase}/)}
            name_id = {}
            matching_names.each do |name|
                temp = %x(osascript -e "tell application \\"iTunes\\" to database id of (some track of library playlist 1 whose name is \\"#{name}\\")")
                name_id[name] = temp.strip
            end

            print name_id
        end
  
  private
  
      def setup(artist, song)   
		@artist = artist.gsub(/[^\w]+/, "").gsub("_", "").downcase
		@checker = artist.upcase.chomp
		@checksong = song.downcase
		@songname = song.gsub(/[^\w]+/, "").gsub("_", "").downcase
		"http://www.azlyrics.com/lyrics/#{@artist}/#{@songname}.html"
		@page = Net::HTTP.get(URI("http://www.azlyrics.com/lyrics/#{@artist}/#{@songname}.html"))
     end

end


#n = Lyrical.new("Atreyu","Lose it")




#uncomment this get the song per terminal prompt
=begin

puts "Hello, welcome to Lyricsparser! Enter the artist in the first line and the song's name in the second line"
#if ARGV[0].nil?
  puts "Here goes the author:"
  artist = gets.chomp #.gsub(/[^\w]+/, "").gsub("_", "").downcase
  puts "Here goes the song"
  songsname = gets.chomp #.gsub(/[^\w]+/, "").gsub("_", "").downcase

  search = Lyrical.new(artist, songsname)
  
=end  
=begin
#Uncomment to fetch songs from input file. In the input file, write artist and song(one pair each line):
# Like this =>   Metallica | Nothing else matters
#else
File.open(ARGV[0]).each_line do |line|
  line = line.chomp.split(' | ')
  p line
  Lyrical.new(line[0], line[1])
  Dir.chdir("/Users/pentahack/Desktop/lyrical")
  sleep 0.5
end
=end