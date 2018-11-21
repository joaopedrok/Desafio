platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

workspace 'DesafioCIANDT.xcworkspace'
project 'DesafioCIANDT.xcodeproj'

def all_pods
    inherit! :search_paths
    pod 'SwiftFormat/CLI', '~> 0.33.8'
    pod 'SwiftLint', '~> 0.28.1'
    pod 'SnapKit', '~> 4.2.0'
    pod 'IQKeyboardManagerSwift', '~> 6.0.4'
    pod 'MBProgressHUD', '~> 1.1.0'
    pod 'Reusable', '~> 4.0.4'
    pod 'Kingfisher', '~> 4.10.1'
    pod 'FBSDKLoginKit', '~> 4.38.1'
end

def test_pods
    pod 'Nimble', '~> 7.3.1'
    pod 'Quick', '~> 1.3.2'
    pod 'Nimble-Snapshots', '~> 4.4.0'
end

target 'DesafioCIANDT' do
  all_pods
end

target 'DesafioCIANDTTests' do
  all_pods
  test_pods
end
