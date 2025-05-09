
# SF Pro Display als Systemschrift unter Windows 11

Dieses Repository installiert **SF Pro Display** (Apple) als Systemschrift unter Windows 11 und ersetzt die Standard-Schriftart **Segoe UI**.

## ✅ Enthalten

- **Anleitung** zum Herunterladen der Originalschrift  
- **PowerShell-Skript** zum Installieren / Deinstallieren  
- Hinweise zum Ausführen des Skripts **mit Admin-Rechten**

---

## 🔽 1. SF Pro Display herunterladen

Offizielle Quelle:  
👉 https://developer.apple.com/fonts/

### Vorgehen unter Windows:

1. Lade die Datei `SF-Pro.dmg` herunter.  
2. Entpacke die Datei **dreimal** mit [7-Zip](https://www.7-zip.org/):

| Ebene | Datei/Ordner öffnen | Ergebnis                |
|-------|----------------------|-------------------------|
| 1     | `SF-Pro.dmg`         | `SFProFonts.pkg`        |
| 2     | `SFProFonts.pkg`     | `Payload`               |
| 3     | `Payload`            | `Library/Fonts/*.otf`   |

3. Kopiere **diese vier Dateien** in einen beliebigen Ordner, z. B. `C:\Fonts\SFProDisplay\`:

- `SF-Pro-Display-Regular.otf`  
- `SF-Pro-Display-Bold.otf`  
- `SF-Pro-Display-RegularItalic.otf`  
- `SF-Pro-Display-BoldItalic.otf`  

---

## 📁 2. Dateien vorbereiten

Lege die vier `.otf`-Dateien **zusammen mit `sfpro-font.ps1`** in denselben Ordner:

```
C:\Fonts\SFProDisplay
├─ SF-Pro-Display-Regular.otf
├─ SF-Pro-Display-Bold.otf
├─ SF-Pro-Display-RegularItalic.otf
├─ SF-Pro-Display-BoldItalic.otf
└─ sfpro-font.ps1
```

---

## ⚙ 3. Skript mit Administratorrechten ausführen

Da Windows 11 `.ps1`-Dateien nicht über das Kontextmenü mit Admin-Rechten starten lässt, verwende folgende Methode:

### 🟢 Variante A: Über den Task-Manager

1. Öffne den **Task-Manager** (`Strg` + `Shift` + `Esc`)  
2. Gehe zu **Datei → Neuen Task ausführen**  
3. Gib ein:

```
powershell
```

4. Aktiviere ✅ „Diesen Task mit Administratorrechten erstellen“  
5. Klicke auf **OK**  
6. Wechsle in das Verzeichnis mit dem Skript:

```
cd "C:\Fonts\SFProDisplay"
```

7. Führe das Skript aus:

```
.\sfpro-font.ps1             # installiert SF Pro Display
.\sfpro-font.ps1 -Uninstall  # stellt Segoe UI wieder her
```

---

## 🔁 Hinweise

- 🔄 Ein **Neustart** ist nach der Installation erforderlich  
- Die Schrift wirkt **systemweit** (Explorer, Taskleiste, Fensterrahmen etc.)  
- Die Option `-Uninstall` stellt die Standard-Schriftart **Segoe UI** wieder her
