Pod::Spec.new do |spec|
  spec.name         = "DrawCircleFrame"
  spec.version      = "1.3.1"
  spec.summary      = "Text highlighting via drawing circle around it"
  spec.homepage     = "https://github.com/natalia-osa/"
  spec.license      = 'Apache 2.0'
  spec.author       = { "natalia.osiecka" => "osiecka.n@gmail.com" }
  spec.source       = { :git => 'https://github.com/natalia-osa/DrawCircleFrame.git', :tag => '1.3.1'}

  spec.requires_arc = true
  spec.ios.deployment_target = '6.0'
  spec.source_files = 'DrawCircleFrame/DrawCircleFrame/*.{h,m}'

  spec.frameworks   = ['Foundation', 'UIKit', 'CoreGraphics', 'QuartzCore']

  spec.subspec 'Core' do |ss|
    ss.dependency 'NOCategories'
  end

end
