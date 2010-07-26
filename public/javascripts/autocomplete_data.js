$(function(){
	var availableStations = ["1 MAJA - UCZELNIA", "ALEJA BOHATERÓW MONTE CASSINO", "ALEJA JANA PAWŁA II", "ANIOŁOWSKA",
	 															"ARCHIWUM PAŃSTWOWE", "ARTYLERYJSKA", "BACEWICZ", "BACZYŃSKIEGO", "BARGŁY", "BARGŁY - OSP",
	 															"BARGŁY - SZYMCZYKI", "BATALIONÓW CHŁOPSKICH", "BATALIONÓW CHŁOPSKICH I", "BERGER", "BIAŁOSTOCKA",
	 															"BIENIA", "BISKUPICE", "BISKUPICE I", "BISKUPICE II", "BISKUPICE III", "BŁESZNO", "BOHATERÓW KATYNIA",
	 															"BÓR - WYPALANKI", "BRONIEWSKIEGO", "BRZEZINY", "BRZOZOWA", "BUGAJSKA", "BUKOWA", "BURSZTYNOWA", "BURSZTYNOWA I",
	 															"BUSOLOWA I", "BUSOLOWA II", "C. H. JAGIELLOŃCZYCY", "CENTRUM HANDLOWE M1", "CHŁODNA", "CHŁOPSKA", "CMENTARNA",
	 															"CMENTARZ KOMUNALNY", "CMENTARZ MIRÓW", "CMENTARZ RAKÓW", "CMENTARZ ŚW. ROCHA", "CMENTARZ ZACISZE", "DĄBIE",
	 															"DĄBROWSKIEGO - SĄDY", "DICKENSA", "DOBRZYŃSKA", "DOJAZDOWA", "DOMY STUDENCKIE", "DRZEWNA", "DWORZEC GŁÓWNY PKP",
	 															"DWORZEC PKS", "DYBOWSKIEGO", "DŹBÓW", "ENERGETYKÓW", "ESTAKADA ", "FABRYCZNA", "FARADAYA", "FIELDORFA-NILA ",
	 															"FIELDORFA-NILA - CMENTARZ-KULE", "FILTROWA", "GALERIA JURAJSKA", "GAZOWNIA", "GILOWA", "GŁĘBOCKIEGO", "GMINNA",
	 															"GNASZYN", "GNASZYN - DWORZEC PKP", "GOMBROWICZA", "GRABÓWKA", "GRAFIKÓW", "GRONOWA", "GUARDIAN", "HALA POLONIA",
	 															"HALLERA", "HETMAŃSKA", "HOENE - WROŃSKIEGO", "HUBERMANA", "HUCULSKA", "HUTA STARA \"A\"", "HUTA STARA \"A\" - PSZENNA",
	 															"HUTA STARA \"B\"", "HUTA STARA \"B\" OSIEDLE", "HUTNIKÓW", "I ALEJA NAJŚWIĘTSZEJ MARYI PANNY", "I URZĄD SKARBOWY",
	 															"II ALEJA NAJŚWIĘTSZEJ MARYI PANNY", "II URZĄD SKARBOWY", "III ALEJA NAJŚWIĘTSZEJ MARYI PANNY", "IKARA I", "IKARA II",
	 															"IKARA III", "IWASZKIEWICZA", "JAGIELLOŃSKA", "JASNA GÓRA", "JASNOGÓRSKA", "JESIENNA", "JESIENNA - SZKOŁA", "JEŻYNOWA",
	 															"JURAJSKA", "KANAŁ KOHNA", "KARŁOWICZA", "KARPACKA", "KASZTANOWA", "KASZUBSKA", "KAWODRZA DOLNA", "KAWODRZA GÓRNA",
	 															"KAWODRZAŃSKA", "KIEDRZYN", "KIEDRZYŃSKA", "KMICICA", "KOKSOWNIA", "KOLEJOWA", "KOLONIA BOREK", "KOLONIA BRZEZINY",
	 															"KOLONIA POCZESNA", "KOŁAKOWSKIEGO", "KOMENDA MIEJSKA POLICJI", "KOMORNICKA", "KONIECPOLSKA", "KONWALIOWA I",
	 															"KONWALIOWA II", "KONWALIOWA III", "KOPALNIANA I", "KOPALNIANA II", "KOPERNIKA", "KORCZAKA", "KORDECKIEGO",
	 															"KORFANTEGO", "KORFANTEGO I", "KORKOWA", "KORKOWA I", "KORKOWA II", "KORWINÓW", "KOSMOWSKIEJ", "KOŚCIELNA",
	 															"KRAKOWSKA", "KRĘCIWILK", "KUCELIN - HUTA", "KUCELIN - SZPITAL", "KUKUCZKI", "KURPIŃSKIEGO", "KUSIĘTA I",
	 															"KUSIĘTA II", "KUSIĘTA III", "KUSIĘTA IV", "KUSIĘTA V", "KUSIĘTA VI", "KUSIĘTA VII", "LAKOWA", "LEDNICKA",
	 															"LEGIONÓW", "LEŚNA", "LISIA", "LISZKA DOLNA ", "LOTOSU", "LUDOWA", "LWOWSKA", "ŁANOWA", "ŁĘCZYCKA", "ŁOJKI",
	 															"ŁÓDZKA", "MAKRO", "MAKUSZYŃSKIEGO", "MALOWNICZA", "MALOWNICZA I", "MALOWNICZA II", "MALOWNICZA III", "MAŁA",
	 															"MANGANOWA", "MARKET OBI", "MARUSARZA", "MARYNARSKA", "MATEJKI", "MAZURY", "MAZURY I", "MELIORANTÓW", "MICHAŁOWSKIEGO",
	 															"MICHAŁÓW", "MIELCZARSKIEGO", "MIRECKIEGO", "MIROWSKA", "MIRÓW", "MIRÓW - PEGAZ", "MŁYNEK", "MONIUSZKI", "MONTEX", "MORENOWA",
	 															"MSTOWSKA", "NARCYZOWA", "NIERADA", "NIERADA - KOŚCIÓŁ", "NIERADA - SKRZYŻOWANIE", "NIERADA - SZKOŁA", "NIERADA - TARGOWA I",
	 															"NIERADA - TARGOWA II", "NORWIDA", "NOWA WIEŚ - AUCHAN", "NOWA WIEŚ - SKRZYŻOWANIE", "NOWA WIEŚ I", "NOWA WIEŚ II", "NOWE BRZEZINY I",
	 															"NOWE BRZEZINY II", "NOWOBIALSKA", "OBROŃCÓW POCZTY GDAŃSKIEJ", "OBROŃCÓW WESTERPLATTE", "OCZYSZCZALNIA WARTA", "ODRODZENIA", "ODRZYKOŃ",
	 															"ODRZYKOŃ - NARCYZOWA", "OKRZEI", "OKULICKIEGO", "OLEŃKI", "OLSZTYN - MSTOWSKA", "OLSZTYN - NAPOLEONA", "OLSZTYN - RYNEK", "OLSZTYN - ŚW. PUSZCZY",
	 															"OLSZTYN - ŻWIRKI I WIGURY", "ORKANA - SZKOŁA", "ORLIK-RUCKEMANNA", "OS. POD WILCZĄ GÓRĄ", "OSTATNI GROSZ", "PARKITKA - OSIEDLE",
	 															"PARKITKA - SZPITAL", "PIASTOWSKA", "PILECKIEGO - RONDO", "PIŁSUDSKIEGO", "PLAC BIEGAŃSKIEGO", "PLAC DASZYŃSKIEGO", "PLAC ORLĄT LWOWSKICH",
	 															"PLAC PAMIĘCI NARODOWEJ", "POCZESNA - BOREK", "POCZESNA - GÓRNICZA", "POCZESNA - HANDLOWA", "POCZESNA - KATOWICKA", "POCZESNA - KOŚCIÓŁ",
	 															"POCZESNA - ŁĄKOWA I", "POCZESNA - ŁĄKOWA II", "POCZESNA - OSP", "POCZESNA - POŁUDNIOWA", "POCZESNA - POŁUDNIOWA I", "POCZESNA - PROSTA",
	 															"POCZESNA - STRAŻACKA", "POCZESNA - SZKOŁA", "POLITECHNIKA ", "POLONTEX", "POLSKIEGO CZERWONEGO KRZYŻA ", "POSELSKA", "POWSTAŃCÓW ŚLĄSKICH",
	 															"POWSTAŃCÓW WARSZAWY", "PROMENADA NIEMENA", "PRUSA", "PRZESTRZENNA", "PRZYJEMNA", "PUSTA", "PZU", "RAKOWSKA", "RAKÓW - DWORZEC PKP", "REJTANA",
	 															"REJTANA - SĄDY", "ROLNICZA - CMENTARZ KULE", "RONDO MICKIEWICZA ", "RONDO TRZECH KRZYŻY", "RÓWNOLEGŁA", "RUTKIEWICZ", "RYDZA-ŚMIGŁEGO",
	 															"RYNEK NARUTOWICZA", "RYNEK WIELUŃSKI", "RZĄSAWA", "RZĄSAWA - DWORZEC PKP", "RZĄSAWSKA - UCZELNIA", "RZECZNA", "SABINOWSKA", "SABINÓW", "SĄSIEDZKA",
	 															"SCHILLERA", "SKARPOWA", "SKORKI", "SKRAJNICA", "SKRZYNECKIEGO", "SKWER SOKOŁÓW", "SŁONIMSKIEGO", "SŁOWACKIEGO", "SŁOWIK I", "SŁOWIK II",
	 															"SOBUCZYNA", "SOKOLE GÓRY", "SPORTOWA", "STADION CKS BUDOWLANI", "STADION MIEJSKI", "STADION RAKÓW", "STARA GORZELNIA",
	 															"STARA GORZELNIA I", "STARY RAKÓW", "STARY RYNEK", "STARZYŃSKIEGO", "STRADOM", "STRADOM - DWORZEC PKP", "STROMA",
	 															"SZKOŁA STRAŻY POŻARNEJ", "SZPITALNA", "ŚW. AUGUSTYNA", "ŚW. BARBARY", "ŚW. BARBARY - SZPITAL", "ŚW. BRATA ALBERTA",
	 															"ŚW. KAZIMIERZA", "ŚW. KINGI", "ŚW. KRZYSZTOFA", "ŚW. ROCHA - SZKOŁA", "TATRZAŃSKA", "TURYSTYCZNA", "TYSIĄCLECIE - SZPITAL",
	 															"UGODY", "URZĄD CELNY", "WALCOWNIA", "WAWRZYNOWICZA", "WĄSOSZ", "WĄSOSZ - SKRZYŻOWANIE", "WCZASOWA", "WEYSSENHOFF", "WICHROWA",
	 															"WIELKOBORSKA", "WITOSA", "WOLNA", "WRĘCZYCKA", "WRZOSOWA", "WRZOSOWA - DŁUGA", "WRZOSOWA - KŁADKA", "WRZOSOWA - OGRODOWA",
	 															"WRZOSOWA - SABINOWSKA I", "WRZOSOWA - SZKOŁA", "WRZOSOWIAK", "WSPÓLNA", "WYCZERPY - OSIEDLE", "WYCZERPY DOLNE", "WYCZERPY GÓRNE",
	 															"WYGODA", "WYPOCZYNKU", "WYSZYŃSKIEGO", "ZANA", "ZAWODZIE", "ZAWODZIE - CMENTARNA", "ZAWODZIE - CMENTARZ", "ZAWODZIE - DŁUGA I",
	 															"ZAWODZIE - DŁUGA II", "ZAWODZIE - SZPITAL", "ZBYSZKA", "ZDROWA", "ZEGAROWA", "ZIELNA", "ZIMOWA", "ZŁOTA", "ŻABINIEC", "ŻARECKA",
	 															"ŻEROMSKIEGO", "ŻONKILOWA", "ŻYZNA", "TEATR IM. A. MICKIEWICZA"];
	$("#finder_from").autocomplete({
		source: availableStations,
		minLength: 2
	});
	$("#finder_to").autocomplete({
		source: availableStations,
		minLength: 2
	});
	$("#favourite_from").autocomplete({
		source: availableStations,
		minLength: 2
	});
	$("#favourite_to").autocomplete({
		source: availableStations,
		minLength: 2
	});
});