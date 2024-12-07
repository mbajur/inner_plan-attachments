module InnerPlan::Attachments
  class LinkFormComponent < Phlex::HTML
    include Phlex::Rails::Helpers::FormWith
    include Phlex::Rails::Helpers::LinkTo

    def initialize(task:, attachment:)
      @task = task
      @attachment = attachment
    end

    def template
      form_with model: [@task, @attachment], url: form_url, scope: :attachment do |f|
        f.hidden_field :type

        div(class: 'form-group mb-3') {
          f.label :url, 'Paste a link', class: 'form-label'
          f.url_field :url, class: 'form-control', placeholder: 'https://...', autofocus: true
        }

        div(class: 'form-group mb-3') {
          f.label :display_text, 'Display text (optional)', class: 'form-label'
          f.text_field :display_text, class: 'form-control'
        }

        div(class: 'd-flex gap-2') {
          f.submit (f.object.new_record? ? 'Add attachment' : 'Update attachment'), class: 'btn btn-primary btn-sm'
          link_to 'Cancel', helpers.task_attachments_path(@task), class: 'btn btn-light btn-sm'
        }
      end
    end

    private

    def form_url
      [@task, @attachment.becomes(InnerPlan::Attachment)]
    end
  end
end
