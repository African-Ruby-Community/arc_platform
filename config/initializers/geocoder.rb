Geocoder.configure(
  timeout: 5,
  lookup: :nominatim,
  use_https: true,
  units: :km,
  http_headers: { "User-Agent" => "ARC Platform" }
)

# In test environment, prevent external HTTP calls by using the test lookup.
if Rails.env.test?
  Geocoder.configure(lookup: :test)
  Geocoder::Lookup::Test.set_default_stub([
    {
      'latitude' => 0.0,
      'longitude' => 0.0,
      'address' => 'Stubbed Address',
      'state' => 'Stubbed State',
      'state_code' => 'SS',
      'country' => 'Stubland',
      'country_code' => 'SL'
    }
  ])
end
