var availableStations = [{text: '1 MAJA - UCZELNIA', value: '1 MAJA - UCZELNIA'},
        {text: 'ALEJA BOHATERÓW MONTE CASSINO', value: 'ALEJA BOHATERÓW MONTE CASSINO'},
        {text: 'ALEJA JANA PAWŁA II', value: 'ALEJA JANA PAWŁA II'},
        {text: 'ANIOŁOWSKA', value: 'ANIOŁOWSKA'},
        {text: 'ARCHIWUM PAŃSTWOWE', value: 'ARCHIWUM PAŃSTWOWE'},
        {text: 'ARTYLERYJSKA', value: 'ARTYLERYJSKA'},
        {text: 'BACEWICZ', value: 'BACEWICZ'},
        {text: 'BACZYŃSKIEG', value: 'BACZYŃSKIEG'},
        {text: 'BARGŁY', value: 'BARGŁY'},
        {text: 'BARGŁY - OSP', value: 'BARGŁY - OSP'},
        {text: 'BARGŁY - SZYMCZYKI', value: 'BARGŁY - SZYMCZYKI'},
        {text: 'BATALIONÓW CHŁOPSKICH', value: 'BATALIONÓW CHŁOPSKICH'},
        {text: 'BATALIONÓW CHŁOPSKICH I', value: 'BATALIONÓW CHŁOPSKICH I'},
        {text: 'BERGER', value: 'BERGER'},
        {text: 'BIAŁOSTOCKA', value: 'BIAŁOSTOCKA'},
        {text: 'BIENIA', value: 'BIENIA'},
        {text: 'BISKUPICE I', value: 'BISKUPICE I'},
        {text: 'BISKUPICE II', value: 'BISKUPICE II'},
        {text: 'BISKUPICE III', value: 'BISKUPICE III'},
        {text: 'BŁESZNO', value: 'BŁESZNO'},
        {text: 'BOHATERÓW KATYNIA', value: 'BOHATERÓW KATYNIA'},
        {text: 'BÓR - WYPALANKI', value: 'BÓR - WYPALANKI'},
        {text: 'BRONIEWSKIEGO', value: 'BRONIEWSKIEGO'},
        {text: 'BRZEZINY', value: 'BRZEZINY'},
        {text: 'BRZOZOWA', value: 'BRZOZOWA'},
        {text: 'BUGAJSKA', value: 'BUGAJSKA'},
        {text: 'BUKOWA', value: 'BUKOWA'},
        {text: 'BURSZTYNOWA', value: 'BURSZTYNOWA'},
        {text: 'BURSZTYNOWA I', value: 'BURSZTYNOWA I'},
        {text: 'BUSOLOWA I', value: 'BUSOLOWA I'},
        {text: 'BUSOLOWA II', value: 'BUSOLOWA II'},
        {text: 'C. H. JAGIELLOŃCZYCY', value: 'C. H. JAGIELLOŃCZYCY'},
	{text: 'CENTRUM HANDLOWE M1', value: 'CENTRUM HANDLOWE M1'},
        {text: 'CHŁODNA', value: 'CHŁODNA'},
        {text: 'CHŁOPSKA', value: 'CHŁOPSKA'},
        {text: 'CMENTARNA', value: 'CMENTARNA'},
        {text: 'CMENTARZ KOMUNALNY', value: 'CMENTARZ KOMUNALNY'},
        {text: 'CMENTARZ MIRÓW', value: 'CMENTARZ MIRÓW'},
        {text: 'CMENTARZ RAKÓW', value: 'CMENTARZ RAKÓW'},
        {text: 'CMENTARZ ŚW. ROCHA', value: 'CMENTARZ ŚW. ROCHA'},
        {text: 'CMENTARZ ZACISZE', value: 'CMENTARZ ZACISZE'},
        {text: 'DĄBIE', value: 'DĄBIE'},
        {text: 'DĄBROWSKIEGO - SĄDY', value: 'DĄBROWSKIEGO - SĄDY'},
        {text: 'DICKENSA', value: 'DICKENSA'},
        {text: 'DOBRZYŃSKA', value: 'DOBRZYŃSKA'},
        {text: 'DOJAZDOWA', value: 'DOJAZDOWA'},
        {text: 'DOMY STUDENCKIE', value: 'DOMY STUDENCKIE'},
        {text: 'DRZEWNA', value: 'DRZEWNA'},
        {text: 'DWORZEC GŁÓWNY PKP', value: 'DWORZEC GŁÓWNY PKP'},
        {text: 'DWORZEC PKS', value: 'DWORZEC PKS'},
        {text: 'DYBOWSKIEGO', value: 'DYBOWSKIEGO'},
        {text: 'DŹBÓW', value: 'DŹBÓW'},
        {text: 'ENERGETYKÓW', value: 'ENERGETYKÓW'},
        {text: 'ESTAKADA', value: 'ESTAKADA'},
        {text: 'FABRYCZNA', value: 'FABRYCZNA'},
        {text: 'FARADAYA', value: 'FARADAYA'},
        {text: 'FIELDORFA-NILA', value: 'FIELDORFA-NILA'},
        {text: 'FIELDORFA-NILA - CMENTARZ-KULE', value: 'FIELDORFA-NILA - CMENTARZ-KULE'},
        {text: 'FILTROWA', value: 'FILTROWA'},
        {text: 'GALERIA JURAJSKA', value: 'GALERIA JURAJSKA'},
        {text: 'GAZOWNIA', value: 'GAZOWNIA'},
        {text: 'GŁĘBOCKIEGO', value: 'GŁĘBOCKIEGO'},
        {text: 'GNASZYN', value: 'GNASZYN'},
        {text: 'GNASZYN - DWORZEC PKP', value: 'GNASZYN - DWORZEC PKP'},
        {text: 'GOMBROWICZA', value: 'GOMBROWICZA'},
        {text: 'GRABÓWKA', value: 'GRABÓWKA'},
        {text: 'GRAFIKÓW', value: 'GRAFIKÓW'},
        {text: 'GRONOWA', value: 'GRONOWA'},
        {text: 'GUARDIAN', value: 'GUARDIAN'},
        {text: 'HALA POLONIA', value: 'HALA POLONIA'},
        {text: 'HALLERA', value: 'HALLERA'},
        {text: 'HETMAŃSKA', value: 'HETMAŃSKA'},
        {text: 'HOENE - WROŃSKIEGO', value: 'HOENE - WROŃSKIEGO'},
        {text: 'HUBERMANA', value: 'HUBERMANA'},
        {text: 'HUCULSKA', value: 'HUCULSKA'},
        {text: 'HUTA STARA \"A\"', value: 'HUTA STARA \"A\"'},
        {text: 'HUTA STARA \"A\" - PSZENNA', value: 'HUTA STARA \"A\" - PSZENNA'},
        {text: 'HUTA STARA \"B\"', value: 'HUTA STARA \"B\"'},
        {text: 'HUTA STARA \"B\" OSIEDLE', value: 'HUTA STARA \"B\" OSIEDLE'},
        {text: 'HUTNIKÓW', value: 'HUTNIKÓW'},
        {text: 'I ALEJA NAJŚWIĘTSZEJ MARYI PANNY', value: 'I ALEJA NAJŚWIĘTSZEJ MARYI PANNY'},
        {text: 'I URZĄD SKARBOWY', value: 'I URZĄD SKARBOWY'},
        {text: 'II ALEJA NAJŚWIĘTSZEJ MARYI PANNY', value: 'II ALEJA NAJŚWIĘTSZEJ MARYI PANNY'},
        {text: 'II URZĄD SKARBOWY', value: 'II URZĄD SKARBOWY'},
        {text: 'III ALEJA NAJŚWIĘTSZEJ MARYI PANNY', value: 'III ALEJA NAJŚWIĘTSZEJ MARYI PANNY'},
        {text: 'IKARA I', value: 'IKARA I'},
        {text: 'IKARA II', value: 'IKARA II'},
        {text: 'IKARA III', value: 'IKARA III'},
        {text: 'IWASZKIEWICZA', value: 'IWASZKIEWICZA'},
        {text: 'JAGIELLOŃSKA', value: 'JAGIELLOŃSKA'},
        {text: 'JASNA GÓRA', value: 'JASNA GÓRA'},
        {text: 'JASNOGÓRSKA', value: 'JASNOGÓRSKA'},
        {text: 'JESIENNA', value: 'JESIENNA'},
        {text: 'JESIENNA - SZKOŁA', value: 'JESIENNA - SZKOŁA'},
        {text: 'JEŻYNOWA', value: 'JEŻYNOWA'},
        {text: 'JURAJSKA', value: 'JURAJSKA'},
        {text: 'KANAŁ KOHNA', value: 'KANAŁ KOHNA'},
        {text: 'KARŁOWICZA', value: 'KARŁOWICZA'},
        {text: 'KARPACKA', value: 'KARPACKA'},
        {text: 'KASZTANOWA', value: 'KASZTANOWA'},
        {text: 'KASZUBSKA', value: 'KASZUBSKA'},
        {text: 'KAWODRZA DOLNA', value: 'KAWODRZA DOLNA'},
        {text: 'KAWODRZA GÓRNA', value: 'KAWODRZA GÓRNA'},
	{text: 'KAWODRZAŃSKA', value: 'KAWODRZAŃSKA'},
	{text: 'KIEDRZYN', value: 'KIEDRZYN'},
	{text: 'KIEDRZYŃSKA', value: 'KIEDRZYŃSKA'},
	{text: 'KMICICA', value: 'KMICICA'},
	{text: 'KOLEJOWA', value: 'KOLEJOWA'},
	{text: 'KOLONIA BOREK', value: 'KOLONIA BOREK'},
	{text: 'KOLONIA BRZEZINY', value: 'KOLONIA BRZEZINY'},
	{text: 'KOŁAKOWSKIEGO', value: 'KOŁAKOWSKIEGO'},
	{text: 'KOMENDA MIEJSKA POLICJI', value: 'KOMENDA MIEJSKA POLICJI'},
	{text: 'KOMORNICKA', value: 'KOMORNICKA'},
	{text: 'KONIECPOLSKA', value: 'KONIECPOLSKA'},
	{text: 'KONWALIOWA I', value: 'KONWALIOWA I'},
	{text: 'KONWALIOWA II', value: 'KONWALIOWA II'},
	{text: 'KONWALIOWA III', value: 'KONWALIOWA III'},
	{text: 'KOPALNIANA I', value: 'KOPALNIANA I'},
	{text: 'KOPALNIANA II', value: 'KOPALNIANA II'},
	{text: 'KOPERNIKA', value: 'KOPERNIKA'},
	{text: 'KORCZAKA', value: 'KORCZAKA'},
	{text: 'KORDECKIEGO', value: 'KORDECKIEGO'},
	{text: 'KORFANTEGO', value: 'KORFANTEGO'},
	{text: 'KORFANTEGO I', value: 'KORFANTEGO I'},
	{text: 'KORKOWA', value: 'KORKOWA'},
	{text: 'KORKOWA I', value: 'KORKOWA I'},
	{text: 'KORKOWA II', value: 'KORKOWA II'},
	{text: 'KORWINÓW', value: 'KORWINÓW'},
	{text: 'KOSMOWSKIEJ', value: 'KOSMOWSKIEJ'},
	{text: 'KOŚCIELNA', value: 'KOŚCIELNA'},
	{text: 'KRAKOWSKA', value: 'KRAKOWSKA'},
	{text: 'KRĘCIWILK', value: 'KRĘCIWILK'},
	{text: 'KUCELIN - HUTA', value: 'KUCELIN - HUTA'},
	{text: 'KUCELIN - SZPITAL', value: 'KUCELIN - SZPITAL'},
	{text: 'KUKUCZKI', value: 'KUKUCZKI'},
	{text: 'KURPIŃSKIEGO', value: 'KURPIŃSKIEGO'},
	{text: 'KUSIĘTA I', value: 'KUSIĘTA I'},
	{text: 'KUSIĘTA II', value: 'KUSIĘTA II'},
	{text: 'KUSIĘTA III', value: 'KUSIĘTA III'},
	{text: 'KUSIĘTA IV', value: 'KUSIĘTA IV'},
	{text: 'KUSIĘTA V', value: 'KUSIĘTA V'},
	{text: 'KUSIĘTA VI', value: 'KUSIĘTA VI'},
	{text: 'KUSIĘTA VII', value: 'KUSIĘTA VII'},
	{text: 'LAKOWA', value: 'LAKOWA'},
	{text: 'LEDNICKA', value: 'LEDNICKA'},
	{text: 'LEGIONÓW', value: 'LEGIONÓW'},
	{text: 'LEŚNA', value: 'LEŚNA'},
	{text: 'LISIA', value: 'LISIA'},
	{text: 'LISZKA DOLNA ', value: 'LISZKA DOLNA '},
	{text: 'LOTOSU', value: 'LOTOSU'},
	{text: 'LUDOWA', value: 'LUDOWA'},
	{text: 'LWOWSKA', value: 'LWOWSKA'},
	{text: 'ŁANOWA', value: 'ŁANOWA'},
	{text: 'ŁOJKI', value: 'ŁOJKI'},
	{text: 'ŁÓDZKA', value: 'ŁÓDZKA'},
	{text: 'MAKRO', value: 'MAKRO'},
	{text: 'MAKUSZYŃSKIEGO', value: 'MAKUSZYŃSKIEGO'},
	{text: 'MALOWNICZA', value: 'MALOWNICZA'},
	{text: 'MALOWNICZA I', value: 'MALOWNICZA I'},
	{text: 'MALOWNICZA II', value: 'MALOWNICZA II'},
	{text: 'MALOWNICZA III', value: 'MALOWNICZA III'},
	{text: 'MAŁA', value: 'MAŁA'},
	{text: 'MANGANOWA', value: 'MANGANOWA'},
	{text: 'MARKET OBI', value: 'MARKET OBI'},
	{text: 'MARUSARZA', value: 'MARUSARZA'},
	{text: 'MARYNARSKA', value: 'MARYNARSKA'},
	{text: 'MATEJKI', value: 'MATEJKI'},
	{text: 'MAZURY', value: 'MAZURY'},
	{text: 'MAZURY I', value: 'MAZURY I'},
	{text: 'MELIORANTÓW', value: 'MELIORANTÓW'},
	{text: 'MICHAŁOWSKIEGO', value: 'MICHAŁOWSKIEGO'},
	{text: 'MICHAŁÓW', value: 'MICHAŁÓW'},
	{text: 'MIELCZARSKIEGO', value: 'MIELCZARSKIEGO'},
	{text: 'MIRECKIEGO', value: 'MIRECKIEGO'},
	{text: 'MIROWSKA', value: 'MIROWSKA'},
	{text: 'MIRÓW', value: 'MIRÓW'},
	{text: 'MIRÓW - PEGAZ', value: 'MIRÓW - PEGAZ'},
	{text: 'MŁYNEK', value: 'MŁYNEK'},
	{text: 'MONIUSZKI', value: 'MONIUSZKI'},
	{text: 'MONTEX', value: 'MONTEX'},
	{text: 'MORENOWA', value: 'MORENOWA'},
	{text: 'MSTOWSKA', value: 'MSTOWSKA'},
	{text: 'NARCYZOWA', value: 'NARCYZOWA'},
	{text: 'NIERADA', value: 'NIERADA'},
	{text: 'NIERADA - KOŚCIÓŁ', value: 'NIERADA - KOŚCIÓŁ'},
	{text: 'NIERADA - SKRZYŻOWANIE', value: 'NIERADA - SKRZYŻOWANIE'},
	{text: 'NIERADA - SZKOŁA', value: 'NIERADA - SZKOŁA'},
	{text: 'NIERADA - TARGOWA I', value: 'NIERADA - TARGOWA I'},
	{text: 'NIERADA - TARGOWA II', value: 'NIERADA - TARGOWA II'},
	{text: 'NORWIDA', value: 'NORWIDA'},
	{text: 'NOWA WIEŚ - AUCHAN', value: 'NOWA WIEŚ - AUCHAN'},
	{text: 'NOWA WIEŚ - SKRZYŻOWANIE', value: 'NOWA WIEŚ - SKRZYŻOWANIE'},
	{text: 'NOWA WIEŚ I', value: 'NOWA WIEŚ I'},
	{text: 'NOWA WIEŚ II', value: 'NOWA WIEŚ II'},
	{text: 'NOWE BRZEZINY I', value: 'NOWE BRZEZINY I'},
	{text: 'NOWE BRZEZINY II', value: 'NOWE BRZEZINY II'},
	{text: 'NOWOBIALSKA', value: 'NOWOBIALSKA'},
	{text: 'OBROŃCÓW POCZTY GDAŃSKIEJ', value: 'OBROŃCÓW POCZTY GDAŃSKIEJ'},
	{text: 'OBROŃCÓW WESTERPLATTE', value: 'OBROŃCÓW WESTERPLATTE'},
	{text: 'OCZYSZCZALNIA WARTA', value: 'OCZYSZCZALNIA WARTA'},
	{text: 'ODRODZENIA', value: 'ODRODZENIA'},
	{text: 'ODRZYKOŃ', value: 'ODRZYKOŃ'},
	{text: 'ODRZYKOŃ - NARCYZOWA', value: 'ODRZYKOŃ - NARCYZOWA'},
	{text: 'OKRZEI', value: 'OKRZEI'},
	{text: 'OLEŃKI', value: 'OLEŃKI'},
	{text: 'OLSZTYN - MSTOWSKA', value: 'OLSZTYN - MSTOWSKA'},
	{text: 'OLSZTYN - NAPOLEONA', value: 'OLSZTYN - NAPOLEONA'},
	{text: 'OLSZTYN - RYNEK', value: 'OLSZTYN - RYNEK'},
	{text: 'OLSZTYN - ŚW. PUSZCZY', value: 'OLSZTYN - ŚW. PUSZCZY'},
	{text: 'OLSZTYN - ŻWIRKI I WIGURY', value: 'OLSZTYN - ŻWIRKI I WIGURY'},
	{text: 'ORKANA - SZKOŁA', value: 'ORKANA - SZKOŁA'},
	{text: 'ORLIK-RUCKEMANNA', value: 'ORLIK-RUCKEMANNA'},
	{text: 'OS. POD WILCZĄ GÓRĄ', value: 'OS. POD WILCZĄ GÓRĄ'},
	{text: 'OSTATNI GROSZ', value: 'OSTATNI GROSZ'},
	{text: 'PARKITKA - OSIEDLE', value: 'PARKITKA - OSIEDLE'},
	{text: 'PARKITKA - SZPITAL', value: 'PARKITKA - SZPITAL'},
	{text: 'PIASTOWSKA', value: 'PIASTOWSKA'},
	{text: 'PILECKIEGO - RONDO', value: 'PILECKIEGO - RONDO'},
	{text: 'PIŁSUDSKIEGO', value: 'PIŁSUDSKIEGO'},
	{text: 'PLAC BIEGAŃSKIEGO', value: 'PLAC BIEGAŃSKIEGO'},
	{text: 'PLAC DASZYŃSKIEGO', value: 'PLAC DASZYŃSKIEGO'},
	{text: 'PLAC ORLĄT LWOWSKICH', value: 'PLAC ORLĄT LWOWSKICH'},
	{text: 'PLAC PAMIĘCI NARODOWEJ', value: 'PLAC PAMIĘCI NARODOWEJ'},
	{text: 'POCZESNA - BOREK', value: 'POCZESNA - BOREK'},
	{text: 'POCZESNA - GÓRNICZA', value: 'POCZESNA - GÓRNICZA'},
	{text: 'POCZESNA - HANDLOWA', value: 'POCZESNA - HANDLOWA'},
	{text: 'POCZESNA - KATOWICKA', value: 'POCZESNA - KATOWICKA'},
	{text: 'POCZESNA - KOŚCIÓŁ', value: 'POCZESNA - KOŚCIÓŁ'},
	{text: 'POCZESNA - ŁĄKOWA I', value: 'POCZESNA - ŁĄKOWA I'},
	{text: 'POCZESNA - ŁĄKOWA II', value: 'POCZESNA - ŁĄKOWA II'},
	{text: 'POCZESNA - OSP', value: 'POCZESNA - OSP'},
	{text: 'POCZESNA - POŁUDNIOWA', value: 'POCZESNA - POŁUDNIOWA'},
	{text: 'POCZESNA - POŁUDNIOWA I', value: 'POCZESNA - POŁUDNIOWA I'},
	{text: 'POCZESNA - PROSTA', value: 'POCZESNA - PROSTA'},
	{text: 'POCZESNA - STRAŻACKA', value: 'POCZESNA - STRAŻACKA'},
	{text: 'POCZESNA - SZKOŁA', value: 'POCZESNA - SZKOŁA'},
	{text: 'POLITECHNIKA ', value: 'POLITECHNIKA '},
	{text: 'POLONTEX', value: 'POLONTEX'},
	{text: 'POLSKIEGO CZERWONEGO KRZYŻA ', value: 'POLSKIEGO CZERWONEGO KRZYŻA '},
	{text: 'POSELSKA', value: 'POSELSKA'},
	{text: 'POWSTAŃCÓW ŚLĄSKICH', value: 'POWSTAŃCÓW ŚLĄSKICH'},
	{text: 'POWSTAŃCÓW WARSZAWY', value: 'POWSTAŃCÓW WARSZAWY'},
	{text: 'PROMENADA NIEMENA', value: 'PROMENADA NIEMENA'},
	{text: 'PRUSA', value: 'PRUSA'},
	{text: 'PRZESTRZENNA', value: 'PRZESTRZENNA'},
	{text: 'PRZYJEMNA', value: 'PRZYJEMNA'},
	{text: 'PUSTA', value: 'PUSTA'},
	{text: 'PZU', value: 'PZU'},
	{text: 'RAKOWSKA', value: 'RAKOWSKA'},
	{text: 'RAKÓW - DWORZEC PKP', value: 'RAKÓW - DWORZEC PKP'},
	{text: 'REJTANA', value: 'REJTANA'},
	{text: 'REJTANA - SĄDY', value: 'NOWOBIALSKA'},
	{text: 'ROLNICZA - CMENTARZ KULE', value: 'ROLNICZA - CMENTARZ KULE'},
	{text: 'RONDO MICKIEWICZA ', value: 'RONDO MICKIEWICZA '},
	{text: 'RONDO TRZECH KRZYŻY', value: 'RONDO TRZECH KRZYŻY'},
	{text: 'RÓWNOLEGŁA', value: 'RÓWNOLEGŁA'},
	{text: 'RUTKIEWICZ', value: 'RUTKIEWICZ'},
	{text: 'RYDZA-ŚMIGŁEGO', value: 'RYDZA-ŚMIGŁEGO'},
	{text: 'RYNEK NARUTOWICZA', value: 'RYNEK NARUTOWICZA'},
	{text: 'RYNEK WIELUŃSKI', value: 'RYNEK WIELUŃSKI'},
	{text: 'RZĄSAWA', value: 'RZĄSAWA'},
	{text: 'RZĄSAWA - DWORZEC PKP', value: 'RZĄSAWA - DWORZEC PKP'},
	{text: 'RZĄSAWSKA - UCZELNIA', value: 'RZĄSAWSKA - UCZELNIA'},
	{text: 'RZECZNA', value: 'RZECZNA'},
	{text: 'SABINOWSKA', value: 'SABINOWSKA'},
	{text: 'SABINÓW', value: 'SABINÓW'},
	{text: 'SĄSIEDZKA', value: 'SĄSIEDZKA'},
	{text: 'SCHILLERA', value: 'SCHILLERA'},
	{text: 'SKARPOWA', value: 'SKARPOWA'},
	{text: 'SKORKI', value: 'SKORKI'},
	{text: 'SKRAJNICA', value: 'SKRAJNICA'},
	{text: 'SKRZYNECKIEGO', value: 'SKRZYNECKIEGO'},
	{text: 'SKWER SOKOŁÓW', value: 'SKWER SOKOŁÓW'},
	{text: 'SŁONIMSKIEGO', value: 'SŁONIMSKIEGO'},
	{text: 'SŁOWACKIEGO', value: 'SŁOWACKIEGO'},
	{text: 'SŁOWIK I', value: 'SŁOWIK I'},
	{text: 'SŁOWIK II', value: 'SŁOWIK II'},
	{text: 'SOBUCZYNA', value: 'SOBUCZYNA'},
	{text: 'SOKOLE GÓRY', value: 'SOKOLE GÓRY'},
	{text: 'SPORTOWA', value: 'SPORTOWA'},
	{text: 'STADION CKS BUDOWLANI', value: 'STADION CKS BUDOWLANI'},
	{text: 'STADION MIEJSKI', value: 'STADION MIEJSKI'},
	{text: 'STADION RAKÓW', value: 'STADION RAKÓW'},
	{text: 'STARA GORZELNIA', value: 'STARA GORZELNIA'},
	{text: 'STARA GORZELNIA I', value: 'STARA GORZELNIA I'},
	{text: 'STARY RAKÓW', value: 'STARY RAKÓW'},
	{text: 'STARY RYNEK', value: 'STARY RYNEK'},
	{text: 'STARZYŃSKIEGO', value: 'STARZYŃSKIEGO'},
	{text: 'STRADOM', value: 'STRADOM'},
	{text: 'STRADOM - DWORZEC PKP', value: 'STRADOM - DWORZEC PKP'},
	{text: 'STROMA', value: 'STROMA'},
	{text: 'SZKOŁA STRAŻY POŻARNEJ', value: 'SZKOŁA STRAŻY POŻARNEJ'},
	{text: 'SZPITALNA', value: 'SZPITALNA'},
	{text: 'ŚW. AUGUSTYNA', value: 'ŚW. AUGUSTYNA'},
	{text: 'ŚW. BARBARY', value: 'ŚW. BARBARY'},
	{text: 'ŚW. BARBARY - SZPITAL', value: 'ŚW. BARBARY - SZPITAL'},
	{text: 'ŚW. BRATA ALBERTA', value: 'ŚW. BRATA ALBERTA'},
	{text: 'ŚW. KAZIMIERZA', value: 'ŚW. KAZIMIERZA'},
	{text: 'ŚW. KINGI', value: 'ŚW. KINGI'},
	{text: 'ŚW. KRZYSZTOFA', value: 'ŚW. KRZYSZTOFA'},
	{text: 'ŚW. ROCHA - SZKOŁA', value: 'ŚW. ROCHA - SZKOŁA'},
	{text: 'TATRZAŃSKA', value: 'TATRZAŃSKA'},
	{text: 'TURYSTYCZNA', value: 'TURYSTYCZNA'},
	{text: 'TEATR IM. A. MICKIEWICZA', value: 'TEATR IM. A. MICKIEWICZA'},
	{text: 'TYSIĄCLECIE - SZPITAL', value: 'TYSIĄCLECIE - SZPITAL'},
	{text: 'UGODY', value: 'UGODY'},
	{text: 'URZĄD CELNY', value: 'URZĄD CELNY'},
	{text: 'WALCOWNIA', value: 'WALCOWNIA'},
	{text: 'WAWRZYNOWICZA', value: 'WAWRZYNOWICZA'},
	{text: 'WĄSOSZ', value: 'WĄSOSZ'},
	{text: 'WĄSOSZ - SKRZYŻOWANIE', value: 'WĄSOSZ - SKRZYŻOWANIE'},
	{text: 'WCZASOWA', value: 'WCZASOWA'},
	{text: 'WEYSSENHOFF', value: 'WEYSSENHOFF'},
	{text: 'WICHROWA', value: 'WICHROWA'},
	{text: 'WIELKOBORSKA', value: 'WIELKOBORSKA'},
	{text: 'WITOSA', value: 'WITOSA'},
	{text: 'WOLNA', value: 'WOLNA'},
	{text: 'WRĘCZYCKA', value: 'WRĘCZYCKA'},
	{text: 'WRZOSOWA', value: 'WRZOSOWA'},
	{text: 'WRZOSOWA - DŁUGA', value: 'WRZOSOWA - DŁUGA'},
	{text: 'WRZOSOWA - KŁADKA', value: 'WRZOSOWA - KŁADKA'},
	{text: 'WRZOSOWA - OGRODOWA', value: 'WRZOSOWA - OGRODOWA'},
	{text: 'WRZOSOWA - SABINOWSKA I', value: 'WRZOSOWA - SABINOWSKA I'},
	{text: 'WRZOSOWA - SZKOŁA', value: 'WRZOSOWA - SZKOŁA'},
	{text: 'WRZOSOWIAK', value: 'WRZOSOWIAK'},
	{text: 'WSPÓLNA', value: 'WSPÓLNA'},
	{text: 'WYCZERPY - OSIEDLE', value: 'WYCZERPY - OSIEDLE'},
	{text: 'WYCZERPY DOLNE', value: 'WYCZERPY DOLNE'},
	{text: 'WYCZERPY GÓRNE', value: 'WYCZERPY GÓRNE'},
	{text: 'WYGODA', value: 'WYGODA'},
	{text: 'WYPOCZYNKU', value: 'WYPOCZYNKU'},
	{text: 'WYSZYŃSKIEGO', value: 'WYSZYŃSKIEGO'},
	{text: 'ZANA', value: 'ZANA'},
	{text: 'ZAWODZIE', value: 'ZAWODZIE'},
	{text: 'ZAWODZIE - CMENTARNA', value: 'ZAWODZIE - CMENTARNA'},
	{text: 'ZAWODZIE - CMENTARZ', value: 'ZAWODZIE - CMENTARZ'},
	{text: 'ZAWODZIE - DŁUGA I', value: 'ZAWODZIE - DŁUGA I'},
	{text: 'ZAWODZIE - DŁUGA II', value: 'ZAWODZIE - DŁUGA II'},
	{text: 'ZAWODZIE - SZPITAL', value: 'ZAWODZIE - SZPITAL'},
	{text: 'ZBYSZKA', value: 'ZBYSZKA'},
	{text: 'ZDROWA', value: 'ZDROWA'},
	{text: 'ZEGAROWA', value: 'ZEGAROWA'},
	{text: 'ZIELNA', value: 'ZIELNA'},
	{text: 'ZIMOWA', value: 'ZIMOWA'},
	{text: 'ZŁOTA', value: 'ZŁOTA'},
	{text: 'ŻABINIEC', value: 'ŻABINIEC'},
	{text: 'ŻARECKA', value: 'ŻARECKA'},
	{text: 'ŻEROMSKIEGO', value: 'ŻEROMSKIEGO'},
	{text: 'ŻONKILOWA', value: 'ŻONKILOWA'},
	{text: 'ŻYZNA', value: 'ŻYZNA'},
]
