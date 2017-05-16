class Post < ApplicationRecord
  belongs_to :user
  validates_presence_of :phone_number, :title, :description, :location
  mount_uploader :image, ImageUploader

  def latlng
    address = HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{self.location}&key=#{ENV.fetch('MAP_KEY')}").parsed_response
    self.lat = address["results"][0]["geometry"]["location"]["lat"]
    self.lng = address["results"][0]["geometry"]["location"]["lng"]
    self.save
  end

  # there's probably a function to do this in Math
  # but I'm just lazy
  def radians(deg)
    deg * Math::PI / 180
  end

  def lat_radians
    radians(lat.to_f)
  end

  def lng_radians
    radians(lng.to_f)
  end

  EARTH_RADIUS = 3958.756; # in miles
  def distance_from(lat, lng)
    lat_radians = radians(lat)
    lng_radians = radians(lng)

    dist_lat = lat_radians - self.lat_radians
    dist_long = lng_radians - self.lng_radians

    a =  (Math.sin(dist_long/2))**2 +
        Math.cos(self.lat_radians) *
        Math.cos(lat_radians) *
        (Math.sin(dist_long/2))**2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    EARTH_RADIUS * c
  end
end
