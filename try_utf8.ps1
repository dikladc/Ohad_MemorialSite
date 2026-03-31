$text = [System.IO.File]::ReadAllText('C:\Users\dikladc\Downloads\OhadSite\memories_text.htm', [System.Text.Encoding]::UTF8)
$utf8 = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText('mem_as_utf8.htm', $text, $utf8)
Write-Host "Copied as UTF-8"
