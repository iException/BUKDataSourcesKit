Pod::Spec.new do |s|
  s.name             = "BUKDataSourcesKit"
  s.version          = "0.1.0"
  s.summary          = "Data-driven data source objects that eliminate your boilerplate code."
  s.description      = <<-DESC
                       DESC
  s.homepage         = "https://github.com/iException/BUKDataSourcesKit"
  s.license          = 'MIT'
  s.author           = { "Yiming Tang" => "yimingnju@gmail.com" }
  s.source           = { :git => "https://github.com/iException/BUKDataSourcesKit.git", :tag => "v#{s.version.to_s" }
  s.social_media_url = 'https://twitter.com/yiming_t'
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'BUKDataSourcesKit' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
