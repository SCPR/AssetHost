FactoryGirl.define do
  factory :user do
    username "bricker"
    password "secret"
    password_confirmation "secret"
    is_admin false
  end

  factory :api_user, class: "AssetHostCore::ApiUser" do
    name "Bryan"
    email "bricker@scpr.org"
    is_active true
  end

  factory :permission, class: "AssetHostCore::Permission" do
  end

  factory :asset, class: "AssetHostCore::Asset" do
    title "Asset"
    caption "This has been an asset"
    owner "SCPR"
    url "http://www.scpr.org/assets/logo-mark-sm.png"
    is_hidden false
    image_file_name "logo-mark-sm.png"
    image_content_type "image/jpeg"
    image_width 300
    image_height 200
    image_file_size 1000
  end


  factory :output, class: "AssetHostCore::Output" do
  end
end
