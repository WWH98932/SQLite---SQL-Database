# SQLite---SQL-Database
UCLA Master of Applied Economics Econ 423 Assignment

In this assignment we will use two files from audioscrobbler data:

      user_artist_data.txt: 
Save this file as a CSV file (using MS Excel or another tool) with first 100,000 records (user_artist_data.csv).  

      artist_data.txt: 

Save this file as a CSV file (using MS Excel or another tool) - all records (artist_data.csv).  You may need to do additional processing and cleaning of your data using different tools including Python (see any example script in the end).

Your script should do the following:

- Read user_artist.csv into a table called userartist (add a primary key as well)
- Read artist_data.csv into a table called artistdata (add a primary key as well)
- Write a select statement that prints artists that prints out names of all artists that the user1000030 listened to together with number of times each artist was listened to. 
ALTERNATE PATH:
You can do the above assignment in Python using the sqlite3 Python plug in (where you will need to run SQL from within Python. If you go this route, you will need to submit a .ipynb file that should run. 

In order to do this assignment, you will need to learn the following:
- SQL Databases
- SQLite
- SQL statements 

ADDITIONAL GUIDANCE/HELP:

Install SQLite:
- OSX: Sqlite comes installed with OSX. Open Terminal and run sqlite3 and you will get the sqlite> prompt on which you can run your commands.
- Windows: Search Google for how to install SQLite on Windows. Or create a folder (say c:\sqlite3\) and add sqlite3.def, sqlite3.dll, and sqlite3.exe that you can download form: https://www.sqlite.org/download.html. Once you have these files in the folder, you can change directory to this folder on a command prompt (Start / cmd). You may also want to add the path to your PATH variable using Windows Control Panel/System. 
Below is an example that will help you create your own script:

      - Create a listartimes.csv file (no headers):
      "10007","1002","34"
      "10007","1005","6"
      "10007","1007","12"
      "10007","1011","43"
      "10009","1013","3"
      "10009","1018","9"
      
      - Create an artists.csv file (no headers):
      "1002","Great Artist"
      "1005","Prince"
      "1007","Abba"
      "1011","BoneyM"
      "1013","Jason Jason"
      "1018","Prematiculate"
      "1019","Instrumentation"
- Put these files in the sqlite3 folder (on Windows - unless you have these files in the PATH). 
- Open SQLite prompt. Should look like this: sqlite3> both on Windows and OSX. 
- Review this web page that provides guidance on how to run .commands on SQLite: https://sqlite.org/cli.html. Note these are not SQL statements but commands specific to SQLite for some formatting and I/O operations. 
- Review the following pages to understand what is SQL:
   * https://en.wikipedia.org/wiki/SQL
   * https://en.wikipedia.org/wiki/Join_(SQL) 
- Run the following commands on the SQLite prompt to create your tables (these will be empty table):
create table listartimes (listener INT, artist INT, times INT, primary key(listener, artist));
This creates a table called listartimes with listener, artist, and times as columns and assign a composite primary key on listener and column. Understand by researching the web what is a primary key. 
create table artists (artist INT primary key, artistname varchar(20));
This creates a table called artists with artist and artistname as column names with artist as a primary key. 
- Read your .csv files into your tables (below are sqlite dot commands):

      .import listartime.csv listartimes
      .import artists.csv artists
- Finally run a query to print names of artists and times that the listener ID 10007 has listened to:

      select artists.artistname, listartimes.times from artists inner join listartimes on artists.artist = listartimes.artist and listartimes.listener = 10007;
This query is not optimized. You can achieve the same result with simpler and better query. Note this is just an example. You need to tailor as per the need of assignment above. Here is the output that you will get of the query:
      
      Great Artist,34
      Prince,6
      Abba,12
      BoneyM,43

Example Script for Converting artist_data.txt to CSV:

      artout = open('artout.csv', 'w')
      with open('artist_data.txt', "r", encoding='utf-8') as f:
          lines = f.readlines()
      for i in range(len(lines)):
          try:
              isp = lines[i].split()
              for j in range(len(isp)):
                  isp[j] = isp[j].replace(",", " ")
                  isp[j] = isp[j].replace('"', ' ')
              isp[0] = '"' + isp[0] + '",'
              isp[1] = '"' + isp[1]
              isp[len(isp)-1] = isp[len(isp)-1] + '"'
              for k in isp:
                  try:
                      artout.write(k)
                  except:
                      print("Error in record: ", isp[0])
              artout.write("\n")
          except:
              print('another error')
      artout.close()
      f.close()

NOTE:
You may issues upon importing .csv to SQLite on Windows 
computers. The  issue is that Windows cmd (command window) uses a older 
code page (OEM 850) by default. You will need to change the code page to
UTF-8 code page by running the following command on cmd before starting
SQLite:

      CHCP 65001

Please take a look at this link: https://ss64.com/nt/chcp.html

The core issue is that because in the default mode, Windows cmd and 
therefore SQLite converts many characters to " resulting in multiple 
quotes within a single line which in turn gets SQLite to think them to 
be multiple columns. I tested this solution on a Windows machine and 
seems to be fine.
