Factory.define :post do |f|
  f.name ""
  f.message { rand(1_000_000).to_s * 10 }
  f.video { |video| video.association(:video) }
end
