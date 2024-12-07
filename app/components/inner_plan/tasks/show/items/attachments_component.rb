module InnerPlan::Tasks::Show::Items
  class AttachmentsComponent < Phlex::HTML
    include Phlex::Rails::Helpers::DOMID
    include Phlex::Rails::Helpers::ContentTag

    def initialize(task:)
      @task = task
    end

    def template
      render(
        InnerPlan::Tasks::Show::ItemComponent.new(icon: Phlex::Icons::Tabler::Paperclip, title: 'Attachments') do |c|
          c.with_actions do
            a(class: 'btn btn-light btn-sm', href: helpers.new_task_attachment_path(@task), data: { turbo_frame: dom_id(@task, :attachments) }) { 'Add' }
          end

          c.with_body do
            content_tag('turbo-frame', id: dom_id(@task, :attachments), src: helpers.task_attachments_path(@task)) {
              plain 'Loading...'
            }
          end
        end
      )
    end
  end
end
