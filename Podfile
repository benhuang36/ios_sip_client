platform :ios, '16.0'
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks! :linkage => :static

target 'ios_sip_client' do
  # CocoaPods does not host PJSIP on the public Specs repo, so installing it
  # requires pointing at a vendor's podspec and/or enabling the dependency
  # explicitly. By default we skip the pod and rely on the stub wrapper so the
  # project still installs cleanly.
  if ENV['USE_PJSIP_POD'] == '1'
    if ENV['PJSIP_PODSPEC']
      pod 'PJSIP', :podspec => ENV['PJSIP_PODSPEC']
    else
      pod 'PJSIP', (ENV['PJSIP_VERSION'] || '~> 2.14')
    end
  else
    puts 'Skipping PJSIP pod; set USE_PJSIP_POD=1 to install the real SDK.'
  end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
      end
    end
  end
end
