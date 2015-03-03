Before do
  FileUtils.mkdir_p "tmp/aruba/_config/"
  FileUtils.cp "#{$fixtures}/_config/purdie.yaml", "tmp/aruba/_config/"
end
