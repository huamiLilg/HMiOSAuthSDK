Pod::Spec.new do |s|  
	s.name             = "libHuamiSDK"  
	s.version          = "1.0.0"  
	s.summary          = "hua mi auth SDK"  
	s.homepage         = "https://github.com/huamiLilg/HMiOSAuthSDK"  
	s.license          = 'MIT'  
	s.author           = { "llg" => "lilingang@huami.com" }  
	s.source           = { :git => "https://github.com/huamiLilg/HMiOSAuthSDK.git", :tag => s.version.to_s }  

	s.platform     = :ios, '8.0'  
	s.ios.deployment_target = '8.0'  
	s.requires_arc = true  

	s.ios.vendored_frameworks = 'libHuamiSDK/*.framework'
	s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'
end  
