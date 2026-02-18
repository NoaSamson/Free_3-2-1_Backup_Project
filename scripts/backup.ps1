$env:RESTIC_PASSWORD_FILE="PATH_TO_RESTIC_PASSWORD_FILE"

$externalRepo = "PATH_TO_REPO_ON_EXTERNAL_DRIVE"
$cloudRepo = "rclone:gdrive:NAME_OF_REPO_ON_GOOGLE_DRIVE"
$source = "ORIGINAL_DIRECTORY_PATH"

# Check if there is an external drive available
if (Test-Path "PATH_TO_REPO_ON_EXTERNAL_DRIVE") {
    Write-Output "External drive found - starting local backup"
    restic -r $externalRepo backup $source
    restic -r $externalRepo forget --keep-last 14 --prune
}
else {
    Write-Output "External drive NOT connected - skipping local backup"
}

# Cloud backup works always
restic -r $cloudRepo backup $source
restic -r $cloudRepo forget --keep-last 14 --prune
