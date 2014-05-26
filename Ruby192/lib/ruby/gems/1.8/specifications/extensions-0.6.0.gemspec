# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{extensions}
  s.version = "0.6.0"

  s.required_rubygems_version = nil if s.respond_to? :required_rubygems_version=
  s.cert_chain = nil
  s.date = %q{2004-12-09}
  s.default_executable = %q{rbxtm}
  s.description = %q{'extensions' is a set of extensions to Ruby's built-in classes.  It gathers common idioms, useful additions, and aliases, complete with unit testing and documentation, so they are suitable for production code. See http://extensions.rubyforge.org for full documentation.}
  s.email = %q{gsinclair@soyabean.com.au}
  s.executables = ["rbxtm"]
  s.extra_rdoc_files = ["README"]
  s.files = ["ChangeLog", "HISTORY", "Rakefile", "README", "README.1st", "VERSION", "install-doc.rb", "install.rb", "install.sh", "bin/rbxtm", "lib/extensions", "lib/extensions/all.rb", "lib/extensions/array.rb", "lib/extensions/binding.rb", "lib/extensions/class.rb", "lib/extensions/continuation.rb", "lib/extensions/enumerable.rb", "lib/extensions/hash.rb", "lib/extensions/io.rb", "lib/extensions/kernel.rb", "lib/extensions/module.rb", "lib/extensions/numeric.rb", "lib/extensions/object.rb", "lib/extensions/ostruct.rb", "lib/extensions/string.rb", "lib/extensions/symbol.rb", "lib/extensions/_base.rb", "lib/extensions/_template.rb", "./test/data", "./test/tc_array.rb", "./test/tc_binding.rb", "./test/tc_class.rb", "./test/tc_continuation.rb", "./test/tc_enumerable.rb", "./test/tc_hash.rb", "./test/tc_io.rb", "./test/tc_kernel.rb", "./test/tc_module.rb", "./test/tc_numeric.rb", "./test/tc_object.rb", "./test/tc_ostruct.rb", "./test/tc_string.rb", "./test/tc_symbol.rb", "./test/TEST.rb", "./test/data/kernel_test", "./test/data/kernel_test/global_var_1.rb", "./test/data/kernel_test/global_var_2.rb", "etc/checklist", "etc/website", "etc/website/index.html", "etc/website/upload.sh", "test/tc_array.rb", "test/tc_binding.rb", "test/tc_class.rb", "test/tc_continuation.rb", "test/tc_enumerable.rb", "test/tc_hash.rb", "test/tc_io.rb", "test/tc_kernel.rb", "test/tc_module.rb", "test/tc_numeric.rb", "test/tc_object.rb", "test/tc_ostruct.rb", "test/tc_string.rb", "test/tc_symbol.rb"]
  s.homepage = %q{http://extensions.rubyforge.org}
  s.rdoc_options = ["--title", "Ruby/Extensions API Documentation", "--main", "README", "--inline-source"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new("> 0.0.0")
  s.requirements = ["Ruby 1.8 (or 'ruby_shim' from RAA)"]
  s.rubyforge_project = %q{extensions}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{'extensions' is a set of extensions to Ruby's built-in classes.  It gathers common idioms, useful additions, and aliases, complete with unit testing and documentation, so they are suitable for production code.}
  s.test_files = ["test/tc_array.rb", "test/tc_binding.rb", "test/tc_class.rb", "test/tc_continuation.rb", "test/tc_enumerable.rb", "test/tc_hash.rb", "test/tc_io.rb", "test/tc_kernel.rb", "test/tc_module.rb", "test/tc_numeric.rb", "test/tc_object.rb", "test/tc_ostruct.rb", "test/tc_string.rb", "test/tc_symbol.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 1

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
