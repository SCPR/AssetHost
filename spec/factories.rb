FactoryGirl.define do
  factory :user do
    username "bricker"
    password "secret"
    password_confirmation "secret"
    is_admin false
  end

  factory :asset, class: "Asset" do
    title "Asset"
    caption "This has been an asset"
    owner "SCPR"
    url "http://www.scpr.org/assets/logo-mark-sm.png"
    image_file_name "logo-mark-sm.png"
    image_content_type "image/jpeg"
    image_width 300
    image_height 200
    image_file_size 1000
  end

  factory :output, class: "Output" do
    name "thumb"
    prerender 0
    render_options [
      {
        name: "scale",
        properties: {
          width:  88,
          height: 88
        }
      },
      {
        name: "crop",
        properties: {
          width: 88,
          height: 88
        }
      }
    ]
  end
end
