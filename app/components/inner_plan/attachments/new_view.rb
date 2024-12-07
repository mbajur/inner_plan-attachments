module InnerPlan
  module Attachments
    class NewView < InnerPlan::ApplicationView
      include Phlex::Rails::Helpers::DOMID
      include Phlex::Rails::Helpers::ContentTag
      include Phlex::Rails::Helpers::LinkTo

      def initialize(task:, attachment:)
        @task = task
        @attachment = attachment
      end

      def template
        content_tag('turbo-frame', id: dom_id(@task, :attachments)) do
          div(class: 'card') {
            div(class: 'card-body') {
              if @attachment.type.present?
                render(form_component_class.new(task: @task, attachment: @attachment))
              else
                div(class: 'btn-group w-100') {
                  link_to(helpers.new_task_attachment_path(attachment: { type: 'InnerPlan::Attachments::Link' }), class: 'btn btn-light') {
                    render(Phlex::Icons::Tabler::Link.new(width: 18, height: 18, class: 'me-2'))
                    plain 'Add link'
                  }

                  link_to(helpers.new_task_attachment_path(attachment: { type: 'InnerPlan::Attachments::Document' }), class: 'btn btn-light') {
                    render(Phlex::Icons::Tabler::Photo.new(width: 18, height: 18, class: 'me-2'))
                    plain 'Add document'
                  }
                }
              end
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
