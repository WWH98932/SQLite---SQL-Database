create table listartimes (listener INT, artist INT, times INT, primary key(listener, artist));
.separator "," 
create table artists (artist INT primary key, artistname varchar(20));
.separator "," 
.import listartimes.csv listartimes
.import artist.csv artists
select artists.artistname, listartimes.times from artists inner join listartimes on artists.artist = listartimes.artist and listartimes.listener = 1000030;