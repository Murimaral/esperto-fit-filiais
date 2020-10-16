FactoryBot.define do
  factory :schedule do
    subsidiary { create(:subsidiary) }
    monday { '06:00 - 22:00' }
    tuesday { '06:00 - 22:00' }
    wednesday { '06:00 - 22:00' }
    thursday { '06:00 - 22:00' }
    friday { '06:00 - 22:00' }
    saturday { '06:00 - 22:00' }
    sunday { '06:00 - 22:00' }
    holidays { '06:00 - 22:00' }
  end
end
