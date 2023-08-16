FactoryBot.define do
  factory :item do
    damage_area { "MyString" }
    comment { "MyText" }
    quantity { 1.5 }
    labour_cost { 1.5 }
    material_cost { 1.5 }
    total_cost { 1.5 }
    location { "MyString" }
    container_type { "MyString" }
    container_repair_area { "MyString" }
    repair_id { 1 }
  end

  factory :attachment do
    file_type { "MyString" }
    attachable { nil }
    pre_signed_url { "MyString" }
  end

  factory :log do
    activity { nil }
    user { nil }
    log_status { 1 }
  end

  factory :comment do
    comment { "MyText" }
    user { nil }
    commentable { nil }
  end

  factory :activity do
    container { nil }
    activity_type { 1 }
    activity_status { 1 }
    user { nil }
    total_cost { 1.5 }
  end

  factory :container do
    yardname_id { 1 }
    submitter_initial { "MyString" }
    container_height_id {1 }
    container_length_id { 1 }
    container_number { "MyString" }
    location { "MyString" }
    container_type { 1 }
    customer_id { 1 }
    manufacture_year { 1 }
  end

  factory :container_length do
    length { 1 }
  end

  factory :container_height do
    height { 1 }
  end

  factory :yardname do
    yard_name { "MyString" }
  end

  factory :customer do
    name { "MyString" }
    email { "MyString" }
    owner_name { "MyString" }
    billing_name { "MyString" }
    hourly_rate { 1.5 }
    gst { 1.5 }
    pst { 1.5 }
    city { "MyString" }
    province { "MyString" }
    postalcode { "MyString" }
    customer_type { "MyString" }
    password { "MyString" }
    customer_status { "MyString" }
  end

  factory(:user) do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
