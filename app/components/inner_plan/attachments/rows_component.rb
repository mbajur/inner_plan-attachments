module InnerPlan::Attachments
  class RowsComponent < Phlex::HTML
    include Phlex::Rails::Helpers::ImageTag
    include Phlex::Rails::Helpers::FormWith

    def initialize(task:)
      @task = task
    end

    def template
      div(class: 'mt-3') {
        div(class: 'mb-3') {
          h6(class: 'text-secondary') { plain "Links" }

          div(class: 'dropdown') {
            a(href: '#', class: 'btn btn-light', data: { bs_toggle: :dropdown, bs_auto_close: :outside }) {
              plain "Add"
            }

            div(class: 'dropdown-menu') {
              form_with model: [@task, InnerPlan::Attachment.new], class: 'px-3 py-2' do |f|
                div(class: 'form-group mb-3') {
                  f.label :url, 'Link to add', class: 'form-label'
                  f.url_field :url, class: 'form-control', placeholder: 'https://...'
                }
                div(class: 'form-group mb-3') {
                  f.label :display_text, 'Display text (optional)', class: 'form-label'
                  f.text_field :display_text, class: 'form-control'
                }
                f.submit 'Add attachment', class: 'btn btn-primary btn-sm w-100'
              end
            }
          }
        }

        h6(class: 'text-secondary') { plain "Images" }
        3.times do
          div(class: 'd-flex gap-3 align-items-center mb-2') {
            a(class: 'card overflow-hidden', style: 'width: 70px; height: 70px') {
              image_tag 'https://trello.com/1/cards/65f17883af9fb911b2d40a2c/attachments/65f1788ba58c798ef5b9dec8/previews/65f1788ba58c798ef5b9e066/download/432745143_1149465576326676_3672928158310672206_n.jpg'
            }

            div(class: 'flex-grow-1') {
              div(class: 'mb-1') {
                span(class: 'fw-bold') { plain '432745143_1149465576326676_3672928158310672206_n.jpg' }
              }

              p(class: 'text-body-tertiary mb-0') {
                plain "Added Mar 13, 2024, 10:57 AM"
              }
            }

            div(class: 'dropdown') {
              a(class: "btn btn-link ms-2 text-reset") {
                render(Phlex::Icons::Tabler::ArrowUpRight.new(width: 15, height: 15))
              }

              a(class: 'btn btn-sm btn-light', data: { bs_toggle: :dropdown }) {
                render(Phlex::Icons::Tabler::Dots.new(width: 15, height: 15))
              }

              ul(class: 'dropdown-menu') {
                li {
                  a(class: 'dropdown-item d-flex align-items-center gap-2') {
                    render(Phlex::Icons::Tabler::Pencil.new(width: 18, height: 18))
                    span { plain "Edit attachment" }
                  }
                }
              }
            }
          }
        end
      }
    end
  end
end
