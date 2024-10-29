$FileToHash = Read-Host "Enter the file to hash"        # Use the Resolve-Path cmdlet to get the full path of the file and paste the output here.
$Algorithm = Read-Host "Choose an algorithm"        # Case-insensitive. Available options are MD5, SHA1, SHA256, SHA384, and SHA512.
$PublishedHash = Read-Host "Enter the published file hash"

try {
    $FileHash = (Get-FileHash -Algorithm $Algorithm $FileToHash).Hash
    if ($FileHash -eq $PublishedHash) {
        Write-Host "It's a match! The hashes are equivalent." -ForegroundColor Green
    }
    else {
        Write-Host "Something's off. Review the output below to see the difference in the hashes provided." -ForegroundColor Yellow
        Compare-Object -ReferenceObject $FileHash -DifferenceObject $PublishedHash
    }
}
catch {
    Write-Host "An unexpected error occured. Verify that all inputs are valid and try again." -ForegroundColor Red
}