Rails.application.routes.draw do
  mount InnerPlan::Attachments::Engine => "/inner_plan-attachments"
end
