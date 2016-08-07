
CZADOWNIK - Konsola protokołu POLChat, opracowana na przełomie 2001-2002.
=========

Wersja 2.1.0.134 nie obsługuje wielu pokoi.
W implementacji wykorzystano zestaw bibliotek/komponentów Delphi 7 PE, dostępnych w tym
okresie, jak również źródłą appletu POLChata, opublikowane przez jego autora, na licencji GPL.

Kod jest kiepskiej jakości i zawiera sporo błędów -- uczyłem się ;-)


ŚRODOWISKO
==========

*** Instalacja Delphi 7 Personal
	Pobierz i zainstaluj środowisko Borland Delphi 7 Personal. Wersja instalacyjna dostępna jest
	publicznie, wyłącznie do użytku prywatnergo (nie komercyjnego). 
	http://delphifocus.blogspot.com/2009/07/delphi-7-personal-official-download.html
	Instalator wymaga numeru seryjnego i klucza autoryzującego. Te rownież sa dostępne publicznie w sieci.

INSTALACJA KOMPONENTÓW
======================

*** ICS - Internet Component Suite (Aka FPIETTE's Components) - dołączony do repozytorium.
	Z katalogu .\Delphi\vs32 otwórz paczkę (Delphi package *dpk) o nazwie IcsDel70.dpk. Następnie ją
	skompiluj (Compile) oraz zainstaluj (Install). Poprawne wykonanie operacji skutkuje pojawienie
	się nowej zakładki komponentów, o nazwie FPiette.

*** RXLib 2.7.5 - dołączony do repozytorium; dostępny pod adresem http://www.micrel.cz/RxLib/dfiles.htm
	w podrozdziale "Old versions of library" znajduje się link  "Updated RxLib for Delphi 6 and 7 too
	(main patch by Polaris, new extension of RichEdit etc.)"
	Adres to http://www.micrel.cz/RxLib/files/rxlibupd.zip
	Z katalogu .\RXLib275\Units wybierz i otwórz paczkę DclRx7.dpk. Następnie ją skompiluj (Compile)
	oraz zainstaluj (Install). Pojawią się zakładki RX Tools i RX Controls.

*** Cool Tray Icon - dołączona do repozytorium; Dostępny pod adresem http://www.delphipages.com/comp/cooltrayicon_v_-2576.html
	Z katalogu ./CoolTrayIcon wybierz i otwórz paczkę CoolTrayIcon_D6plus.dpk. Następnie ją skompiluj
	(Compile) oraz zainstaluj (Install). Pojawi się zakładka Tray Icons.

*** TopMost - dołączony do repozytorium; Dostępny pod adresem http://torry.net/authorsmore.php?id=62&sort=ID
	Z katalogu ./TopMost wybierz i otwórz paczkę TopMostD7.dpk. Następnie ją skompiluj (Compile)
	oraz zainstaluj (Install). Pojawi się zakładka Kompo.

*** ClientSocket - wbudowany komponent komunikacji sieciowej, ale domyślnie nieskonfigurowany w D7 Personal.
	Z katalogu ./Sockets wybierz i otwórz paczkę SocketsD7.dpk. Następnie ją skompiluj (Compile) oraz
	zainstaluj (Install). Pojawi się zakładka Internet.
