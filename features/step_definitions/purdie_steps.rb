Given /^no credentials for SoundCloud$/ do
  $sc = ENV['SOUNDCLOUD_CLIENT_ID']
  ENV['SOUNDCLOUD_CLIENT_ID'] = nil
end

Given /^I restore the credentials for SoundCloud$/ do
  ENV['SOUNDCLOUD_CLIENT_ID'] = $sc
end

Given /^no credentials for Vimeo$/ do
  $v = ENV['VIMEO_BEARER_TOKEN']
  ENV['VIMEO_BEARER_TOKEN'] = nil
end

Given /^bad credentials for YouTube$/  do
  $y = ENV['YOUTUBE_API_KEY']
  ENV['YOUTUBE_API_KEY'] = 'fji423cj234'
end

Given /^I restore the credentials for Vimeo$/  do
  ENV['VIMEO_BEARER_TOKEN'] = $v
end

Given /^I restore the credentials for YouTube$/  do
  ENV['YOUTUBE_API_KEY'] = $y
end
