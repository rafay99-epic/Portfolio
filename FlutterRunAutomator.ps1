$logFile = "log.txt"
$platform = Read-Host -Prompt 'Enter your platform (android or web)'

function LogError {
    param([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp ERROR: $message" | Out-File -FilePath $logFile -Append
}

# function WaitForEmulatorToBeReady() {
#     $isReady = $false
#     while (-not $isReady) {
#         $output = adb shell getprop init.svc.bootanim
#         if ($output -eq 'stopped') {
#             $isReady = $true
#         }
#         else {
#             Write-Host "Waiting for emulator to be ready..."
#             Start-Sleep -Seconds 10
#         }
#     }
# }
function WaitForEmulatorToBeReady() {
    $isReady = $false
    while (-not $isReady) {
        try {
            $output = adb shell getprop init.svc.bootanim
            if ($output -eq 'stopped') {
                $isReady = $true
            }
            else {
                Write-Host "Waiting for emulator to be ready..."
                Start-Sleep -Seconds 10
            }
        }
        catch {
            LogError "Failed to check emulator status: $_"
            exit 1
        }
    }
}

function RunEmulator() {
    if ($platform -eq 'android') {
        try {
            flutter emulator --launch Prometheus
            WaitForEmulatorToBeReady
        }
        catch {
            Write-Host "Failed to start the Prometheus emulator. Available emulators:"
            LogError "Failed to start the Prometheus emulator: $_"
            flutter emulators
            $emulatorName = Read-Host -Prompt 'Enter the name of the emulator you want to launch'
            try {
                flutter emulator --launch $emulatorName
                WaitForEmulatorToBeReady
            }
            catch {
                LogError "Failed to start the emulator $emulatorName : $_"
                exit 1
            }
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


