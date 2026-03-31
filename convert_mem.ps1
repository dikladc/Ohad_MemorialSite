$enc = [System.Text.Encoding]::GetEncoding(1255)
$bytes = [System.IO.File]::ReadAllBytes('C:\Users\dikladc\Downloads\OhadSite\memories_text.htm')
$text = $enc.GetString($bytes)
$utf8 = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText('mem_fixed.htm', $text, $utf8)
Write-Host "Done"
