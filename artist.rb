artist = %x(osascript -e 'tell application "iTunes" to artist of current track as string');
song = %x(osascript -e 'tell application "iTunes" to name of current track as string');
songid = %x(osascript -e 'tell application "iTunes" to get lyrics of current track as string');
songsart = %x(osascript -e "tell application \\"iTunes\\" to name of tracks of artist whose name is \\"#{artist.chomp}\\"")
puts artist
puts song
puts songid
puts songsart