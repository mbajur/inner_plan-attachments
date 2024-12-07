module InnerPlan::Attachments
  class FetchLinkMetaJob < InnerPlan::ApplicationJob
    def perform(attachment)
      @page = MetaInspector.new(attachment.url)
    rescue MetaInspector::Error => e
      logger.warn "Fetching meta for #{attachment.url} failed: #{e.message}"
    else
      attachment.update(
        page_title: @page.title,
        page_favicon_url: @page.images.favicon
      )
    end
  end
end
