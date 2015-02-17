class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process :convert => "png"
  process :tags => ["avatar"]

  cloudinary_transformation :transformation => [
      {:width => 1000, :height => 1200, :crop => :limit}, 
    ]   

  version :standard do
    eager
    process :crop_to_fit => [1024, 768], :gravity => :facees, :effect => "pixelate_faces"
    cloudinary_transformation :quality => 80
  end

  version :glavatar do
    eager
    cloudinary_transformation :glavatar => "brightness:30", :radius => :max,
      :width => 50, :height => 50, :crop => :thumb, :gravity => :face, :effect => "pixelate_faces"
  end

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
