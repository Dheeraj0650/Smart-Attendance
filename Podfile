platform :ios, '13.0'

target 'Mini_project' do
  use_modular_headers!

  # Pods for Mini_project

  target 'Mini_projectTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Mini_projectUITests' do
    # Pods for testing
  end
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'
  pod 'Firebase/Database'
  post_install do |pi|
      pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
        end
      end
  end

end
