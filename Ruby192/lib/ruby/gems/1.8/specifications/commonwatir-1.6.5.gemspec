# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{commonwatir}
  s.version = "1.6.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bret Pettichord"]
  s.date = %q{2009-11-10}
  s.description = %q{Common code used by Watir and FireWatir}
  s.email = ["bret@pettichord.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "lib/watir.rb", "lib/commonwatir.rb", "lib/watir/assertions.rb", "lib/watir/browser.rb", "lib/watir/browsers.rb", "lib/watir/exceptions.rb", "lib/watir/matches.rb", "lib/watir/options.rb", "lib/watir/testcase.rb", "lib/watir/waiter.rb"]
  s.homepage = %q{http://www.watir.com}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{wtr}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Common code used by Watir and FireWatir}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<user-choices>, [">= 0"])
      s.add_development_dependency(%q<hoe>, [">= 2.3.3"])
    else
      s.add_dependency(%q<user-choices>, [">= 0"])
      s.add_dependency(%q<hoe>, [">= 2.3.3"])
    end
  else
    s.add_dependency(%q<user-choices>, [">= 0"])
    s.add_dependency(%q<hoe>, [">= 2.3.3"])
  end
end
