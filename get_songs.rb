require 'json'
require 'pp'

file = File.read('plan.json')
plan = JSON.parse(file)['data']

ignore = [
    'Song notes',
    'Pre-song',
    'Prelude -',
    'Prelude - INSERT TITLE',
    'Worship',
    'Sending',
    'Benediction',
    'Post-song',
    'Postlude -',
    'Postlude - INSERT TITLE',
    'Prayer and Welcome',
    'Children\'s Blessing',
    'Video Announcements',
    'Community',
    'Doxology & Prayer of Dedication',
    'Word',
    'Prayer of Confession/Assurance of Pardon',
    'Sermon',
    'Scripture',]

class String
    def include_any?(array)
      array.any? {|i| self.include? i}
    end
end

def num_services(string)
    return string.scan(/\d{1,2}:\d{2}/).size
end

def has_services(string)
    return (/\d{1,2}:\d{2}/).match?(string)
end

def create_entry(num, plan_9, plan_11, description)

end

plan_9 = []
plan_11 = [] 

plan.each do |item|
    next if item['attributes']['item_type'] == 'header'
    next if item['attributes']['title'].include_any?(ignore)
    title = item['attributes']['title']
    description = item['attributes']['description']
    if has_services(description)
        if title.include?('Offertory')
            song_9, song_11 = description.split("\r\n")
            song_9 = song_9.gsub(/\d{1,2}:\d{2}\s*[\-|]\s*/, '')
            song_11 = song_11.gsub(/\d{1,2}:\d{2}\s*[\-|]\s*/, '')
            plan_11.push(song_11)
            plan_9.push(song_9)
        else
            song_11 = description.gsub(/\d{1,2}:\d{2}\s*[\-|]\s*/, '')
            plan_11.push(song_11)
            plan_9.push(title)
        end
        next
    end
    plan_9.push(title)
    plan_11.push(title)
end 

puts "==========9:00AM Songs=========="
puts plan_9
puts "\n"
puts "==========11:10AM Songs=========="
puts plan_11