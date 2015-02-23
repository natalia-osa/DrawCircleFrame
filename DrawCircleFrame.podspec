Pod::Spec.new do |spec|
  spec.name         = "DrawCircleFrame"
  spec.version      = "1.2"
  spec.summary      = "Text highlighting via drawing circle around it"
  spec.homepage     = "http://appunite.com/"
  spec.license      = 'Apache 2.0'
  spec.author       = { "natalia.osiecka" => "osiecka.n@gmail.com" }
  spec.source       = { :git => 'https://github.com/natalia-osa/DrawCircleFrame.git', :tag => '1.2'}

  spec.requires_arc = true
  spec.ios.deployment_target = '5.1.1'
  spec.source_files = 'DrawCircleFrame/DrawCircleFrame/*.{h,m}'

  spec.frameworks   = ['Foundation', 'UIKit', 'CoreGraphics', 'QuartzCore']

  spec.subspec 'Core' do |ss|
    ss.dependency 'NOCategories'
  end

end
