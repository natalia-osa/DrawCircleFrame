Pod::Spec.new do |spec|
  spec.name         = "DrawCircleFrame"
  spec.version      = "1.0"
  spec.summary      = "Text highlighting via drawing circle around it"
  spec.homepage     = "http://appunite.com/"
  spec.license      = 'Apache 2.0'
  spec.author       = { "natalia.osiecka" => "natalia.osa@appunite.com" }
  spec.source       = { :git => 'https://github.com/natalia-osa/DrawCircleFrame.git', :tag => '1.0'}

  spec.requires_arc = true
  spec.ios.deployment_target = '5.0'
  spec.source_files = 'DrawCircleFrame/DrawCircleFrame/*.{h,m}'

  spec.frameworks   = ['Foundation', 'UIKit', 'CoreGraphics', 'QuartzCore']
end
