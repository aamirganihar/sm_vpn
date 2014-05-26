# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{watir}
  s.version = "1.6.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bret Pettichord"]
  s.date = %q{2009-11-10}
  s.default_executable = %q{watir-console}
  s.description = %q{    WATIR is "Web Application Testing in Ruby". Watir (pronounced water) is a free,
    open-source functional testing tool for automating browser-based tests of web applications.
    It works with applications written in any language.
    Watir drives the Internet Explorer browser the same way an end user would.
    It clicks links, fills in forms, presses buttons.
    Watir also checks results, such as whether expected text appears on the
    page, or whether a control is enabled.
    Watir can test web applications written in any language.
    Watir is a Ruby library that works with Internet Explorer on Windows.
}
  s.email = %q{watir-general@groups.google.com}
  s.executables = ["watir-console"]
  s.files = ["CHANGES", "lib/watir/camel_case.rb", "lib/watir/clickJSDialog.rb", "lib/watir/close_all.rb", "lib/watir/collections.rb", "lib/watir/container.rb", "lib/watir/cookiemanager.rb", "lib/watir/core_ext.rb", "lib/watir/datahandler.rb", "lib/watir/dialog.rb", "lib/watir/element.rb", "lib/watir/element_collections.rb", "lib/watir/form.rb", "lib/watir/frame.rb", "lib/watir/ie-class.rb", "lib/watir/ie-process.rb", "lib/watir/ie.rb", "lib/watir/image.rb", "lib/watir/input_elements.rb", "lib/watir/irb-history.rb", "lib/watir/link.rb", "lib/watir/locator.rb", "lib/watir/logger.rb", "lib/watir/modal_dialog.rb", "lib/watir/non_control_elements.rb", "lib/watir/page-container.rb", "lib/watir/popup.rb", "lib/watir/process.rb", "lib/watir/screen_capture.rb", "lib/watir/setFileDialog.rb", "lib/watir/table.rb", "lib/watir/utils.rb", "lib/watir/version.rb", "lib/watir/watir_simple.rb", "lib/watir/win32.rb", "lib/watir/win32ole.rb", "lib/watir/winClicker.rb", "lib/watir/WindowHelper.rb", "lib/watir/AutoItX3.dll", "unittests/all_tests.rb", "unittests/buttons_xpath_test.rb", "unittests/checkbox_test.rb", "unittests/checkbox_xpath_test.rb", "unittests/core_tests.rb", "unittests/css_test.rb", "unittests/defer_test.rb", "unittests/dialog_test.rb", "unittests/div2_xpath_test.rb", "unittests/div_test.rb", "unittests/div_xpath_test.rb", "unittests/errorchecker_test.rb", "unittests/filefield_test.rb", "unittests/filefield_xpath_test.rb", "unittests/form_test.rb", "unittests/form_xpath_test.rb", "unittests/frame_test.rb", "unittests/google_form_test.rb", "unittests/ie_exists_test.rb", "unittests/ie_mock.rb", "unittests/ie_test.rb", "unittests/images_test.rb", "unittests/images_xpath_test.rb", "unittests/links_multi_test.rb", "unittests/links_test.rb", "unittests/links_xpath_test.rb", "unittests/lists_test.rb", "unittests/map_test.rb", "unittests/minmax_test.rb", "unittests/navigate_test.rb", "unittests/nbsp_xpath_test.rb", "unittests/non_core_tests.rb", "unittests/pagecontainstext_test.rb", "unittests/parent_child_test.rb", "unittests/perf_test.rb", "unittests/popups_test.rb", "unittests/pre_test.rb", "unittests/radios_test.rb", "unittests/radios_xpath_test.rb", "unittests/security_setting_test.rb", "unittests/selectbox_test.rb", "unittests/selectbox_xpath_test.rb", "unittests/setup.rb", "unittests/speed_settings_test.rb", "unittests/table_cell_using_xpath_test.rb", "unittests/table_test.rb", "unittests/table_xpath_test.rb", "unittests/test_tests.rb", "unittests/textarea_test.rb", "unittests/textarea_xpath_test.rb", "unittests/textfields_test.rb", "unittests/textfields_xpath_test.rb", "unittests/textfield_for_ch_char_test.rb", "unittests/window_tests.rb", "unittests/xpath_tests.rb", "unittests/html/blankpage.html", "unittests/html/buttons1.html", "unittests/html/checkboxes1.html", "unittests/html/complex_table.html", "unittests/html/cssTest.html", "unittests/html/depot_store.html", "unittests/html/div.html", "unittests/html/div_xml.html", "unittests/html/fileupload.html", "unittests/html/forms2.html", "unittests/html/forms3.html", "unittests/html/forms4.html", "unittests/html/formTest1.html", "unittests/html/frame_buttons.html", "unittests/html/frame_links.html", "unittests/html/frame_multi.html", "unittests/html/google_india.html", "unittests/html/iframeTest.html", "unittests/html/iframeTest1.html", "unittests/html/iframeTest2.html", "unittests/html/images1.html", "unittests/html/JavascriptClick.html", "unittests/html/javascriptevents.html", "unittests/html/links1.html", "unittests/html/links2.html", "unittests/html/links_multi.html", "unittests/html/link_pass.html", "unittests/html/lists.html", "unittests/html/list_matters.html", "unittests/html/map_test.html", "unittests/html/modal_dialog.html", "unittests/html/modal_dialog_launcher.html", "unittests/html/nestedFrames.html", "unittests/html/new_browser.html", "unittests/html/pass.html", "unittests/html/popups1.html", "unittests/html/pre.html", "unittests/html/radioButtons1.html", "unittests/html/selectboxes1.html", "unittests/html/select_tealeaf.html", "unittests/html/simple_table.html", "unittests/html/simple_table_buttons.html", "unittests/html/simple_table_columns.html", "unittests/html/table1.html", "unittests/html/tableCell_using_xpath.html", "unittests/html/textarea.html", "unittests/html/textfields1.html", "unittests/html/textsearch.html", "unittests/html/wallofcheckboxes.html", "unittests/html/xpath_nbsp.html", "unittests/html/images/1.gif", "unittests/html/images/2.GIF", "unittests/html/images/3.GIF", "unittests/html/images/button.jpg", "unittests/html/images/circle.jpg", "unittests/html/images/map.GIF", "unittests/html/images/map2.gif", "unittests/html/images/minus.GIF", "unittests/html/images/originaltriangle.jpg", "unittests/html/images/plus.gif", "unittests/html/images/square.jpg", "unittests/html/images/triangle.jpg", "unittests/other/all_tests_concurrent.rb", "unittests/other/jscriptExtraAlert.rb", "unittests/other/jscriptExtraConfirmCancel.rb", "unittests/other/jscriptExtraConfirmOk.rb", "unittests/other/jscriptPushButton.rb", "unittests/other/jscript_test.rb", "unittests/other/navigate_exception_test.rb", "unittests/other/rexml_unit_test.rb", "unittests/other/screen_capture_test.rb", "unittests/other/testcase_method_order_test.rb", "unittests/other/testcase_verify_test.rb", "unittests/other/wait_until_test.rb", "unittests/other/WindowLogonExample.rb", "unittests/other/WindowLogonExtra.rb", "unittests/windows/attach_to_existing_window_test.rb", "unittests/windows/attach_to_new_window_test.rb", "unittests/windows/close_window_test.rb", "unittests/windows/frame_links_test.rb", "unittests/windows/ie-each_test.rb", "unittests/windows/iedialog_test.rb", "unittests/windows/js_events_test.rb", "unittests/windows/modal_dialog_test.rb", "unittests/windows/new_test.rb", "unittests/windows/open_close_test.rb", "unittests/windows/send_keys_test.rb", "lib/watir/IEDialog/Release/IEDialog.dll", "lib/watir/win32ole/win32ole.so", "lib/watir/contrib/enabled_popup.rb", "lib/watir/contrib/ie-new-process.rb", "lib/watir/contrib/page_checker.rb", "lib/readme.rb", "lib/changes.rb", "lib/license.rb", "bin/watir-console"]
  s.homepage = %q{http://www.watir.com/}
  s.rdoc_options = ["--title", "Watir API Reference", "--accessor", "def_wrap=R,def_wrap_guard=R,def_creator=R,def_creator_with_default=R", "--main", "Watir::IE", "--exclude", "unittests|camel_case.rb"]
  s.require_paths = ["lib"]
  s.requirements = ["Microsoft Windows running Internet Explorer 5.5 or later."]
  s.rubyforge_project = %q{Watir}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Automated testing tool for web applications.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<win32-process>, [">= 0.5.5"])
      s.add_runtime_dependency(%q<windows-pr>, [">= 0.6.6"])
      s.add_runtime_dependency(%q<commonwatir>, ["= 1.6.5"])
      s.add_runtime_dependency(%q<firewatir>, ["= 1.6.5"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
    else
      s.add_dependency(%q<win32-process>, [">= 0.5.5"])
      s.add_dependency(%q<windows-pr>, [">= 0.6.6"])
      s.add_dependency(%q<commonwatir>, ["= 1.6.5"])
      s.add_dependency(%q<firewatir>, ["= 1.6.5"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
    end
  else
    s.add_dependency(%q<win32-process>, [">= 0.5.5"])
    s.add_dependency(%q<windows-pr>, [">= 0.6.6"])
    s.add_dependency(%q<commonwatir>, ["= 1.6.5"])
    s.add_dependency(%q<firewatir>, ["= 1.6.5"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
  end
end
