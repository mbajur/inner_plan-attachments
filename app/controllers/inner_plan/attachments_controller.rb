module InnerPlan
  class AttachmentsController < InnerPlan::ApplicationController
    def index
      @task = find_task
      render InnerPlan::Attachments::IndexView.new(task: @task, attachments: @task.attachments)
    end

    def new
      @task = find_task
      @attachment = @task.attachments.new(attachment_params)
      render InnerPlan::Attachments::NewView.new(task: @task, attachment: @attachment)
    end

    def edit
      @task = find_task
      @attachment = find_attachment
      render InnerPlan::Attachments::EditView.new(task: @task, attachment: @attachment)
    end

    def create
      @task = find_task
      @attachment = @task.attachments.new
      @attachment = attachment_params[:type].constantize.new(attachment_params.without(:type)) # @todo add type validation!
      @attachment.task = @task

      if @attachment.save
        InnerPlan::Attachments::FetchLinkMetaJob.perform_now(@attachment)
        redirect_to task_attachments_path(@task)
      else
        render InnerPlan::Attachments::NewView.new(task: @task, attachment: @attachment),
               status: :unprocessable_entity
      end
    end

    def update
      @task = find_task
      @attachment = find_attachment

      if @attachment.update(attachment_params)
        InnerPlan::Attachments::FetchLinkMetaJob.perform_now(@attachment) if @attachment.saved_change_to_url?
        redirect_to task_attachments_path(@task)
      else
        render InnerPlan::Attachments::EditView.new(task: @task, attachment: @attachment),
               status: :unprocessable_entity
      end
    end

    def destroy
      @task = find_task
      @attachment = find_attachment
      @attachment.destroy

      redirect_to task_attachments_path(@task)
    end

    private

    def find_task
      @find_task ||= InnerPlan::Task.find(params[:task_id])
    end

    def find_attachment
      @find_attachment ||= find_task.attachments.find(params[:id])
    end

    def attachment_params
      params.fetch(:attachment, {}).permit(:url, :display_text, :type, :file)
    end
  end
end
