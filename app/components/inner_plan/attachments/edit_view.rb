module InnerPlan
  module Attachments
    class EditView < InnerPlan::ApplicationView
      include Phlex::Rails::Helpers::DOMID
      include Phlex::Rails::Helpers::ContentTag
      include Phlex::Rails::Helpers::FormWith
      include Phlex::Rails::Helpers::LinkTo

      def initialize(task:, attachment:)
        @task = task
        @attachment = attachment
      end

      def template
        content_tag('turbo-frame', id: dom_id(@task, :attachments)) do
          div(class: 'card') {
            div(class: 'card-body') {
              render(form_component_class.new(task: @task, attachment: @attachment))
            }
          }
        end
      end

      private

      def form_component_class
        if @attachment.is_a?(InnerPlan::Attachments::Link)
          InnerPlan::Attachments::LinkFormComponent
        elsif @attachment.is_a?(InnerPlan::Attachments::Document)
          InnerPlan::Attachments::DocumentFormComponent
        else
          raise "#{@attachment.type} is not supported by that form"
        end
      end
    end
  end
end
