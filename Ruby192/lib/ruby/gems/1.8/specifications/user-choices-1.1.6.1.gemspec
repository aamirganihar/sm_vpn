# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{user-choices}
  s.version = "1.1.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Marick"]
  s.date = %q{2010-01-15}
  s.description = %q{Unified interface to command-line, environment, and configuration files.}
  s.email = %q{marick@exampler.com}
  s.extra_rdoc_files = ["History.txt", "LICENSE.txt", "Manifest.txt", "README.txt", "examples/older/README.txt", "examples/tutorial/css/LICENSE.txt"]
  s.files = ["History.txt", "LICENSE.txt", "Manifest.txt", "README.txt", "Rakefile", "examples/older/README.txt", "examples/older/command-line.rb", "examples/older/default-values.rb", "examples/older/multiple-sources.rb", "examples/older/postprocess.rb", "examples/older/switches.rb", "examples/older/two-args.rb", "examples/older/types.rb", "examples/tutorial/css/LICENSE.txt", "examples/tutorial/css/bg2.gif", "examples/tutorial/css/left.gif", "examples/tutorial/css/left_on.gif", "examples/tutorial/css/main.css", "examples/tutorial/css/right.gif", "examples/tutorial/css/right_on.gif", "examples/tutorial/css/tvline.gif", "examples/tutorial/css/von-foerster.jpg", "examples/tutorial/css/von-foerster2.jpg", "examples/tutorial/index.html", "examples/tutorial/tutorial1.rb", "examples/tutorial/tutorial2.rb", "examples/tutorial/tutorial3.rb", "examples/tutorial/tutorial4.rb", "examples/tutorial/tutorial5.rb", "examples/tutorial/tutorial6.rb", "examples/tutorial/tutorial7.rb", "lib/user-choices.rb", "lib/user-choices/arglist-strategies.rb", "lib/user-choices/builder.rb", "lib/user-choices/command-line-source.rb", "lib/user-choices/command.rb", "lib/user-choices/conversions.rb", "lib/user-choices/ruby-extensions.rb", "lib/user-choices/sources.rb", "lib/user-choices/version.rb", "setup.rb", "test/arglist-strategy-tests.rb", "test/builder-tests.rb", "test/command-line-source-tests.rb", "test/conversion-tests.rb", "test/source-tests.rb", "test/user-choices-slowtests.rb"]
  s.homepage = %q{http://user-choices.rubyforge.org}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{user-choices}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Unified interface to command-line, environment, and configuration files.}
  s.test_files = ["test/arglist-strategy-tests.rb", "test/builder-tests.rb", "test/command-line-source-tests.rb", "test/conversion-tests.rb", "test/source-tests.rb", "test/user-choices-slowtests.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<xml-simple>, [">= 1.0.11"])
      s.add_runtime_dependency(%q<s4t-utils>, [">= 1.0.3"])
      s.add_runtime_dependency(%q<builder>, [">= 2.1.2"])
      s.add_development_dependency(%q<hoe>, [">= 2.3.3"])
    else
      s.add_dependency(%q<xml-simple>, [">= 1.0.11"])
      s.add_dependency(%q<s4t-utils>, [">= 1.0.3"])
      s.add_dependency(%q<builder>, [">= 2.1.2"])
      s.add_dependency(%q<hoe>, [">= 2.3.3"])
    end
  else
    s.add_dependency(%q<xml-simple>, [">= 1.0.11"])
    s.add_dependency(%q<s4t-utils>, [">= 1.0.3"])
    s.add_dependency(%q<builder>, [">= 2.1.2"])
    s.add_dependency(%q<hoe>, [">= 2.3.3"])
  end
end
