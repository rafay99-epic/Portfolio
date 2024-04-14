# Define a log file
$logFile = "log.txt"

# Function to log errors
function LogError {
    param([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp ERROR: $message" | Out-File -FilePath $logFile -Append
}

# Ask for platform
$platform = Read-Host -Prompt 'Enter your platform (android or web)'

# Start the emulator if the platform is android
if ($platform -eq 'android') {
    try {
        flutter emulator --launch Prometheus
    }
    catch {
        LogError "Failed to start the emulator: $_"
        exit 1
    }

    # Wait for the emulator to start
    Start-Sleep -s 30
}

# Clean and get packages
try {
    flutter clean
    flutter pub get
}
catch {
    LogError "Failed to clean and get packages: $_"
    exit 1
}

# Run the app on the selected platform
try {
    if ($platform -eq 'web') {
        flutter run -d chrome
    }
    elseif ($platform -eq 'android') {
        flutter run -d emulator
    }
    else {
        throw "Invalid platform. Please enter either 'android' or 'web'."
    }
}
catch {
    LogError "Failed to run the app: $_"
    exit 1
}