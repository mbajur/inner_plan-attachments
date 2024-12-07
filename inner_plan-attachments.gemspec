require_relative "lib/inner_plan/attachments/version"

Gem::Specification.new do |spec|
  spec.name        = "inner_plan-attachments"
  spec.version     = InnerPlan::Attachments::VERSION
  spec.authors     = ["mbajur"]
  spec.email       = ["mbajur@gmail.com"]
  spec.homepage    = "https://github.com/mbajur/inner_plan-attachments"
  spec.summary     = "Attachments plugin for InnerPlan"
  spec.description = "Attachments plugin for InnerPlan"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mbajur/inner_plan-attachments"
  spec.metadata["changelog_uri"] = "https://github.com/mbajur/inner_plan-attachments"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1.5"
  spec.add_dependency "image_processing"
  spec.add_dependency "metainspector"
end
