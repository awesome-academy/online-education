require "carrierwave"

class CkeditorAttachmentFileUploader < CarrierWave::Uploader::Base
  include Ckeditor::Backend::CarrierWave

  storage :file

  def store_dir
    "#{Rails.root}/tmp/uploads"
  end

  def extension_white_list
    Ckeditor.attachment_file_types
  end
end
