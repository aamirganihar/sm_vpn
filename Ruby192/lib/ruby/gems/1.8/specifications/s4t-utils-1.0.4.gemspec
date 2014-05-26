# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{s4t-utils}
  s.version = "1.0.4"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Marick"]
  s.cert_chain = nil
  s.date = %q{2007-11-19}
  s.description = %q{Unified interface to command-line, environment, and configuration files.}
  s.email = %q{marick@exampler.com}
  s.executables = ["make-s4t-project.rb", "s4t-script-location-file"]
  s.extra_rdoc_files = ["History.txt", "LICENSE.txt", "Manifest.txt", "NOTES.txt", "README.txt"]
  s.files = ["History.txt", "LICENSE.txt", "Manifest.txt", "NOTES.txt", "README.txt", "Rakefile", "bin/make-s4t-project.rb", "bin/s4t-script-location-file", "data/make-s4t-project/README-skeleton", "data/make-s4t-project/Rakefile.example", "data/make-s4t-project/bin-skeleton", "data/make-s4t-project/main-lib-skeleton", "data/make-s4t-project/set-standalone-test-paths.rb", "data/make-s4t-project/setup.rb", "data/make-s4t-project/sub-lib-skeleton", "data/make-s4t-project/test-skeleton", "data/make-s4t-project/version-skeleton", "homepage/index.html", "lib/s4t-utils.rb", "lib/s4t-utils/capturing-globals.rb", "lib/s4t-utils/claims.rb", "lib/s4t-utils/command-line.rb", "lib/s4t-utils/error-handling.rb", "lib/s4t-utils/friendly-format.rb", "lib/s4t-utils/hacks.rb", "lib/s4t-utils/hoelike.rb", "lib/s4t-utils/load-path-auto-adjuster.rb", "lib/s4t-utils/more-assertions.rb", "lib/s4t-utils/os.rb", "lib/s4t-utils/rake-task-helpers.rb", "lib/s4t-utils/rakefile-common.rb", "lib/s4t-utils/ruby-extensions.rb", "lib/s4t-utils/svn-file-movement.rb", "lib/s4t-utils/test-util.rb", "lib/s4t-utils/version.rb", "setup.rb", "test/capturing-globals-tests.rb", "test/data/make-s4t-project/README-skeleton", "test/data/make-s4t-project/Rakefile.example", "test/data/make-s4t-project/bin-skeleton", "test/data/make-s4t-project/main-lib-skeleton", "test/data/make-s4t-project/set-standalone-test-paths.rb", "test/data/make-s4t-project/setup.rb", "test/data/make-s4t-project/sub-lib-skeleton", "test/data/make-s4t-project/test-skeleton", "test/data/make-s4t-project/version-skeleton", "test/data/test-data-location-file", "test/error-handling-tests.rb", "test/friendly-format-tests.rb", "test/hacks-tests.rb", "test/load-path-auto-adjuster-tests.rb", "test/rake-task-helper-tests.rb", "test/set-standalone-test-paths.rb", "test/test-location-file", "test/test-util-tests.rb"]
  s.homepage = %q{http://s4t-utils.rubyforge.org}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.rubyforge_project = %q{s4t-utils}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Unified interface to command-line, environment, and configuration files.}
  s.test_files = ["test/capturing-globals-tests.rb", "test/error-handling-tests.rb", "test/friendly-format-tests.rb", "test/hacks-tests.rb", "test/load-path-auto-adjuster-tests.rb", "test/rake-task-helper-tests.rb", "test/test-util-tests.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hoe>, [">= 1.3.0"])
    else
      s.add_dependency(%q<hoe>, [">= 1.3.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.3.0"])
  end
end
