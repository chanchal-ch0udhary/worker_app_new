FactoryBot.define do
    factory :user do
      name { "Test User" }
      email { "test@example.com" }
      role { "contractor" }
      address { "Test address" }
      phone_no { 9876543210 }
      password { 12345678 }
    end
end