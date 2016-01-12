Pod::Spec.new do |s|
  s.name         = "EggsBenedict"
  s.version      = "0.9.7"
  s.summary      = "EggsBenedict is a library for sharing picture on Instagram written in Swift."
  s.description  = <<-DESC
This library is following Instagram's sharing flow.

> __Instagram's documentation__

> - [Document Interaction](https://www.instagram.com/developer/mobile-sharing/iphone-hooks/#document-interaction)
                   DESC
  s.homepage     = "https://github.com/JPMartha/EggsBenedict"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author    = "JPMartha"
  s.social_media_url   = "https://twitter.com/JPMartha_jp"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/JPMartha/EggsBenedict.git", :tag => "v0.9.7" }
  s.source_files  = "EggsBenedict/**/*.swift"
  s.requires_arc = true
end
