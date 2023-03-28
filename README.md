# my-church-scripts
Simple scripts that help my church related tasks easier.

## TrimNewlines.go
This was a simple script I made to deal with a propresenter 6 bug that never got fixed. When importing pro6 files from Windows->MacOS or MacOS->Windows there seems to have been some issue with line-endings. Slides would always end up with extra line endings at the very end of each textbox. This was easily fixible by running this script to decode the RTFData found in each pro6 file (XML). I used Go because it seemed like the easiest way to create a cross paltform binary than anyone could easily click and run on a ProPresenter library. 

## download_plan.rb & get_songs.rb
After first downloading a plan, get_songs tries to remove everything except song-related items and report them back as a list. This is helpful for me to see just the song lyrics that need to be reviewed or created. 
