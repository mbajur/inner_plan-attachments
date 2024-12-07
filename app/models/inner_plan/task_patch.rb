module InnerPlan
  module TaskPatch
    def self.prepended(base)
      base.has_many :attachments
    end
  end
end

InnerPlan::Task.prepend(InnerPlan::TaskPatch)
