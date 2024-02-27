class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class 

  ActiveSupport.on_load(:active_storage_attachment) do
    ActiveStorage::Attachment.extend RansackableAttachment
  end

  module RansackableAttachment
      def ransackable_attributes(_auth_object = nil)
        %w[blob_id created_at id id_value name record_id record_type]
      end
  end

end
