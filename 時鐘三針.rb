times = (1..12*60*60) # minutes

def hour_position(time)
  pos = time / 60r / 60 / 12
  pos.zero? ? 1r : pos
end

def minute_position(time)
  pos = time % 3600 / 3600r
  pos.zero? ? 1r : pos
end

def second_position(time)
  pos = time % 60 / 60r
  pos.zero? ? 1r : pos
end

def to_human_form(time)
  hour = time / 60 / 60
  min = time / 60 % 60
  sec = time % 60
  puts "#{hour}　點 #{min} 分 #{sec} 秒"
end

puts "三針重合時刻:"
times
  .select do |t|
    positions = [hour_position(t), minute_position(t), second_position(t)]
    (positions.max - positions.min) < 3 / 360r
  end
    .each{|t| to_human_form(t)}

puts "鐘面均分時刻:"
times
  .select do |t|
    positions = [hour_position(t), minute_position(t), second_position(t)]
      .sort
      .reverse
    (positions[0] - positions[1]).between?(1/3r-3/360r, 1/3r+3/360r) &&
    (positions[1] - positions[2]).between?(1/3r-3/360r, 1/3r+3/360r) &&
    (positions[2] - positions[0] + 1).between?(1/3r-3/360r, 1/3r+3/360r)
  end
    .each{|t| to_human_form(t)}
