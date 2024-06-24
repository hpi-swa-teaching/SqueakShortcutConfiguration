# Demoskript Shortcut Configuration

Der ShortcutBrowser kann geöffnet werden mit `ShortcutBrowser open`. Es öffnet sich ein Browser, in dem die Shortcuts von einigen Klassen konfiguriert werden können. \
Es werden alle Klassen angezeigt, die unsere API unterstützen. Das können Kernel-Klassen sein, für die wir unsere API implementiert haben, oder User-Klassen (also Klassen von potentiellen anderen Squeak-Entwicklern), die unsere API implementieren.

Durch Auswählen einer Klasse erscheint die Liste der aktuell konfigurierten Shortcuts. Durch Doppelklick auf einen dieser Shortcuts öffnet sich ein Dialogfenster, in dem ein neuer Shortcut gesetzt werden kann.
Wir unterstützen bis jetzt nur ctrl-Shortcuts und shift-ctrl-Shortcuts (die TextEditor- und SmalltalkEditor-Klassen unterstützen nur ctrl-Shortcuts)

Die SystemWindow-Klasse wird zwar angezeigt, die Shortcuts können aber noch nicht geändert werden, weil die Implementierung unfertig ist.

Die SSC_Example-Klasse implementiert beispielhaft unsere API, als Vorlage für Squeak-Entwickler, die ihre Klassen mit dem ShortcutBrowser konfigurierbar machen wollen.

Die Shortcuts der ausgewählten Klasse können zurückgesetzt werden mit dem Button "Reset class". Der Button "Reset all" setzt alle Shortcuts aller Klassen zurück.

Die Buttons "Help" und "Reset selected" sind aus dem legacy Projekt übernommen, aber noch nicht implementiert.