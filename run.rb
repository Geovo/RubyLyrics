require "./rubylyrics.rb"


if ARGV[0].nil?
	puts "Welcome to RubyLyrics", "Do you want to enter the name of the song manually or get it from the current song?",  
	"Enter the commands: 'itunes' or 'fill':"

	answer = gets.chomp

	case answer
	  when "itunes"
		iartist = %x(osascript -e 'tell application "iTunes" to artist of current track as string');
		isong = %x(osascript -e 'tell application "iTunes" to name of current track as string');
		puts iartist, isong
		lyric = Lyrical.new(iartist, isong)
		text = lyric.songlyr
		lyrcheck = %x(osascript -e 'tell application "iTunes" to get lyrics of current track as string');
		if lyrcheck.chomp.size > 10
		  puts "You already have this lyrics!" 
		else
		p %x(osascript -e "tell application \\"iTunes\\" to set lyrics of current track to \\"#{text}\\"");
		end
	  when "fill"
		puts "Enter the artist:"
		fartist = gets.chomp
		puts "Enter the song name:"
		fsong = gets.chomp
		lyric = Lyrical.new(fartist, fsong)
		p texxt = lyric.songlyr
		#p strack = %x(osascript -e 'tell application "iTunes" to name of (some track of library whose name is "#{fartist}")');
		res = lyric.find_by_name fsong
		lyric.set_lyrics_by_id res, texxt
	  else
		puts "Well, ok"
	  end
  
else
	  File.open(ARGV[0]).each_line do |line|
	  line = line.chomp.split(' | ')
	  p line
	  Lyrical.new(line[0], line[1])
	  Dir.chdir("/Users/pentahack/Desktop/lyrical")
	  sleep 0.5
      end
end 

  

