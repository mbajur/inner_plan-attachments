module InnerPlan
  module Attachments
    class Engine < ::Rails::Engine
      isolate_namespace InnerPlan::Attachments

      config.to_prepare do
        Dir.glob(File.join(File.dirname(__FILE__), '../../../app/**/*_patch*.rb')) do |c|
          Rails.configuration.cache_classes ? require(c) : load(c)
        end
      end

      config.after_initialize do
        InnerPlan.configuration.task_show_view_rows
          .get(:secondary_row)
          .content
          .add_after(:description, InnerPlan::SmartArray::Item.new(
            :attachments,
            { span: 12 },
            'InnerPlan::Tasks::Show::Items::AttachmentsComponent'
          ))
      end
    end
  end
end
