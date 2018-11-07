# -*- encoding: utf-8 -*-
#/usr/bin/env ruby

require 'yaml'

radio_dir = "/path/to/radio"
rtmpdump = "/path/to/rtmpdump"
agqr_stream_url = "rtmp://fms-base1.mitene.ad.jp/agqr/aandg1"
schedule = "schedule.yaml"
ffmpeg = "/path/to/ffmpeg"
day = Time.now
# day = Time.local(2018,11,3,17,59,00)

schedule_yaml = YAML.load_file(schedule)
schedule_yaml["agqr"].each do |program|
  # should record
  should_record = program["record"]

  # right wday
  if program["date"]["hour"] == 0 && program["date"]["min"] == 0
    right_wday = program["date"]["wday"] - 1 == day.wday
    if day.day == 31 && day.month == 12
      program_start = Time.local(day.year + 1,day.month - 11,day.day - 30,program["date"]["hour"],program["date"]["min"],0)
    elsif day.day == 31 && day.month != 12
      program_start = Time.local(day.year,day.month + 1,day.day - 30,program["date"]["hour"],program["date"]["min"],0)
    else
      program_start = Time.local(day.year, day.month, day.day + 1, program["date"]["hour"], program["date"]["min"],0)
    end
  else
    right_wday = program["date"]["wday"] == day.wday
    program_start = Time.local(day.year, day.month, day.day, program["date"]["hour"], program["date"]["min"], 0)
  end

  # right now
  right_now = (program_start - day).abs < 120

  if should_record && right_wday && right_now
    if program["personality"]
      personality = "_" + program["personality"].gsub(" ","・")
    else
      personality = ""
    end

    title = (day.strftime("%Y%m%d") + program["title"] + personality).gsub(" ","")
    system("#{rtmpdump} -r #{agqr_stream_url} --live -B #{program["date"]["time"]} -o #{radio_dir}/file/#{title}.flv")
    if program["movie"] == true
      system("#{ffmpeg} -y -i #{radio_dir}/file/#{title}.flv -c:a mp3 -crf 35 #{radio_dir}/file/tmp/#{title}.mp4")
    else
      system("#{ffmpeg} -y -i #{radio_dir}/file/#{title}.flv #{radio_dir}/file/tmp/#{title}.mp3")
    end
  end
end
