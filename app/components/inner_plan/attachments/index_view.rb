module InnerPlan
  module Attachments
    class IndexView < InnerPlan::ApplicationView
      include Phlex::Rails::Helpers::ImageTag
      include Phlex::Rails::Helpers::ContentTag
      include Phlex::Rails::Helpers::DOMID
      include Phlex::Rails::Helpers::LinkTo
      include Phlex::Rails::Helpers::ButtonTo

      def initialize(task:, attachments:)
        @task = task
        @attachments = attachments
      end

      def template
        content_tag('turbo-frame', id: dom_id(@task, :attachments)) do
          div(class: 'list-group') {
            if @attachments.none?
              div(class: 'text-body-tertiary') {
                link_to(helpers.new_task_attachment_path(@task), class: 'text-reset text-decoration-none') { 'Click to add attachment...' }
              }
            end

            if @attachments.links.any?
              h6(class: 'text-secondary') { plain "Links" }
              @attachments.links.each do |attachment|
                div(class: 'list-group-item d-flex gap-2 align-items-center') {
                  div(class: 'd-block') {
                    if attachment.page_favicon_url
                      image_tag attachment.page_favicon_url, size: 16, class: 'd-block'
                    else
                      render(Phlex::Icons::Tabler::Link.new(width: 16, height: 16))
                    end
                  }
                  a(href: attachment.url, target: :_blank, class: 'text-decoration-none flex-grow-1') {
                    plain (attachment.display_text.presence || attachment.page_title || attachment.url)
                  }

                  div(class: 'dropdown') {
                    a(class: 'btn btn-sm btn-light py-1', data: { bs_toggle: :dropdown }) {
                      render(Phlex::Icons::Tabler::Dots.new(width: 15, height: 15))
                    }

                    ul(class: 'dropdown-menu') {
                      li {
                        link_to(helpers.edit_task_attachment_path(@task, attachment), class: 'dropdown-item d-flex align-items-center gap-2') {
                          render(Phlex::Icons::Tabler::Pencil.new(width: 18, height: 18))
                          span { plain "Edit link" }
                        }
                      }

                      li {
                        button_to(helpers.task_attachment_path(@task, attachment), class: 'dropdown-item d-flex align-items-center gap-2', method: :delete, data: { turbo_confirm: 'Are you sure?' }) {
                          render(Phlex::Icons::Tabler::Trash.new(width: 18, height: 18))
                          span { plain "Delete" }
                        }
                      }
                    }
                  }
                }
              end
            end

            if @attachments.documents.any?
              h6(class: 'text-secondary mt-3') { plain "Documents" }
              @attachments.documents.each do |attachment|
                div(class: 'd-flex gap-3 align-items-center mb-2') {
                  a(href: helpers.main_app.url_for(attachment.file), class: 'card overflow-hidden', style: 'width: 70px; height: 70px') {
                    if attachment.file_blob.previewable?
                      image_tag helpers.main_app.url_for(attachment.file.preview(resize_to_fill: [100, 100]))
                    else
                      image_tag helpers.main_app.url_for(attachment.file.variant(resize_to_fill: [100, 100]))
                    end
                  }

                  div(class: 'flex-grow-1') {
                    div(class: 'mb-1') {
                      span(class: 'fw-bold') { plain attachment.display_text.presence || attachment.file.filename.to_s }
                    }

                    p(class: 'text-body-tertiary mb-0') {
                      plain "Added #{attachment.created_at.strftime('%a, %b %e %H:%m')}"
                    }
                  }

                  div(class: 'dropdown') {
                    a(href: helpers.main_app.url_for(attachment.file), target: :_blank, class: "btn btn-link ms-2 text-reset") {
                      render(Phlex::Icons::Tabler::ArrowUpRight.new(width: 15, height: 15))
                    }

                    a(class: 'btn btn-sm btn-light', data: { bs_toggle: :dropdown }) {
                      render(Phlex::Icons::Tabler::Dots.new(width: 15, height: 15))
                    }

                    ul(class: 'dropdown-menu') {
                      li {
                        link_to(helpers.edit_task_attachment_path(@task, attachment), class: 'dropdown-item d-flex align-items-center gap-2') {
                          render(Phlex::Icons::Tabler::Pencil.new(width: 18, height: 18))
                          span { plain "Edit attachment" }
                        }
                      }
                    }
                  }
                }
              end
            end
          }
        end
      end
    end
  end
end
