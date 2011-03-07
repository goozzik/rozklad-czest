#!/usr/bin/env ruby
# coding: utf-8

require 'rubygems'
require './config/environment'
require 'nokogiri'
require 'open-uri'
require 'iconv'

DEBUG = true
STATIONS_LOCATION = {
  '1 MAJA - UCZELNIA' => {:lat => 50.799344, :lng => 19.115632},
  'ALEJA BOHATERÓW MONTE CASSINO' => {:lat => 50.795709, :lng => 19.1085723},
  'ALEJA JANA PAWŁA II' => {:lat => 50.817649, :lng => 19.118099},
  'ANIOŁOWSKA' => {:lat => 50.827192, :lng => 19.136639},
  'ARCHIWUM PAŃSTWOWE' => {:lat => 50.795085, :lng => 19.134665},
  'ARTYLERYJSKA' => {:lat => 50.78597, :lng => 19.086084},
  'BACEWICZ' => {:lat => 50.843888, :lng => 19.126854},
  'BACZYŃSKIEGO' => {:lat => 50.837817, :lng => 19.124622},
  'BARGŁY' => {:lat => 50.7082, :lng => 19.121704},
  'BARGŁY - OSP' => {:lat => 50.709504, :lng => 19.116898},
  'BARGŁY - SZYMCZYKI' => {:lat => 50.708634, :lng => 19.112778},
  'BATALIONÓW CHŁOPSKICH' => {:lat => 50.708634, :lng => 19.112778},
  'BATALIONÓW CHŁOPSKICH I' => {:lat => 50.837926, :lng => 19.188652},
  'BERGER' => {:lat => 50.801216, :lng => 19.159641},
  'BIAŁOSTOCKA' => {:lat => 50.82703, :lng => 19.052181},
  'BIENIA' => {:lat => 50.772266, :lng => 19.1505},
  'BISKUPICE' => {:lat => 50.705645, :lng => 19.28641},
  'BISKUPICE I' => {:lat => 50.713852, :lng => 19.261093},
  'BISKUPICE II' => {:lat => 50.711569, :lng => 19.267015},
  'BISKUPICE III' => {:lat => 50.708526, :lng => 19.276028},
  'BŁESZNO' => {:lat => 50.768942, :lng => 19.151058},
  'BOHATERÓW KATYNIA' => {:lat => 50.770597, :lng => 19.150887},
  'BÓR - WYPALANKI' => {:lat => 50.773488, :lng => 19.118958},
  'BRONIEWSKIEGO' => {:lat => 50.827843, :lng => 19.110889},
  'BRZEZINY' => {:lat => 50.751282, :lng => 19.093723},
  'BRZOZOWA' => {:lat => 50.779892, :lng => 19.143505},
  'BUGAJSKA' => {:lat => 50.766974, :lng => 19.165821},
  'BURSZTYNOWA' => {:lat => 50.805338, :lng => 19.2138},
  'BURSZTYNOWA I' => {:lat => 50.806748, :lng => 19.210367},
  'BUSOLOWA I' => {:lat => 50.78304, :lng => 19.040594},
  'BUSOLOWA II' => {:lat => 50.778155, :lng => 19.04068},
  'C. H. JAGIELLOŃCZYCY' => {:lat => 50.783745, :lng => 19.143248},
  'CENTRUM HANDLOWE M1' => {:lat => 50.837438, :lng => 19.114301},
  'CHŁODNA' => {:lat => 50.800131, :lng => 19.158311},
  'CHŁOPSKA' => {:lat => 50.764585, :lng => 19.041924},
  'CMENTARNA' => {:lat => 50.823668, :lng => 19.133677},
  'CMENTARZ KOMUNALNY' => {:lat => 50.830933, :lng => 19.0456583},
  'CMENTARZ MIRÓW' => {:lat => 50.821174, :lng => 19.216375},
  'CMENTARZ RAKÓW' => {:lat => 50.776201, :lng => 19.148698},
  'CMENTARZ ŚW. ROCHA' => {:lat => 50.819222, :lng => 19.086996},
  'CMENTARZ ZACISZE' => {:lat => 50.794041, :lng => 19.074948},
  'DĄBIE' => {:lat => 50.791613, :lng => 19.160414},
  'DĄBROWSKIEGO - SĄDY' => {:lat => 50.817134, :lng => 19.1118763},
  'DICKENSA' => {:lat => 50.833698, :lng => 19.150929},
  'DOBRZYŃSKA' => {:lat => 50.813094, :lng => 19.05673},
  'DOJAZDOWA' => {:lat => 50.787164, :lng => 19.117243},
  'DOMY STUDENCKIE' => {:lat => 50.824156, :lng => 19.110546},
  'DRZEWNA' => {:lat => 50.792345, :lng => 19.019008},
  'DWORZEC GŁÓWNY PKP' => {:lat => 50.808714, :lng => 19.118325},
  'DWORZEC PKS' => {:lat => 50.806267, :lng => 19.118993},
  'DYBOWSKIEGO' => {:lat => 50.852613, :lng => 19.1449643},
  'DŹBÓW' => {:lat => 50.760744, :lng => 19.0618593},
  'ENERGETYKÓW' => {:lat => 50.794163, :lng => 19.038792},
  'ESTAKADA ' => {:lat => 50.783962, :lng => 19.142025},
  'FABRYCZNA' => {:lat => 50.757527, :lng => 19.15801},
  'FARADAYA' => {:lat => 50.807128, :lng => 19.143763},
  'FIELDORFA-NILA ' => {:lat => 50.840284, :lng => 19.129772},
  'FIELDORFA-NILA - CMENTARZ-KULE' => {:lat => 50.830323, :lng => 19.136188},
  'FILTROWA' => {:lat => 50.816673, :lng => 19.180541},
  'GALERIA JURAJSKA' => {:lat => 50.807026, :lng => 19.12783},
  'GAZOWNIA' => {:lat => 50.810653, :lng => 19.171743},
  'GILOWA' => {:lat => 50.792698, :lng => 19.160542},
  'GŁĘBOCKIEGO' => {:lat => 50.858221, :lng => 19.137862},
  'GMINNA' => {:lat => 50.837546, :lng => 19.056559},
  'GNASZYN' => {:lat => 50.796821, :lng => 19.051666},
  'GNASZYN - DWORZEC PKP' => {:lat => 50.791952, :lng => 19.028814},
  'GOMBROWICZA' => {:lat => 50.831312, :lng => 19.115889},
  'GRABÓWKA' => {:lat => 50.837113, :lng => 19.059863},
  'GRAFIKÓW' => {:lat => 50.789524, :lng => 19.038877},
  'GRONOWA' => {:lat => 50.766865, :lng => 19.095054},
  'GUARDIAN' => {:lat => 50.784478, :lng => 19.187365},
  'HALA POLONIA' => {:lat => 50.825593, :lng => 19.116898},
  'HALLERA' => {:lat => 50.807481, :lng => 19.167323},
  'HETMAŃSKA' => {:lat => 50.781981, :lng => 19.098873},
  'HOENE - WROŃSKIEGO' => {:lat => 50.799066, :lng => 19.111034},
  'HUBERMANA' => {:lat => 50.836904, :lng => 19.15525},
  'HUCULSKA' => {:lat => 50.804006, :lng => 19.081071},
  "HUTA STARA \"A\"" => {:lat => 50.725916, :lng => 19.127582},
  "HUTA STARA \"A\" - PSZENNA" => {:lat => 50.724769, :lng => 19.135068},
  "HUTA STARA \"B\"" => {:lat => 50.737557, :lng => 19.132256},
  "HUTA STARA \"B\" OSIEDLE" => {:lat => 50.739429, :lng => 19.133259},
  'HUTNIKÓW' => {:lat => 50.793492, :lng => 19.157624},
  'I ALEJA NAJŚWIĘTSZEJ MARYI PANNY' => {:lat => 50.811945, :lng => 19.124824},
  'I URZĄD SKARBOWY' => {:lat => 50.828031, :lng => 19.128874},
  'II ALEJA NAJŚWIĘTSZEJ MARYI PANNY' => {:lat => 50.811772, :lng => 19.118571},
  'II URZĄD SKARBOWY' => {:lat => 50.805074, :lng => 19.1381783},
  'III ALEJA NAJŚWIĘTSZEJ MARYI PANNY' => {:lat => 50.81216, :lng => 19.104302},
  'IKARA I' => {:lat => 50.837621, :lng => 19.060008},
  'IKARA II' => {:lat => 50.839098, :lng => 19.060426},
  'IKARA III' => {:lat => 50.845134, :lng => 19.062266},
  'IWASZKIEWICZA' => {:lat => 50.837092, :lng => 19.120857},
  'JAGIELLOŃSKA' => {:lat => 50.788873, :lng => 19.109302},
  'JASNA GÓRA' => {:lat => 50.810514, :lng => 19.096888},
  'JASNOGÓRSKA' => {:lat => 50.815426, :lng => 19.1184},
  'JESIENNA' => {:lat => 50.771106, :lng => 19.139978},
  'JESIENNA - SZKOŁA' => {:lat => 50.770026, :lng => 19.141515},
  'JEŻYNOWA' => {:lat => 50.788642, :lng => 19.03221},
  'JURAJSKA' => {:lat => 50.819054, :lng => 19.143714},
  'KANAŁ KOHNA' => {:lat => 50.802829, :lng => 19.131038},
  'KARŁOWICZA' => {:lat => 50.842181, :lng => 19.159899},
  'KARPACKA' => {:lat => 50.757385, :lng => 19.05555},
  'KASZTANOWA' => {:lat => 50.78247, :lng => 19.13475},
  'KASZUBSKA' => {:lat => 50.826704, :lng => 19.069605},
  'KAWODRZA DOLNA' => {:lat => 50.798015, :lng => 19.061537},
  'KAWODRZA GÓRNA' => {:lat => 50.783989, :lng => 19.044521},
  'KAWODRZAŃSKA' => {:lat => 50.786051, :lng => 19.079647},
  'KIEDRZYN' => {:lat => 50.856189, :lng => 19.108958},
  'KIEDRZYŃSKA' => {:lat => 50.826718, :lng => 19.122906},
  'KMICICA' => {:lat => 50.773623, :lng => 19.093251},
  'KOKSOWNIA' => {:lat => 50.80683, :lng => 19.176228},
  'KOLEJOWA' => {:lat => 50.760948, :lng => 19.160832},
  'KOLONIA BOREK' => {:lat => 50.692298, :lng => 19.173717},
  'KOLONIA BRZEZINY' => {:lat => 50.733793, :lng => 19.086857},
  'KOLONIA POCZESNA' => {:lat => 50.705047, :lng => 19.1399},
  'KOŁAKOWSKIEGO' => {:lat => 50.833061, :lng => 19.110053},
  'KOMENDA MIEJSKA POLICJI' => {:lat => 50.81711, :lng => 19.103894},
  'KOMORNICKA' => {:lat => 50.819981, :lng => 19.171486},
  'KONIECPOLSKA' => {:lat => 50.81933, :lng => 19.054413},
  'KONWALIOWA I' => {:lat => 50.785699, :lng => 19.069219},
  'KONWALIOWA II' => {:lat => 50.785183, :lng => 19.063082},
  'KONWALIOWA III' => {:lat => 50.784586, :lng => 19.053597},
  'KOPALNIANA I' => {:lat => 50.768792, :lng => 19.055443},
  'KOPALNIANA II' => {:lat => 50.762332, :lng => 19.053726},
  'KOPERNIKA' => {:lat => 50.807914, :lng => 19.112145},
  'KORCZAKA' => {:lat => 50.805263, :lng => 19.112295},
  'KORDECKIEGO' => {:lat => 50.808945, :lng => 19.08263},
  'KORFANTEGO' => {:lat => 50.785739, :lng => 19.185047},
  'KORFANTEGO I' => {:lat => 50.783419, :lng => 19.189811},
  'KORKOWA' => {:lat => 50.763662, :lng => 19.109559},
  'KORKOWA I' => {:lat => 50.761172, :lng => 19.107563},
  'KORKOWA II' => {:lat => 50.761728, :lng => 19.107971},
  'KORWINÓW' => {:lat => 50.734011, :lng => 19.174147},
  'KOSMOWSKIEJ' => {:lat => 50.84447, :lng => 19.138098},
  'KOŚCIELNA' => {:lat => 50.795438, :lng => 19.096727},
  'KRAKOWSKA' => {:lat => 50.800971, :lng => 19.130073},
  'KRĘCIWILK' => {:lat => 50.76335, :lng => 19.182944},
  'KUCELIN - HUTA' => {:lat => 50.790596, :lng => 19.176368},
  'KUCELIN - SZPITAL' => {:lat => 50.790582, :lng => 19.173417},
  'KUKUCZKI' => {:lat => 50.83695, :lng => 19.139707},
  'KURPIŃSKIEGO' => {:lat => 50.830703, :lng => 19.119709},
  'KUSIĘTA I' => {:lat => 50.771154, :lng => 19.233885},
  'KUSIĘTA II' => {:lat => 50.772022, :lng => 19.240837},
  'KUSIĘTA III' => {:lat => 50.774085, :lng => 19.252338},
  'KUSIĘTA IV' => {:lat => 50.775333, :lng => 19.257059},
  'KUSIĘTA V' => {:lat => 50.776419, :lng => 19.27371},
  'KUSIĘTA VI' => {:lat => 50.775387, :lng => 19.274139},
  'KUSIĘTA VII' => {:lat => 50.769471, :lng => 19.274912},
  'KUSOCIŃSKIEGO' => {:lat => 50.766295, :lng => 19.111898},
  'LAKOWA' => {:lat => 50.771316, :lng => 19.046474},
  'LEDNICKA' => {:lat => 50.830377, :lng => 19.054595},
  'LEGIONÓW' => {:lat => 50.798151, :lng => 19.196548},
  'LEŚNA' => {:lat => 50.761545, :lng => 19.022784},
  'LISIA' => {:lat => 50.757894, :lng => 19.093852},
  'LISZKA DOLNA ' => {:lat => 50.771561, :lng => 19.03995},
  'LOTOSU' => {:lat => 50.753631, :lng => 19.050937},
  'LUDOWA' => {:lat => 50.850445, :lng => 19.108872},
  'LWOWSKA' => {:lat => 50.80662, :lng => 19.058522},
  'ŁANOWA' => {:lat => 50.799249, :lng => 19.16374},
  'ŁĘCZYCKA' => {:lat => 50.820577, :lng => 19.06482},
  'ŁOJKI' => {:lat => 50.78852, :lng => 19.011583},
  'ŁÓDZKA' => {:lat => 50.823831, :lng => 19.100461},
  'MAKRO' => {:lat => 50.784342, :lng => 19.127305},
  'MAKUSZYŃSKIEGO' => {:lat => 50.848223, :lng => 19.149299},
  'MALOWNICZA' => {:lat => 50.734174, :lng => 19.07939},
  'MALOWNICZA I' => {:lat => 50.755667, :lng => 19.077287},
  'MALOWNICZA II' => {:lat => 50.7474, :lng => 19.076815},
  'MALOWNICZA III' => {:lat => 50.741289, :lng => 19.077845},
  'MAŁA' => {:lat => 50.802687, :lng => 19.129139},
  'MANGANOWA' => {:lat => 50.820537, :lng => 19.154298},
  'MARKET OBI' => {:lat => 50.823939, :lng => 19.104559},
  'MARUSARZA' => {:lat => 50.774967, :lng => 19.128796},
  'MARYNARSKA' => {:lat => 50.787937, :lng => 19.026775},
  'MATEJKI' => {:lat => 50.795601, :lng => 19.097757},
  'MAZURY' => {:lat => 50.720373, :lng => 19.086685},
  'MAZURY I' => {:lat => 50.722411, :lng => 19.087157},
  'MELIORANTÓW' => {:lat => 50.871682, :lng => 19.158161},
  'MICHAŁOWSKIEGO' => {:lat => 50.844877, :lng => 19.126339},
  'MICHAŁÓW' => {:lat => 50.709558, :lng => 19.099903},
  'MIELCZARSKIEGO' => {:lat => 50.807562, :lng => 19.127734},
  'MIRECKIEGO' => {:lat => 50.778318, :lng => 19.14784},
  'MIROWSKA' => {:lat => 50.818164, :lng => 19.195261},
  'MIRÓW' => {:lat => 50.818896, :lng => 19.2029},
  'MIRÓW - PEGAZ' => {:lat => 50.821391, :lng => 19.215002},
  'MŁYNEK' => {:lat => 50.724503, :lng => 19.083853},
  'MONIUSZKI' => {:lat => 50.790921, :lng => 19.087672},
  'MONTEX' => {:lat => 50.783474, :lng => 19.117799},
  'MORENOWA' => {:lat => 50.816294, :lng => 19.173803},
  'MSTOWSKA' => {:lat => 50.820876, :lng => 19.208565},
  'NARCYZOWA' => {:lat => 50.852396, :lng => 19.109302},
  'NIERADA' => {:lat => 50.708961, :lng => 19.050808},
  'NIERADA - KOŚCIÓŁ' => {:lat => 50.708961, :lng => 19.083681},
  'NIERADA - SKRZYŻOWANIE' => {:lat => 50.708689, :lng => 19.071665},
  'NIERADA - SZKOŁA' => {:lat => 50.710265, :lng => 19.090934},
  'NIERADA - TARGOWA I' => {:lat => 50.708906, :lng => 19.089775},
  'NIERADA - TARGOWA II' => {:lat => 50.708906, :lng => 19.057074},
  'NORWIDA' => {:lat => 50.838115, :lng => 19.163353},
  'NOWA WIEŚ - AUCHAN' => {:lat => 50.736021, :lng => 19.160714},
  'NOWA WIEŚ - SKRZYŻOWANIE' => {:lat => 50.733169, :lng => 19.162431},
  'NOWA WIEŚ I' => {:lat => 50.727491, :lng => 19.17007},
  'NOWA WIEŚ II' => {:lat => 50.724476, :lng => 19.167795},
  'NOWE BRZEZINY I' => {:lat => 50.745282, :lng => 19.093852},
  'NOWE BRZEZINY II' => {:lat => 50.744005, :lng => 19.093165},
  'NOWOBIALSKA' => {:lat => 50.829334, :lng => 19.088037},
  'OBROŃCÓW POCZTY GDAŃSKIEJ' => {:lat => 50.83096, :lng => 19.105439},
  'OBROŃCÓW WESTERPLATTE' => {:lat => 50.834633, :lng => 19.115889},
  'OCZYSZCZALNIA WARTA' => {:lat => 50.822069, :lng => 19.162474},
  'ODRODZENIA' => {:lat => 50.828792, :lng => 19.072909},
  'ODRZYKOŃ' => {:lat => 50.760025, :lng => 19.223886},
  'ODRZYKOŃ - NARCYZOWA' => {:lat => 50.755627, :lng => 19.225044},
  'OKRZEI' => {:lat => 50.78053, :lng => 19.145908},
  'OKULICKIEGO' => {:lat => 50.82478, :lng => 19.093423},
  'OLEŃKI' => {:lat => 50.80984, :lng => 19.092758},
  'OLSZTYN - MSTOWSKA' => {:lat => 50.756848, :lng => 19.268346},
  'OLSZTYN - NAPOLEONA' => {:lat => 50.747508, :lng => 19.267831},
  'OLSZTYN - RYNEK' => {:lat => 50.750441, :lng => 19.268432},
  'OLSZTYN - ŚW. PUSZCZY' => {:lat => 50.743734, :lng => 19.266758},
  'OLSZTYN - ŻWIRKI I WIGURY' => {:lat => 50.7534, :lng => 19.258089},
  'ORLIK-RUCKEMANNA' => {:lat => 50.806287, :lng => 19.144707},
  'OS. POD WILCZĄ GÓRĄ' => {:lat => 50.762359, :lng => 19.230709},
  'OSTATNI GROSZ' => {:lat => 50.793322, :lng => 19.127283},
  'PARKITKA - OSIEDLE' => {:lat => 50.824102, :lng => 19.093573},
  'PARKITKA - SZPITAL' => {:lat => 50.82871, :lng => 19.088616},
  'PIASTOWSKA' => {:lat => 50.795845, :lng => 19.103336},
  'PILECKIEGO - RONDO' => {:lat => 50.849226, :lng => 19.126811},
  'PIŁSUDSKIEGO' => {:lat => 50.810653, :lng => 19.122562},
  'PLAC BIEGAŃSKIEGO' => {:lat => 50.811874, :lng => 19.113078},
  'PLAC DASZYŃSKIEGO' => {:lat => 50.811623, :lng => 19.127047},
  'PLAC ORLĄT LWOWSKICH' => {:lat => 50.786377, :lng => 19.148333},
  'PLAC PAMIĘCI NARODOWEJ' => {:lat => 50.806004, :lng => 19.113816},
  'POCZESNA - BOCIANIA GÓRKA' => {:lat => 50.71445, :lng => 19.156208},
  'POCZESNA - BOREK' => {:lat => 50.704068, :lng => 19.152346},
  'POCZESNA - GÓRNICZA' => {:lat => 50.704721, :lng => 19.162817},
  'POCZESNA - HANDLOWA' => {:lat => 50.715428, :lng => 19.153633},
  'POCZESNA - KATOWICKA' => {:lat => 50.715374, :lng => 19.150372},
  'POCZESNA - KOŚCIÓŁ' => {:lat => 50.718879, :lng => 19.162774},
  'POCZESNA - ŁĄKOWA I' => {:lat => 50.715292, :lng => 19.130845},
  'POCZESNA - ŁĄKOWA II' => {:lat => 50.715618, :lng => 19.129729},
  'POCZESNA - OSP' => {:lat => 50.714015, :lng => 19.155178},
  'POCZESNA - POŁUDNIOWA' => {:lat => 50.714396, :lng => 19.132991},
  'POCZESNA - POŁUDNIOWA I' => {:lat => 50.714613, :lng => 19.142776},
  'POCZESNA - PROSTA' => {:lat => 50.708553, :lng => 19.154363},
  'POCZESNA - STRAŻACKA' => {:lat => 50.715482, :lng => 19.15904},
  'POCZESNA - SZKOŁA' => {:lat => 50.713689, :lng => 19.154234},
  'POLITECHNIKA ' => {:lat => 50.821147, :lng => 19.117842},
  'POLONTEX' => {:lat => 50.793661, :lng => 19.14211},
  'POLSKIEGO CZERWONEGO KRZYŻA ' => {:lat => 50.83077, :lng => 19.115868},
  'POSELSKA' => {:lat => 50.771534, :lng => 19.097114},
  'POWSTAŃCÓW ŚLĄSKICH' => {:lat => 50.78673, :lng => 19.137454},
  'POWSTAŃCÓW WARSZAWY' => {:lat => 50.765047, :lng => 19.071965},
  'PROMENADA NIEMENA' => {:lat => 50.833671, :lng => 19.11664},
  'PRUSA' => {:lat => 50.784423, :lng => 19.153891},
  'PRZESTRZENNA' => {:lat => 50.800131, :lng => 19.071107},
  'PRZYJEMNA' => {:lat => 50.748024, :lng => 19.045916},
  'PUSTA' => {:lat => 50.789741, :lng => 19.132991},
  'PZU' => {:lat => 50.783745, :lng => 19.140415},
  'RAKOWSKA' => {:lat => 50.772809, :lng => 19.156401},
  'RAKÓW - DWORZEC PKP' => {:lat => 50.787394, :lng => 19.150908},
  'REJTANA' => {:lat => 50.78909, :lng => 19.155006},
  'REJTANA - SĄDY' => {:lat => 50.788941, :lng => 19.155972},
  'ROLNICZA - CMENTARZ KULE' => {:lat => 50.826189, :lng => 19.131918},
  'RONDO MICKIEWICZA ' => {:lat => 50.801226, :lng => 19.11804},
  'RONDO TRZECH KRZYŻY' => {:lat => 50.818205, :lng => 19.13003},
  'RÓWNOLEGŁA' => {:lat => 50.789714, :lng => 19.132819},
  'RUTKIEWICZ' => {:lat => 50.777775, :lng => 19.125781},
  'RYDZA-ŚMIGŁEGO' => {:lat => 50.779811, :lng => 19.122133},
  'RYNEK NARUTOWICZA' => {:lat => 50.812728, :lng => 19.13887},
  'RYNEK WIELUŃSKI' => {:lat => 50.816497, :lng => 19.096577},
  'RZĄSAWA' => {:lat => 50.871764, :lng => 19.169254},
  'RZĄSAWA - DWORZEC PKP' => {:lat => 50.884869, :lng => 19.176679},
  'RZĄSAWSKA - UCZELNIA' => {:lat => 50.843834, :lng => 19.160929},
  'RZECZNA' => {:lat => 50.766933, :lng => 19.07542},
  'SABINOWSKA' => {:lat => 50.789388, :lng => 19.101276},
  'SABINÓW' => {:lat => 50.77403, :lng => 19.094238},
  'SĄSIEDZKA' => {:lat => 50.839565, :lng => 19.182386},
  'SCHILLERA' => {:lat => 50.842601, :lng => 19.119623},
  'SKARPOWA' => {:lat => 50.817378, :lng => 19.19157},
  'SKORKI' => {:lat => 50.762916, :lng => 19.033556},
  'SKRAJNICA' => {:lat => 50.743231, :lng => 19.24103},
  'SKRZYNECKIEGO' => {:lat => 50.819357, :lng => 19.114108},
  'SKWER SOKOŁÓW' => {:lat => 50.805321, :lng => 19.105418},
  'SŁONIMSKIEGO' => {:lat => 50.820849, :lng => 19.104538},
  'SŁOWACKIEGO' => {:lat => 50.802619, :lng => 19.111179},
  'SŁOWIK I' => {:lat => 50.745472, :lng => 19.167194},
  'SŁOWIK II' => {:lat => 50.744766, :lng => 19.172516},
  'SOBUCZYNA' => {:lat => 50.733467, :lng => 19.083681},
  'SOBUCZYNA-SZAFIROWA' => {:lat => 50.737623, :lng => 19.087436},
  'SOKOLE GÓRY' => {:lat => 50.731131, :lng => 19.265041},
  'SPORTOWA' => {:lat => 50.775442, :lng => 19.13578},
  'STADION CKS BUDOWLANI' => {:lat => 50.819805, :lng => 19.112477},
  'STADION MIEJSKI' => {:lat => 50.80127, :lng => 19.150028},
  'STADION RAKÓW' => {:lat => 50.778128, :lng => 19.156895},
  'STARA GORZELNIA' => {:lat => 50.826162, :lng => 18.998623},
  'STARA GORZELNIA I' => {:lat => 50.825403, :lng => 19.004974},
  'STARY RAKÓW' => {:lat => 50.784451, :lng => 19.155865},
  'STARY RYNEK' => {:lat => 50.81224, :lng => 19.128098},
  'STARZYŃSKIEGO' => {:lat => 50.846381, :lng => 19.13018},
  'STRADOM' => {:lat => 50.798001, :lng => 19.112177},
  'STRADOM - DWORZEC PKP' => {:lat => 50.798056, :lng => 19.107456},
  'STROMA' => {:lat => 50.794, :lng => 19.132948},
  'SZKOŁA STRAŻY POŻARNEJ' => {:lat => 50.785644, :lng => 19.099903},
  'SZPITALNA' => {:lat => 50.796306, :lng => 19.164813},
  'ŚW. AUGUSTYNA' => {:lat => 50.804253, :lng => 19.102349},
  'ŚW. BARBARY' => {:lat => 50.804769, :lng => 19.095011},
  'ŚW. BARBARY - SZPITAL' => {:lat => 50.806667, :lng => 19.09544},
  'ŚW. BRATA ALBERTA' => {:lat => 50.860875, :lng => 19.133935},
  'ŚW. KAZIMIERZA' => {:lat => 50.808159, :lng => 19.103937},
  'ŚW. KINGI' => {:lat => 50.803331, :lng => 19.087672},
  'ŚW. KRZYSZTOFA' => {:lat => 50.822638, :lng => 19.088316},
  'ŚW. ROCHA - SZKOŁA' => {:lat => 50.826908, :lng => 19.075377},
  'TATRZAŃSKA' => {:lat => 50.817934, :lng => 19.044178},
  'TEATR IM. A. MICKIEWICZA' => {:lat => 50.815053, :lng => 19.114172},
  'TURYSTYCZNA' => {:lat => 50.808782, :lng => 19.205475},
  'TYSIĄCLECIE - SZPITAL' => {:lat => 50.82993, :lng => 19.110342},
  'UGODY' => {:lat => 50.857408, :lng => 19.167881},
  'URZĄD CELNY' => {:lat => 50.807236, :lng => 19.16419},
  'WALCOWNIA' => {:lat => 50.776174, :lng => 19.191999},
  'WAWRZYNOWICZA' => {:lat => 50.827219, :lng => 19.105096},
  'WĄSOSZ' => {:lat => 50.736034, :lng => 19.05055},
  'WĄSOSZ - SKRZYŻOWANIE' => {:lat => 50.735369, :lng => 19.045594},
  'WCZASOWA' => {:lat => 50.777151, :lng => 19.117413},
  'WEYSSENHOFF' => {:lat => 50.765834, :lng => 19.176207},
  'WICHROWA' => {:lat => 50.805826, :lng => 19.057975},
  'WIELKOBORSKA' => {:lat => 50.817866, :lng => 19.044113},
  'WITAMINOWA' => {:lat => 50.769376, :lng => 19.116898},
  'WITOSA' => {:lat => 50.841544, :lng => 19.138677},
  'WOLNA' => {:lat => 50.808809, :lng => 19.142132},
  'WRĘCZYCKA' => {:lat => 50.82215, :lng => 19.081278},
  'WRZOSOWA' => {:lat => 50.74854, :lng => 19.148998},
  'WRZOSOWA - DŁUGA' => {:lat => 50.746368, :lng => 19.1399},
  'WRZOSOWA - KŁADKA' => {:lat => 50.746517, :lng => 19.153569},
  'WRZOSOWA - OGRODOWA' => {:lat => 50.753007, :lng => 19.160457},
  'WRZOSOWA - SABINOWSKA I' => {:lat => 50.743747, :lng => 19.136467},
  'WRZOSOWA - SZKOŁA' => {:lat => 50.745499, :lng => 19.152238},
  'WRZOSOWIAK' => {:lat => 50.776473, :lng => 19.135866},
  'WSPÓLNA' => {:lat => 50.807752, :lng => 19.149063},
  'WYCZERPY - OSIEDLE' => {:lat => 50.833427, :lng => 19.164448},
  'WYCZERPY DOLNE' => {:lat => 50.831502, :lng => 19.147561},
  'WYCZERPY GÓRNE' => {:lat => 50.840365, :lng => 19.16904},
  'WYGODA' => {:lat => 50.735314, :lng => 19.025531},
  'WYPOCZYNKU' => {:lat => 50.852775, :lng => 19.166336},
  'WYSZYŃSKIEGO' => {:lat => 50.814151, :lng => 19.084454},
  'ZANA' => {:lat => 50.802899, :lng => 19.102373},
  'ZAWODZIE' => {:lat => 50.724347, :lng => 19.177784},
  'ZAWODZIE - CMENTARNA' => {:lat => 50.70964, :lng => 19.162495},
  'ZAWODZIE - CMENTARZ' => {:lat => 50.711529, :lng => 19.164019},
  'ZAWODZIE - DŁUGA I' => {:lat => 50.713322, :lng => 19.167516},
  'ZAWODZIE - DŁUGA II' => {:lat => 50.719531, :lng => 19.174576},
  'ZAWODZIE - SZPITAL' => {:lat => 50.811711, :lng => 19.132175},
  'ZBYSZKA' => {:lat => 50.771479, :lng => 19.085526},
  'ZDROWA' => {:lat => 50.762604, :lng => 19.093466},
  'ZEGAROWA' => {:lat => 50.75902, :lng => 19.081793},
  'ZIELNA' => {:lat => 50.857164, :lng => 19.168053},
  'ZIMOWA' => {:lat => 50.784396, :lng => 19.126854},
  'ZŁOTA' => {:lat => 50.806884, :lng => 19.154663},
  'ŻABINIEC' => {:lat => 50.857706, :lng => 19.066386},
  'ŻARECKA' => {:lat => 50.775143, :lng => 19.157238},
  'ŻEROMSKIEGO' => {:lat => 50.791803, :lng => 19.149685},
  'ŻONKILOWA' => {:lat => 50.853507, :lng => 19.129257},
  'ŻYZNA' => {:lat => 50.758749, :lng => 19.094024}
}

class InitialHtmlDataExtractor

  def self.import_stations
    file = File.join(Rails.root, "tmp", "map_rozkl", "rozklady", "przystan.htm")
    doc = Nokogiri::HTML(open(file))
    doc.xpath("//html/body/table/tr[*]/td/ul/li/a").each do |station|
      _station = station.content
      if _station == 'TEATR im. A. MICKIEWICZA'
        _station = 'TEATR IM. A. MICKIEWICZA' 
      end
      Station.create!(
        :name => _station,
        :lat => STATIONS_LOCATION[_station][:lat],
        :lng => STATIONS_LOCATION[_station][:lng]
      )
    end
  end

  def self.import_lines
    htmfiles = File.join("**", "rozklady", "**", "w.htm")
    files = Dir.glob(htmfiles)
    files.each do |file|
      puts "File: #{file}"
      doc = Nokogiri::HTML(open(file))
      number = doc.xpath("//html/body/table/tr/td/font/b").first.content.gsub("Linia ", "")
      puts "Number: #{number}"
      directions = doc.xpath("//html/body/table/tr[2]/td[*]")
      directions.each_with_index do |direction, n|
        _direction = direction.content.gsub("kierunek:", "").strip
        puts "Direction: #{_direction}"
        _stations = []
        stations = doc.xpath("//html/body/table/tr[3]/td[#{n+1}]/ul/li[*]")
        stations.each do |station|
          _station = station.content
          if _station == 'TEATR im. A. MICKIEWICZA'
            _station = 'TEATR IM. A. MICKIEWICZA' 
          end
          puts "Station: #{_station}"
          _stations << Station.find_by_name(_station).id
        end
        Line.create!(
          :number => number,
          :direction => _direction,
          :stations => _stations
        )
      end
    end
  end

  def self.import_schedules
    htmfiles = File.join("**", "rozklady", "**", "00**t***.htm")
    files = Dir.glob(htmfiles)
    files.each do |file|
      pd "#{file}"
      doc = Nokogiri::HTML(open(file))

      number = doc.xpath("//html/body/table/tr/td/font/b").first.content.strip
      direction = doc.xpath("//html/body/table/tr/td/b").first.content.strip
      station = doc.xpath("//html/body/table/tr/td/a/b").first.content
      if station == 'TEATR im. A. MICKIEWICZA'
        station = 'TEATR IM. A. MICKIEWICZA' 
      end

      pd "Number: #{number}"
      pd "Direction: #{direction}"

      # TODO
      # Remove rescue next
      # Problem : 14 has 6 directions :/
      line_id = Line.find_by_number_and_direction(number, direction).id rescue next
      station_id = Station.find_by_name(station).id

      # Robocze /html/body/table/tbody/tr[4]/td/b
      works = doc.xpath("//html/body/table/tr/td[1]/b").each_with_index do |work, n|
        next if n == 0
        minutes = doc.xpath("//html/body/table/tr[#{3+n}]/td[2]").first.content.gsub('-', '').split(" ")
        # TODO legend letters
        
        pd "Hour: #{work.content}"
        pd "Minutes: #{minutes.inspect}"

        minutes.each do |minute|
          pd "Arrive at: #{work.content}:#{minute.to_i}:00"
          Schedule.create!(
            :line_id => line_id,
            :station_id => station_id,
            :arrival_at => Time.new(2000, 1, 1, work.content.to_i, minute.to_i, 0),
            :work => true
          )
        end
      end

      # Wakacyjne /html/body/table/tbody/tr[4]/td[3]/b
      holidays = doc.xpath("//html/body/table/tr/td[3]/b").each_with_index do |holiday, n|
        next if n == 0
        minutes = doc.xpath("//html/body/table/tr[#{3+n}]/td[4]").first.content.gsub('-', '').split(" ")

        pd "Hour: #{holiday.content}"
        pd "Minutes: #{minutes.inspect}"

        minutes.each do |minute|
          pd "Arrive at: #{holiday.content}:#{minute.to_i}:00"
          Schedule.create!(
            :line_id => line_id,
            :station_id => station_id,
            :arrival_at => Time.new(2000, 1, 1, holiday.content.to_i, minute.to_i, 0),
            :holiday => true
          )
        end
      end

      # Soboty    /html/body/table/tbody/tr[4]/td[5]/b
      saturdays = doc.xpath("//html/body/table/tr/td[5]/b").each_with_index do |saturday, n|
        next if n == 0
        minutes = doc.xpath("//html/body/table/tr[#{3+n}]/td[6]").first.content.gsub('-', '').split(" ")

        pd "Hour: #{saturday.content}"
        pd "Minutes: #{minutes.inspect}"

        minutes.each do |minute|
          pd "Arrive at: #{saturday.content}:#{minute.to_i}:00"
          Schedule.create!(
            :line_id => line_id,
            :station_id => station_id,
            :arrival_at => Time.new(2000, 1, 1, saturday.content.to_i, minute.to_i, 0),
            :saturday => true
          )
        end
      end

      # Niedziele /html/body/table/tbody/tr[4]/td[7]/b
      sundays = doc.xpath("//html/body/table/tr/td[7]/b").each_with_index do |sunday, n|
        next if n == 0
        minutes = doc.xpath("//html/body/table/tr[#{3+n}]/td[8]").first.content.gsub('-', '').split(" ")

        pd "Hour: #{sunday.content}"
        pd "Minutes: #{minutes.inspect}"

        minutes.each do |minute|
          pd "Arrive at: #{sunday.content}:#{minute.to_i}:00"
          Schedule.create!(
            :line_id => line_id,
            :station_id => station_id,
            :arrival_at => Time.new(2000, 1, 1, sunday.content.to_i, minute.to_i, 0),
            :sunday => true
          )
        end
      end
    end

    #raise "OK"

    #schedule = Schedule.create!(
                #:line_id = line_id,
                #:station_id = station_id,
                #:time => Time.parse("#{record[:hours]}:#{minute.to_i}:00"),
                #:work => true,
                #:saturday => false,
                #:sunday => false,
                #:summer => false
              #)
  end

  private

    def self.pd(msg)
      puts "DEBUG: #{msg}" if DEBUG == true
    end

end



case ARGV.first
  when 'extract'
    InitialHtmlDataExtractor.import_stations
    InitialHtmlDataExtractor.import_lines
    InitialHtmlDataExtractor.import_schedules
  
  when 'test'
    station_from = Station.find_by_name("RYNEK WIELUŃSKI")
    puts "From: #{station_from.inspect}"

    station_to = Station.find_by_name("II ALEJA NAJŚWIĘTSZEJ MARYI PANNY")
    puts "To: #{station_to.inspect}"

    puts

    lines = Line.find_all_by_stations([station_from.id, station_to.id])
    puts "Lines #{lines.inspect}"

    puts

    schedules = Schedule.all(
      :conditions => ["line_id IN (?) AND station_id = ? AND arrival_at > ?", lines.collect(&:id), station_from.id, Time.now],
      :order => "arrival_at",
      :limit => 5
    )

    puts "Schedule:"
    schedules.each do |schedule|
      puts "#{schedule.line.number} #{schedule.line.direction} at #{schedule.arrival_at.strftime("%H:%M")}"
    end

  else
    puts "Usage: initial_html_data_extractor.rb {extract|test}"
end