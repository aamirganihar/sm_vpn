# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{timezone}
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pan Thomakos"]
  s.date = %q{2013-10-21}
  s.description = %q{A simple way to get accurate current and historical timezone information based on zone or latitude and longitude coordinates. This gem uses the tz database (http://www.twinsun.com/tz/tz-link.htm) for historical timezone information. It also uses the geonames API for timezone latitude and longitude lookup (http://www.geonames.org/export/web-services.html).}
  s.email = ["pan.thomakos@gmail.com"]
  s.extra_rdoc_files = ["README.markdown", "License.txt"]
  s.files = [".gitignore", ".travis.yml", "CHANGES.markdown", "CONTRIBUTING.markdown", "Gemfile", "License.txt", "README.markdown", "Rakefile", "data/Africa/Abidjan.json", "data/Africa/Accra.json", "data/Africa/Addis_Ababa.json", "data/Africa/Algiers.json", "data/Africa/Asmara.json", "data/Africa/Bamako.json", "data/Africa/Bangui.json", "data/Africa/Banjul.json", "data/Africa/Bissau.json", "data/Africa/Blantyre.json", "data/Africa/Brazzaville.json", "data/Africa/Bujumbura.json", "data/Africa/Cairo.json", "data/Africa/Casablanca.json", "data/Africa/Ceuta.json", "data/Africa/Conakry.json", "data/Africa/Dakar.json", "data/Africa/Dar_es_Salaam.json", "data/Africa/Djibouti.json", "data/Africa/Douala.json", "data/Africa/El_Aaiun.json", "data/Africa/Freetown.json", "data/Africa/Gaborone.json", "data/Africa/Harare.json", "data/Africa/Johannesburg.json", "data/Africa/Juba.json", "data/Africa/Kampala.json", "data/Africa/Khartoum.json", "data/Africa/Kigali.json", "data/Africa/Kinshasa.json", "data/Africa/Lagos.json", "data/Africa/Libreville.json", "data/Africa/Lome.json", "data/Africa/Luanda.json", "data/Africa/Lubumbashi.json", "data/Africa/Lusaka.json", "data/Africa/Malabo.json", "data/Africa/Maputo.json", "data/Africa/Maseru.json", "data/Africa/Mbabane.json", "data/Africa/Mogadishu.json", "data/Africa/Monrovia.json", "data/Africa/Nairobi.json", "data/Africa/Ndjamena.json", "data/Africa/Niamey.json", "data/Africa/Nouakchott.json", "data/Africa/Ouagadougou.json", "data/Africa/Porto-Novo.json", "data/Africa/Sao_Tome.json", "data/Africa/Tripoli.json", "data/Africa/Tunis.json", "data/Africa/Windhoek.json", "data/America/Adak.json", "data/America/Anchorage.json", "data/America/Anguilla.json", "data/America/Antigua.json", "data/America/Araguaina.json", "data/America/Argentina/Buenos_Aires.json", "data/America/Argentina/Catamarca.json", "data/America/Argentina/Cordoba.json", "data/America/Argentina/Jujuy.json", "data/America/Argentina/La_Rioja.json", "data/America/Argentina/Mendoza.json", "data/America/Argentina/Rio_Gallegos.json", "data/America/Argentina/Salta.json", "data/America/Argentina/San_Juan.json", "data/America/Argentina/San_Luis.json", "data/America/Argentina/Tucuman.json", "data/America/Argentina/Ushuaia.json", "data/America/Aruba.json", "data/America/Asuncion.json", "data/America/Atikokan.json", "data/America/Bahia.json", "data/America/Bahia_Banderas.json", "data/America/Barbados.json", "data/America/Belem.json", "data/America/Belize.json", "data/America/Blanc-Sablon.json", "data/America/Boa_Vista.json", "data/America/Bogota.json", "data/America/Boise.json", "data/America/Cambridge_Bay.json", "data/America/Campo_Grande.json", "data/America/Cancun.json", "data/America/Caracas.json", "data/America/Cayenne.json", "data/America/Cayman.json", "data/America/Chicago.json", "data/America/Chihuahua.json", "data/America/Coral_Harbour.json", "data/America/Costa_Rica.json", "data/America/Creston.json", "data/America/Cuiaba.json", "data/America/Curacao.json", "data/America/Danmarkshavn.json", "data/America/Dawson.json", "data/America/Dawson_Creek.json", "data/America/Denver.json", "data/America/Detroit.json", "data/America/Dominica.json", "data/America/Edmonton.json", "data/America/Eirunepe.json", "data/America/El_Salvador.json", "data/America/Fortaleza.json", "data/America/Glace_Bay.json", "data/America/Godthab.json", "data/America/Goose_Bay.json", "data/America/Grand_Turk.json", "data/America/Grenada.json", "data/America/Guadeloupe.json", "data/America/Guatemala.json", "data/America/Guayaquil.json", "data/America/Guyana.json", "data/America/Halifax.json", "data/America/Havana.json", "data/America/Hermosillo.json", "data/America/Indiana/Indianapolis.json", "data/America/Indiana/Knox.json", "data/America/Indiana/Marengo.json", "data/America/Indiana/Petersburg.json", "data/America/Indiana/Tell_City.json", "data/America/Indiana/Vevay.json", "data/America/Indiana/Vincennes.json", "data/America/Indiana/Winamac.json", "data/America/Inuvik.json", "data/America/Iqaluit.json", "data/America/Jamaica.json", "data/America/Juneau.json", "data/America/Kentucky/Louisville.json", "data/America/Kentucky/Monticello.json", "data/America/Kralendijk.json", "data/America/La_Paz.json", "data/America/Lima.json", "data/America/Los_Angeles.json", "data/America/Lower_Princes.json", "data/America/Maceio.json", "data/America/Managua.json", "data/America/Manaus.json", "data/America/Marigot.json", "data/America/Martinique.json", "data/America/Matamoros.json", "data/America/Mazatlan.json", "data/America/Menominee.json", "data/America/Merida.json", "data/America/Metlakatla.json", "data/America/Mexico_City.json", "data/America/Miquelon.json", "data/America/Moncton.json", "data/America/Monterrey.json", "data/America/Montevideo.json", "data/America/Montreal.json", "data/America/Montserrat.json", "data/America/Nassau.json", "data/America/New_York.json", "data/America/Nipigon.json", "data/America/Nome.json", "data/America/Noronha.json", "data/America/North_Dakota/Beulah.json", "data/America/North_Dakota/Center.json", "data/America/North_Dakota/New_Salem.json", "data/America/Ojinaga.json", "data/America/Panama.json", "data/America/Pangnirtung.json", "data/America/Paramaribo.json", "data/America/Phoenix.json", "data/America/Port-au-Prince.json", "data/America/Port_of_Spain.json", "data/America/Porto_Velho.json", "data/America/Puerto_Rico.json", "data/America/Rainy_River.json", "data/America/Rankin_Inlet.json", "data/America/Recife.json", "data/America/Regina.json", "data/America/Resolute.json", "data/America/Rio_Branco.json", "data/America/Santa_Isabel.json", "data/America/Santarem.json", "data/America/Santiago.json", "data/America/Santo_Domingo.json", "data/America/Sao_Paulo.json", "data/America/Scoresbysund.json", "data/America/Shiprock.json", "data/America/Sitka.json", "data/America/St_Barthelemy.json", "data/America/St_Johns.json", "data/America/St_Kitts.json", "data/America/St_Lucia.json", "data/America/St_Thomas.json", "data/America/St_Vincent.json", "data/America/Swift_Current.json", "data/America/Tegucigalpa.json", "data/America/Thule.json", "data/America/Thunder_Bay.json", "data/America/Tijuana.json", "data/America/Toronto.json", "data/America/Tortola.json", "data/America/Vancouver.json", "data/America/Whitehorse.json", "data/America/Winnipeg.json", "data/America/Yakutat.json", "data/America/Yellowknife.json", "data/Antarctica/Casey.json", "data/Antarctica/Davis.json", "data/Antarctica/DumontDUrville.json", "data/Antarctica/Macquarie.json", "data/Antarctica/Mawson.json", "data/Antarctica/McMurdo.json", "data/Antarctica/Palmer.json", "data/Antarctica/Rothera.json", "data/Antarctica/South_Pole.json", "data/Antarctica/Syowa.json", "data/Antarctica/Vostok.json", "data/Arctic/Longyearbyen.json", "data/Asia/Aden.json", "data/Asia/Almaty.json", "data/Asia/Amman.json", "data/Asia/Anadyr.json", "data/Asia/Aqtau.json", "data/Asia/Aqtobe.json", "data/Asia/Ashgabat.json", "data/Asia/Baghdad.json", "data/Asia/Bahrain.json", "data/Asia/Baku.json", "data/Asia/Bangkok.json", "data/Asia/Beirut.json", "data/Asia/Bishkek.json", "data/Asia/Brunei.json", "data/Asia/Choibalsan.json", "data/Asia/Chongqing.json", "data/Asia/Colombo.json", "data/Asia/Damascus.json", "data/Asia/Dhaka.json", "data/Asia/Dili.json", "data/Asia/Dubai.json", "data/Asia/Dushanbe.json", "data/Asia/Gaza.json", "data/Asia/Harbin.json", "data/Asia/Hebron.json", "data/Asia/Ho_Chi_Minh.json", "data/Asia/Hong_Kong.json", "data/Asia/Hovd.json", "data/Asia/Irkutsk.json", "data/Asia/Istanbul.json", "data/Asia/Jakarta.json", "data/Asia/Jayapura.json", "data/Asia/Jerusalem.json", "data/Asia/Kabul.json", "data/Asia/Kamchatka.json", "data/Asia/Karachi.json", "data/Asia/Kashgar.json", "data/Asia/Kathmandu.json", "data/Asia/Kolkata.json", "data/Asia/Krasnoyarsk.json", "data/Asia/Kuala_Lumpur.json", "data/Asia/Kuching.json", "data/Asia/Kuwait.json", "data/Asia/Macau.json", "data/Asia/Magadan.json", "data/Asia/Makassar.json", "data/Asia/Manila.json", "data/Asia/Muscat.json", "data/Asia/Nicosia.json", "data/Asia/Novokuznetsk.json", "data/Asia/Novosibirsk.json", "data/Asia/Omsk.json", "data/Asia/Oral.json", "data/Asia/Phnom_Penh.json", "data/Asia/Pontianak.json", "data/Asia/Pyongyang.json", "data/Asia/Qatar.json", "data/Asia/Qyzylorda.json", "data/Asia/Rangoon.json", "data/Asia/Riyadh.json", "data/Asia/Sakhalin.json", "data/Asia/Samarkand.json", "data/Asia/Seoul.json", "data/Asia/Shanghai.json", "data/Asia/Singapore.json", "data/Asia/Taipei.json", "data/Asia/Tashkent.json", "data/Asia/Tbilisi.json", "data/Asia/Tehran.json", "data/Asia/Thimphu.json", "data/Asia/Tokyo.json", "data/Asia/Ulaanbaatar.json", "data/Asia/Urumqi.json", "data/Asia/Vientiane.json", "data/Asia/Vladivostok.json", "data/Asia/Yakutsk.json", "data/Asia/Yekaterinburg.json", "data/Asia/Yerevan.json", "data/Atlantic/Azores.json", "data/Atlantic/Bermuda.json", "data/Atlantic/Canary.json", "data/Atlantic/Cape_Verde.json", "data/Atlantic/Faroe.json", "data/Atlantic/Madeira.json", "data/Atlantic/Reykjavik.json", "data/Atlantic/South_Georgia.json", "data/Atlantic/St_Helena.json", "data/Atlantic/Stanley.json", "data/Australia/Adelaide.json", "data/Australia/Brisbane.json", "data/Australia/Broken_Hill.json", "data/Australia/Currie.json", "data/Australia/Darwin.json", "data/Australia/Eucla.json", "data/Australia/Hobart.json", "data/Australia/Lindeman.json", "data/Australia/Lord_Howe.json", "data/Australia/Melbourne.json", "data/Australia/Perth.json", "data/Australia/Sydney.json", "data/CET.json", "data/CST6CDT.json", "data/EET.json", "data/EST.json", "data/EST5EDT.json", "data/Etc/GMT+0.json", "data/Etc/GMT+1.json", "data/Etc/GMT+10.json", "data/Etc/GMT+11.json", "data/Etc/GMT+12.json", "data/Etc/GMT+2.json", "data/Etc/GMT+3.json", "data/Etc/GMT+4.json", "data/Etc/GMT+5.json", "data/Etc/GMT+6.json", "data/Etc/GMT+7.json", "data/Etc/GMT+8.json", "data/Etc/GMT+9.json", "data/Etc/GMT-0.json", "data/Etc/GMT-1.json", "data/Etc/GMT-10.json", "data/Etc/GMT-11.json", "data/Etc/GMT-12.json", "data/Etc/GMT-13.json", "data/Etc/GMT-14.json", "data/Etc/GMT-2.json", "data/Etc/GMT-3.json", "data/Etc/GMT-4.json", "data/Etc/GMT-5.json", "data/Etc/GMT-6.json", "data/Etc/GMT-7.json", "data/Etc/GMT-8.json", "data/Etc/GMT-9.json", "data/Etc/GMT.json", "data/Etc/GMT0.json", "data/Etc/Greenwich.json", "data/Etc/UCT.json", "data/Etc/UTC.json", "data/Etc/Universal.json", "data/Etc/Zulu.json", "data/Europe/Amsterdam.json", "data/Europe/Andorra.json", "data/Europe/Athens.json", "data/Europe/Belgrade.json", "data/Europe/Berlin.json", "data/Europe/Bratislava.json", "data/Europe/Brussels.json", "data/Europe/Bucharest.json", "data/Europe/Budapest.json", "data/Europe/Chisinau.json", "data/Europe/Copenhagen.json", "data/Europe/Dublin.json", "data/Europe/Gibraltar.json", "data/Europe/Guernsey.json", "data/Europe/Helsinki.json", "data/Europe/Isle_of_Man.json", "data/Europe/Istanbul.json", "data/Europe/Jersey.json", "data/Europe/Kaliningrad.json", "data/Europe/Kiev.json", "data/Europe/Lisbon.json", "data/Europe/Ljubljana.json", "data/Europe/London.json", "data/Europe/Luxembourg.json", "data/Europe/Madrid.json", "data/Europe/Malta.json", "data/Europe/Mariehamn.json", "data/Europe/Minsk.json", "data/Europe/Monaco.json", "data/Europe/Moscow.json", "data/Europe/Nicosia.json", "data/Europe/Oslo.json", "data/Europe/Paris.json", "data/Europe/Podgorica.json", "data/Europe/Prague.json", "data/Europe/Riga.json", "data/Europe/Rome.json", "data/Europe/Samara.json", "data/Europe/San_Marino.json", "data/Europe/Sarajevo.json", "data/Europe/Simferopol.json", "data/Europe/Skopje.json", "data/Europe/Sofia.json", "data/Europe/Stockholm.json", "data/Europe/Tallinn.json", "data/Europe/Tirane.json", "data/Europe/Uzhgorod.json", "data/Europe/Vaduz.json", "data/Europe/Vatican.json", "data/Europe/Vienna.json", "data/Europe/Vilnius.json", "data/Europe/Volgograd.json", "data/Europe/Warsaw.json", "data/Europe/Zagreb.json", "data/Europe/Zaporozhye.json", "data/Europe/Zurich.json", "data/GMT.json", "data/HST.json", "data/Indian/Antananarivo.json", "data/Indian/Chagos.json", "data/Indian/Christmas.json", "data/Indian/Cocos.json", "data/Indian/Comoro.json", "data/Indian/Kerguelen.json", "data/Indian/Mahe.json", "data/Indian/Maldives.json", "data/Indian/Mauritius.json", "data/Indian/Mayotte.json", "data/Indian/Reunion.json", "data/MET.json", "data/MST.json", "data/MST7MDT.json", "data/PST8PDT.json", "data/Pacific/Apia.json", "data/Pacific/Auckland.json", "data/Pacific/Chatham.json", "data/Pacific/Chuuk.json", "data/Pacific/Easter.json", "data/Pacific/Efate.json", "data/Pacific/Enderbury.json", "data/Pacific/Fakaofo.json", "data/Pacific/Fiji.json", "data/Pacific/Funafuti.json", "data/Pacific/Galapagos.json", "data/Pacific/Gambier.json", "data/Pacific/Guadalcanal.json", "data/Pacific/Guam.json", "data/Pacific/Honolulu.json", "data/Pacific/Johnston.json", "data/Pacific/Kiritimati.json", "data/Pacific/Kosrae.json", "data/Pacific/Kwajalein.json", "data/Pacific/Majuro.json", "data/Pacific/Marquesas.json", "data/Pacific/Midway.json", "data/Pacific/Nauru.json", "data/Pacific/Niue.json", "data/Pacific/Norfolk.json", "data/Pacific/Noumea.json", "data/Pacific/Pago_Pago.json", "data/Pacific/Palau.json", "data/Pacific/Pitcairn.json", "data/Pacific/Pohnpei.json", "data/Pacific/Ponape.json", "data/Pacific/Port_Moresby.json", "data/Pacific/Rarotonga.json", "data/Pacific/Saipan.json", "data/Pacific/Tahiti.json", "data/Pacific/Tarawa.json", "data/Pacific/Tongatapu.json", "data/Pacific/Truk.json", "data/Pacific/Wake.json", "data/Pacific/Wallis.json", "data/WET.json", "lib/timezone.rb", "lib/timezone/active_support.rb", "lib/timezone/configure.rb", "lib/timezone/error.rb", "lib/timezone/parser.rb", "lib/timezone/parser/data.rb", "lib/timezone/parser/link.rb", "lib/timezone/parser/rule.rb", "lib/timezone/parser/rule/entry.rb", "lib/timezone/parser/rule/on.rb", "lib/timezone/parser/rule/on_rules.rb", "lib/timezone/parser/zone.rb", "lib/timezone/parser/zone/data_generator.rb", "lib/timezone/parser/zone/entry.rb", "lib/timezone/parser/zone/until.rb", "lib/timezone/version.rb", "lib/timezone/zone.rb", "test/data/Helsinki_rules_without_timestamps.json", "test/data/asia", "test/timezone/parser/rule/on_rules_test.rb", "test/timezone/parser/rule_test.rb", "test/timezone/parser/zone/data_generator_test.rb", "test/timezone/parser/zone/until_test.rb", "test/timezone/parser/zone_test.rb", "test/timezone/parser_test.rb", "test/timezone_test.rb", "timezone.gemspec"]
  s.homepage = %q{http://github.com/panthomakos/timezone}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{timezone}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{timezone-0.3.1}
  s.test_files = ["test/data/Helsinki_rules_without_timestamps.json", "test/data/asia", "test/timezone/parser/rule/on_rules_test.rb", "test/timezone/parser/rule_test.rb", "test/timezone/parser/zone/data_generator_test.rb", "test/timezone/parser/zone/until_test.rb", "test/timezone/parser/zone_test.rb", "test/timezone/parser_test.rb", "test/timezone_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<minitest>, ["~> 4.0"])
      s.add_development_dependency(%q<timecop>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<minitest>, ["~> 4.0"])
      s.add_dependency(%q<timecop>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<minitest>, ["~> 4.0"])
    s.add_dependency(%q<timecop>, [">= 0"])
  end
end
