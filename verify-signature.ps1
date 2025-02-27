param (
    [string]$inputFile,  # Path to the input file
    [string]$p7mFile,    # Path to the .p7m file
    [string]$crtFile     # Path to the .crt file
)

# Check if any of the parameters are missing
if (-not $inputFile) {
    Write-Host "Error: Missing parameter -inputFile (path to the file)."
    exit 1
}

if (-not $p7mFile) {
    Write-Host "Error: Missing parameter -p7mFile (path to the .p7m file)."
    exit 1
}

if (-not $crtFile) {
    Write-Host "Error: Missing parameter -crtFile (path to the .crt file)."
    exit 1
}

# Set the output file for the verified content
$outputFile = ".\verified_output" + [System.IO.Path]::GetExtension($inputFile)

# Step 1: Verify the signature
$verifyResult = openssl smime -verify -inform DER -in $p7mFile -CAfile $crtFile -out $outputFile 2>&1

if ($verifyResult -notmatch "Verification successful") {
    Write-Host "Error: Signature verification failed. The .p7m file may not be valid or signed correctly." -ForegroundColor Red
    Write-Host $verifyResult -ForegroundColor Red
    exit 1
}

# Step 2: Check if the original file and the verified file are the same
$originalFileHash = Get-FileHash -Path $inputFile -Algorithm SHA256
$verifiedFileHash = Get-FileHash -Path $outputFile -Algorithm SHA256

if ($originalFileHash.Hash -ne $verifiedFileHash.Hash) {
    Write-Host "Error: The files are different. The verification may have failed or the content has been altered." -ForegroundColor Red
    exit 1
}

# If everything passes
Write-Host "Verification successful: input file is trusted and identical to the signed one." -ForegroundColor Green
Write-Host "Verified file extracted in " $outputFile -ForegroundColor Green
