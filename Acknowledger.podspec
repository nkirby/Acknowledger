#
# Be sure to run `pod lib lint Acknowledger.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Acknowledger"
  s.version          = "0.1.0"
  s.summary          = "A lightweight Library Acknowledgement viewer for iOS apps."
  s.description      = <<-DESC
                       Acknowledger turns the generated acknowledgements file from Cocoapods into something more useful.
                       DESC
  s.homepage         = "https://github.com/nkirby/Acknowledger"
  s.license          = 'MIT'
  s.author           = { "Nathaniel Kirby" => "nkirby.ps@gmail.com" }
  s.source           = { :git => "https://github.com/nkirby/Acknowledger.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/thenatekirby'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'Acknowledger' => ['Pod/Assets/*.png']
  }

end
