$logFile = "log.txt"
$platform = Read-Host -Prompt 'Enter your platform (android or web)'

function LogError {
    param([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp ERROR: $message" | Out-File -FilePath $logFile -Append
}



function RunEmulator() {
    if ($platform -eq 'android') {
        try {
            flutter emulator --launch Prometheus
        }
        catch {
            Write-Host "Failed to start the Prometheus emulator. Available emulators:"
            LogError "Failed to start the Prometheus emulator: $_"
            flutter emulators
            $emulatorName = Read-Host -Prompt 'Enter the name of the emulator you want to launch'
            try {
                flutter emulator --launch $emulatorName
            }
            catch {
                LogError "Failed to start the emulator $emulatorName : $_"
                exit 1
            }
        }
        # Start-Sleep -s 60
        for ($i = 60; $i -gt 0; $i--) {
            Write-Host "Waiting for emulator to start... $i seconds remaining"
            Start-Sleep -s 1
        }
    }
}

function cleanAndGetPackages() {
    try {
        flutter clean
    }
    catch {
        LogError "Failed to clean packages: $_"
        exit 1
    }

    try {
        flutter pub get
    }
    catch {
        LogError "Failed to get packages: $_"
        exit 1
    }
}
# Main Running Part 
try {
    if ($platform -eq 'web') {
        cleanAndGetPackages
        flutter run -d chrome
    }
    elseif ($platform -eq 'android') {
        cleanAndGetPackages
        RunEmulator
        flutter run -d emulator
    }
    else {
        Write-Host "Invalid platform. Please enter either 'android' or 'web'."
    }
}
catch {
    LogError "Failed to run the app: $_"
    exit 1
}


