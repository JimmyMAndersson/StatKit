Pod::Spec.new do |spec|
  spec.name                       = "StatKit"
  spec.version                    = "0.3.0"
  spec.summary                    = "StatKit adds statistical analysis tools to your Swift projects."
  spec.homepage                   = "https://github.com/JimmyMAndersson/StatKit"
  spec.license                    = { :type => "MIT", :file => "LICENSE" }
  spec.author                     = { "Jimmy M Andersson" => "dev@applyn.se" }
  spec.social_media_url           = "https://twitter.com/JimmyMAndersson"
  spec.ios.deployment_target      = "13.0"
  spec.osx.deployment_target      = "10.15"
  spec.tvos.deployment_target     = "13.0"
  spec.swift_version              = '5.2'
  spec.source                     = { :git => "https://github.com/JimmyMAndersson/StatKit.git", :tag => "#{spec.version}" }
  spec.source_files               = "Sources/StatKit/**/*.swift"
  spec.cocoapods_version          = '>= 1.9.0'
end
