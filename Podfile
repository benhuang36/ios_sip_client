platform :ios, '16.0'
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks! :linkage => :static

target 'ios_sip_client' do
  pod 'PJSIP', '~> 2.14'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
      end
    end
  end
end
