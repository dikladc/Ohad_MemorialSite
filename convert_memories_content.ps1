# Convert memories_text.htm from windows-1255 to UTF-8

$enc1255 = [System.Text.Encoding]::GetEncoding(1255)
$bytes = [System.IO.File]::ReadAllBytes("memories_text.htm")
$text = $enc1255.GetString($bytes)

$utf8 = [System.Text.UTF8Encoding]::new($true)
[System.IO.File]::WriteAllText("memories_text_utf8.htm", $text, $utf8)

Write-Host "Converted memories_text.htm to UTF-8"
