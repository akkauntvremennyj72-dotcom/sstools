# Принудительно выставляем UTF8 для консоли
[console]::InputEncoding = [System.Text.Encoding]::UTF8
[console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Куда качаем все утилиты
$targetFolder = "C:\ss"

# Создаем папку, если её нет
if (-not (Test-Path $targetFolder)) {
    New-Item -ItemType Directory -Path $targetFolder | Out-Null
}

# Полный список утилит
$files = @(
    [PSCustomObject]@{ Name = "pv++"; FileName = "pv++.exe"; URL = "https://cdn.discordapp.com/attachments/1495118516657848420/1505179396309385317/pv.exe?ex=6a09af0c&is=6a085d8c&hm=205a788c5ae65540c8f0e73b2a41402929eb325104e5fd04d7054a57d8a79805&" }
    [PSCustomObject]@{ Name = "Echo Journal"; FileName = "echo-journal(1).exe"; URL = "https://cdn.discordapp.com/attachments/1495118516657848420/1505176881799102594/echo-journal1.exe?ex=6a09acb5&is=6a085b35&hm=42bbd5054b43a4010cebd4d7951c683def172fe865c1643568933374babc5739&" }
    [PSCustomObject]@{ Name = "Echo USB"; FileName = "echo-usb.exe"; URL = "https://cdn.discordapp.com/attachments/1495118516657848420/1505176882105028668/echo-usb.exe?ex=6a09acb5&is=6a085b35&hm=c82b96c3ecbb7a0f38883eae41eca7403d9d613cce1d3f95c99153a3123fb8c7&" }
    [PSCustomObject]@{ Name = "Echo Userassist"; FileName = "echo-userassist.exe"; URL = "https://cdn.discordapp.com/attachments/1495118516657848420/1505176882541494323/echo-userassist.exe?ex=6a09acb5&is=6a085b35&hm=bfa1b5c8112ae7f7ee71a58a7de48bf4b3c57ad7d4a235d5daac50dbd83324e0&" }
    [PSCustomObject]@{ Name = "Cleaning Detector"; FileName = "CleaningDetector(1).exe"; URL = "https://cdn.discordapp.com/attachments/1495118516657848420/1505144807931117639/CleaningDetector.exe?ex=6a098ed6&is=6a083d56&hm=711f6a03ab8ccbb1f747d0334257f14e82bbfe92c88b06f45caa607115657185&" }
    [PSCustomObject]@{ Name = "RSS Registry"; FileName = "RSS-Registry.exe"; URL = "https://cdn.discordapp.com/attachments/1495118516657848420/1505147446517432400/RSS-Registry.exe?ex=6a09914b&is=6a083fcb&hm=4361fb651300679dad8c356260f2f55b7eab7b7c912171d7cc2b56f761ffb289&" }
    [PSCustomObject]@{ Name = "RSS AmCache"; FileName = "RSS-AmCache.exe"; URL = "https://cdn.discordapp.com/attachments/1495118516657848420/1505148397164826705/RSS-AmCache.exe?ex=6a09922e&is=6a0840ae&hm=e79dfcc3d5a1b64f2414df9fe156a96f6fb2b0a438efb9d1ed89cc2e8dbb6475&" }
    [PSCustomObject]@{ Name = "Paths Parser"; FileName = "PathsParser.exe"; URL = "https://cdn.discordapp.com/attachments/1495118516657848420/1505176882922917938/PathsParser.exe?ex=6a09acb5&is=6a085b35&hm=71242e9d4f8565fa89df2033a76353647f420c6ebcd747b31c44a28e6f422398&" }
    [PSCustomObject]@{ Name = "Everything x64"; FileName = "Everything-1.5.0.1409a.x64-Setup.exe"; URL = "https://cdn.discordapp.com/attachments/1495118516657848420/1505176961314586624/Everything-1.5.0.1409a.x64-Setup.exe?ex=6a09acc8&is=6a085b48&hm=9cfaea6799d236320098b5a44cc2a11360f3bccd172d8f90672a2aeb172df6de&" }
    [PSCustomObject]@{ Name = "Everything x86"; FileName = "Everything-1.5.0.1409a.x86-Setup.exe"; URL = "https://cdn.discordapp.com/attachments/1495118516657848420/1505176999319044106/Everything-1.5.0.1409a.x86-Setup.exe?ex=6a09acd1&is=6a085b51&hm=f0957bb34fd25a77a456ed7f639e7ae58256b4e3c00b9c5d0bd100f97d663c35&" }
    [PSCustomObject]@{ Name = "DIE x86 (ZIP)"; FileName = "die_win32_portable_3.21_x86.zip"; URL = "https://github.com/horsicq/DIE-engine/releases/download/3.22/die_win32_portable_3.22_x86.zip" }
    [PSCustomObject]@{ Name = "DIE x64 (ZIP)"; FileName = "die_win64_portable_3.21_x64.zip"; URL = "https://github.com/horsicq/DIE-engine/releases/download/3.22/die_win64_portable_3.22_x64.zip" }
    [PSCustomObject]@{ Name = "Cached Programs List"; FileName = "CachedProgramsList(1).exe"; URL = "https://cdn.discordapp.com/attachments/1495118516657848420/1505177439792398396/CachedProgramsList1.exe?ex=6a09ad3a&is=6a085bba&hm=f87a1cacf824432ce812a3c701bffe91c85f3ab63a5a3504f7aed71869f0eb71&" }
    [PSCustomObject]@{ Name = "Last Activity View"; FileName = "lastactivityview.zip"; URL = "https://cdn.discordapp.com/attachments/1495118516657848420/1505177592926306415/lastactivityview.zip?ex=6a09ad5f&is=6a085bdf&hm=8df5b514d6adae40af0d28a77b529c9a71ed005aba5f9bdef80660960d6398c2&" }
    [PSCustomObject]@{ Name = "Prefetch Parser"; FileName = "PrefetchParser.exe"; URL = "https://cdn.discordapp.com/attachments/1495118516657848420/1505179603214536804/PrefetchParser.exe?ex=6a09af3e&is=6a085dbe&hm=8330886cb6bc845b3165872d9eb052a76c4f72e419442fd77d3c06c20b44e3b2&" }
    [PSCustomObject]@{ Name = "WinDefLogView"; FileName = "windeflogview.zip"; URL = "https://www.nirsoft.net/utils/windeflogview.zip" }
    [PSCustomObject]@{ Name = "PcaSvcExecuted"; FileName = "PcaSvcExecuted.exe"; URL = "https://cdn.discordapp.com/attachments/1495118516657848420/1505179396728946839/PcaSvcExecuted.exe?ex=6a09af0d&is=6a085d8d&hm=619beefcbf52a40742120b8c3b14470e9709080db697677240a2121b7ce53335&" }
    [PSCustomObject]@{ Name = "Process Parser"; FileName = "ProcessParser.exe"; URL = "https://cdn.discordapp.com/attachments/1495118516657848420/1505179395898216609/ProcessParser.exe?ex=6a09af0c&is=6a085d8c&hm=174aa009c53319117adf1116e97d203f09953e1de2be69c13f3d10a3116e5286&" }
    [PSCustomObject]@{ Name = "Timeline Explorer"; FileName = "TimelineExplorer.zip"; URL = "https://download.ericzimmermanstools.com/net9/TimelineExplorer.zip" }
    [PSCustomObject]@{ Name = "Technical Utilities"; FileName = "Technical Utilities.exe"; URL = "https://raw.githubusercontent.com/txvch/Screenshare-Collector/refs/heads/main/Technical%20Utilities.exe" }
    
    # Ссылки с редиректом detect.ac
    [PSCustomObject]@{ Name = "BamParser++"; FileName = "BamParser++.exe"; URL = "https://detect.ac/tool/BamParser++" }
    [PSCustomObject]@{ Name = "USBDeview++"; FileName = "USBDeview++.exe"; URL = "https://detect.ac/tool/USBDeview++" }
    [PSCustomObject]@{ Name = "PowerShellParser++"; FileName = "PowerShellParser++.exe"; URL = "https://detect.ac/tool/PowerShellParser++" }
    [PSCustomObject]@{ Name = "KernelLiveDump++"; FileName = "KernelLiveDump++.exe"; URL = "https://detect.ac/tool/KernelLiveDump++" }
)

# Инициализируем статусы
$statuses = @{}
foreach ($f in $files) { $statuses[$f.Name] = "Pending..." }

# Функция отрисовки (Исключительно чистый список)
function Update-Menu {
    Clear-Host
    $i = 1
    foreach ($f in $files) {
        $status = $statuses[$f.Name]
        if ($status -eq "Downloading...") {
            Write-Host "$i. $($f.Name) ... " -NoNewline
            Write-Host "Downloading..." -ForegroundColor Yellow
        } elseif ($status -eq "[+] OK") {
            Write-Host "$i. $($f.Name) ... " -NoNewline
            Write-Host "[+] OK" -ForegroundColor Green
        } elseif ($status -eq "[!] Error") {
            Write-Host "$i. $($f.Name) ... " -NoNewline
            Write-Host "[!] Error" -ForegroundColor Red
        } else {
            Write-Host "$i. $($f.Name) ... $status" -ForegroundColor Gray
        }
        $i++
    }
}

# Отключаем дефолтные всплывающие прогресс-бары PowerShell
$ProgressPreference = 'SilentlyContinue'

# Процесс скачивания с принудительной перезаписью
foreach ($f in $files) {
    $statuses[$f.Name] = "Downloading..."
    Update-Menu
    
    $outputPath = Join-Path $targetFolder $f.FileName
    
    # Принудительно сносим старый файл перед скачиванием
    if (Test-Path $outputPath) {
        Remove-Item $outputPath -Force | Out-Null
    }
    
    try {
        $webClient = New-Object System.Net.WebClient
        $webClient.Headers.Add("user-agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36")
        $webClient.DownloadFile($f.URL, $outputPath)
        $statuses[$f.Name] = "[+] OK"
    } catch {
        $statuses[$f.Name] = "[!] Error"
    }
    Update-Menu
}
