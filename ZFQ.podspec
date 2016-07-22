Pod::Spec.new do |s|

	s.name = "ZFQHUD"
	s.version  = "0.1.1"
	s.description = <<-DESC
					HUD
					DESC
	
	s.source = { :git => "https://github.com/zfq/ZFQHUD" }				
	s.ios.deployment_target = '7.0'
	s.requires_arc = true
	s.source_files = 'ZFQHUD','Class/*.{h,m}'
	
end
