# KSeF XML → HTML (FA(3))

Skrypt PowerShell umożliwia przekształcenie pliku faktury ustrukturyzowanej KSeF w strukturze FA(3) (plik `*.xml`) do czytelnego pliku `*.html` z użyciem arkusza transformacji XSLT.[file:1][file:2][web:3][web:4][web:11]

## Zawartość rozwiązania

- `KsefXmlToHtml.ps1` – skrypt PowerShell otwierający wskazany plik XML i wykonujący transformację XSLT do HTML.[file:1]
- `kseffaktura_fa-3.xsl` – arkusz XSLT definiujący wygląd i układ faktury HTML na podstawie danych z e‑Faktury KSeF w strukturze FA(3).[file:2][web:3][web:4]

## Wymagania wstępne

- Windows z zainstalowanym PowerShell (skrypt korzysta z .NET i Windows Forms do wyboru pliku).[file:1]
- Plik faktury KSeF w formacie XML zgodny ze strukturą FA(3).[web:3][web:4][web:11]
- Pliki `KsefXmlToHtml.ps1` oraz `kseffaktura_fa-3.xsl` w tym samym katalogu.[file:1]

## Sposób działania

1. Uruchom `KsefXmlToHtml.ps1` w PowerShell (np. z katalogu, w którym znajdują się skrypt i arkusz XSLT).[file:1]
2. W oknie dialogowym wybierz plik faktury `*.xml` (np. pobrany z KSeF).[file:1][web:11]
3. Skrypt:
    - odczyta wybraną ścieżkę XML,
    - wskaże arkusz XSLT `kseffaktura_fa(3).xsl`,
    - utworzy wynikowy plik HTML o nazwie zgodnej z nazwą pliku XML (np. `FA123.xml` → `FA123.html`).[file:1]
4. Po zakończeniu pojawi się komunikat `Gotowe: <ścieżka_do_pliku_html>`, a plik można otworzyć w przeglądarce.[file:1]

## Szczegóły techniczne skryptu

- Interfejs wyboru pliku: `System.Windows.Forms.OpenFileDialog` z filtrem `*.xml`.[file:1]
- Transformacja:
    - `System.Xml.Xsl.XslCompiledTransform` do wczytania XSLT i wykonania transformacji.[file:1]
    - Ustawienia wyjścia:
        - wcięcia w HTML (`Indent = $true`),
        - kodowanie UTF‑8 bez BOM (`System.Text.UTF8Encoding($false)`).[file:1]
- Nazwa pliku wynikowego:
    - pobierana z nazwy źródłowego pliku XML bez rozszerzenia,
    - rozszerzenie zmieniane na `.html`.[file:1]

## Typowe zastosowanie

- Szybki podgląd zawartości faktury FA(3) poza systemem księgowym, w zwykłej przeglądarce.[web:3][web:11]
- Przygotowanie wydruku lub zrzutów ekranowych faktur z KSeF do celów prezentacyjnych lub archiwizacyjnych w formie czytelnego HTML.[web:11][web:8]
