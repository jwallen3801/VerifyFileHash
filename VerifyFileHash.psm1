<#
 .Synopsis
  Hashes a file and compares it with the hash provided by the publisher.

.Description
  Hashes a file and compares it with the hash provided by the publisher to verify file integrity. Displays the hashes in the console for comparison if a mismatch is found.

.Parameter FileToHash
  The path to the file to be hashed.

.Parameter PublishedHash
  The file hash provided by the publisher to verify file integrity.

.Parameter Algorithm
  The algorithm to use when performing the hashing function.

.Example
   Verify-FileHash -FileToHash C:\Users\user\Downloads\PowerShell-7.4.6-win-x64.msi -PublishedHash "ED331A04679B83D4C013705282D1F3F8D8300485EB04C081F36E11EAF1148BD0" -Algorithm SHA256
#>
Function Verify-FileHash {
  param(
      [Parameter(Mandatory=$true)]
      [System.IO.FileInfo]$FileToHash,
      [Parameter(Mandatory=$true)]
      [string]$PublishedHash,
      [Parameter(Mandatory=$true)]
      [string]$Algorithm
      )
      try {
        $FileHash = (Get-FileHash -Algorithm $Algorithm $FileToHash -ErrorAction Stop).Hash
        if ($FileHash -eq $PublishedHash) {
          Write-Host "`nIt's a match! The hashes are equivalent." -ForegroundColor Green
        }
        else {
          Write-Host "`nSomething's off. Review the output below to see the difference in the hashes provided." -ForegroundColor Yellow
	  Compare-Object -ReferenceObject $FileHash -DifferenceObject $PublishedHash
        }
      }
      catch {
        Write-Error -Message "The specified file does not exist or the algorithm provided is incorrect."
      }
}

Export-ModuleMember -Function Verify-FileHash
