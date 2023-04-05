class PostSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :header, :description, :image_urls
  belongs_to :user, serializer: UserSerializer

  def header
    object.title
  end

  def image_urls
    object.images.map do |image|
      { image: rails_blob_url(image, only_path: true) } if object.images.attached?
    end
  end 
end
