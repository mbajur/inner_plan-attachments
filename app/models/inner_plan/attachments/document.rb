module InnerPlan::Attachments
  # It's not called File because that conflicted with ruby built in File class
  class Document < InnerPlan::Attachment
    store :meta, accessors: [:display_text], coder: JSON

    has_one_attached :file

    validates :file, presence: true
  end
end
