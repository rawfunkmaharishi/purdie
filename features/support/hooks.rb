Before do
  FileUtils.mkdir_p "tmp/aruba/_config/"
  FileUtils.cp "#{$fixtures}/_config/purdie.yaml", "tmp/aruba/_config/"
end

Before "@clearconf" do
  FileUtils.rm "tmp/aruba/_config/purdie.yaml"
end

After do
  FileUtils.rm "tmp/aruba/_config/purdie.yaml"
end
