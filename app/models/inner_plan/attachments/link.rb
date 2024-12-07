module InnerPlan::Attachments
  class Link < InnerPlan::Attachment
    store :meta, accessors: [:url, :display_text, :page_title, :page_favicon_url], coder: JSON

    validates :url, presence: true
  end
end
