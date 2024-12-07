module InnerPlan
  class Attachment < ApplicationRecord
    belongs_to :task, class_name: 'InnerPlan::Task'
    belongs_to :user, class_name: InnerPlan.configuration.user_class_name, optional: true

    positioned on: [:task, :type]

    scope :links, ->{ where(type: 'InnerPlan::Attachments::Link') }
    scope :documents, ->{ where(type: 'InnerPlan::Attachments::Document') }
  end
end
