Factory.define :video do |f|
  f.title { rand(100).to_s * 5 }
  f.description { rand(1_000_000).to_s * 10 }
  f.user { |user| user.association(:user) }
  f.video { File.new(Rails.root + 'test/files/video.wmv') }
end

Factory.define :fake_video, parent: :video do |f|
  f.video { File.new(Rails.root + 'test/files/fake_video.mp4') }
end
