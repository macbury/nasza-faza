env = ENV['RAILS_ENV']
if env && (env.downcase == 'production' || env.downcase == 'staging')
  GOOGLE_APPLICATION_ID = "ABQIAAAA4WhJYunRL5hTNCRIxFyokxRqg62AKsIpcWmRQTTCu6ZDId8nMxRLyA2IQh9gbyP0ai3R2HQtvX12oA"
else
 GOOGLE_APPLICATION_ID = "ABQIAAAAnfs7bKE82qgb3Zc2YyS-oBT2yXp_ZAY8_ufC3CFXhHIE1NvwkxSySz_REpPq-4WZA27OwgbtyR3VcA" 
end

res = Geokit::Geocoders::MultiGeocoder.geocode('Polska Swietkorzyskie Skarżysko-Kamienna 26-110')

SKARZYSKO = GoogleMap::Point.new(res.lat, res.lng)

WOJEWODZTWA = %w(dolnośląskie kujawsko-pomorskie lubelskie lubuskie łódzkie małopolskie mazowieckie opolskie podkarpackie podlaskie pomorskie śląskie świętokrzyskie warmińsko-mazurskie wielkopolskie zachodniopomorskie)
