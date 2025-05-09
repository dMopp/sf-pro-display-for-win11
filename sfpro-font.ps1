param (
    [switch]$Uninstall
)

Write-Host "`n🔧 $(if ($Uninstall) { 'Deinstalliere' } else { 'Installiere' }) SF Pro Display..." -ForegroundColor Cyan

$fonts = @(
    @{ File = "SFProDisplay-Regular.ttf";      Reg = "SF Pro Display (TrueType)" },
    @{ File = "SFProDisplay-Bold.ttf";         Reg = "SF Pro Display Bold (TrueType)" },
    @{ File = "SFProDisplay-RegularItalic.ttf";Reg = "SF Pro Display Italic (TrueType)" },
    @{ File = "SFProDisplay-BoldItalic.ttf";   Reg = "SF Pro Display Bold Italic (TrueType)" }
)

$fontPath = "$env:SystemRoot\Fonts"
$regPath  = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts"
$here     = Get-Location

if ($Uninstall) {
    Write-Host "`n🗑 Entferne Schriftdateien und Registry-Einträge..." -ForegroundColor DarkYellow
    foreach ($f in $fonts) {
        $target = Join-Path $fontPath $f.File
        if (Test-Path $target) {
            Remove-Item -Path $target -Force -ErrorAction SilentlyContinue
            Write-Host "🗑 Entfernt: $($f.File)"
        }

        Remove-ItemProperty -Path $regPath -Name $f.Reg -ErrorAction SilentlyContinue
        Write-Host "🧹 Registry-Eintrag entfernt: $($f.Reg)"
    }

    Write-Host "`n🔄 Reaktiviere ClearType..." -ForegroundColor Yellow
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "FontSmoothing" -Value "2"
    Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "FontSmoothingType" -Value "2"
    Write-Host "✅ ClearType wurde wieder aktiviert." -ForegroundColor Green
}
else {
    foreach ($f in $fonts) {
        $src = Join-Path $here $f.File
        $dst = Join-Path $fontPath $f.File

        if (-not (Test-Path $src)) {
            Write-Host "❌ Datei nicht gefunden: $($f.File)" -ForegroundColor Red
            continue
        }

        Write-Host "📥 Kopiere: $($f.File)" -ForegroundColor Yellow
        Copy-Item $src -Destination $dst -Force

        Write-Host "📝 Registriere: $($f.Reg)" -ForegroundColor Green
        New-ItemProperty -Path $regPath -Name $f.Reg -PropertyType String -Value $f.File -Force
    }

    Write-Host "`n❓ Möchtest du ClearType (empfohlen bei WOLED) deaktivieren? (j/n)" -ForegroundColor Cyan
    $input = Read-Host
    if ($input -eq 'j') {
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "FontSmoothing" -Value "2"
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "FontSmoothingType" -Value "1"
        Write-Host "✅ ClearType wurde deaktiviert." -ForegroundColor Green
    } else {
        Write-Host "ℹ️ ClearType bleibt aktiviert." -ForegroundColor DarkYellow
    }
}

Write-Host "`n🔁 Bitte starte dein System neu oder melde dich ab/an." -ForegroundColor Yellow
Write-Host "`nDrücke eine Taste zum Beenden..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
