$folder = "C:\Users\sudha\Downloads\Genecoverage"
$output = Join-Path $folder "index.html"

$files = Get-ChildItem -Path $folder -Filter "*.html" |
    Where-Object { $_.Name -ne "index.html" } |
    Sort-Object Name

$html = @"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Gene Coverage Reports - Index</title>

<style>
body {
    font-family: Arial, Helvetica, sans-serif;
    background: #f4f6f8;
    margin: 0;
    padding: 30px;
}

.container {
    max-width: 1200px;
    margin: auto;
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

h1 {
    margin-top: 0;
    color: #222;
}

.info {
    color: #666;
    margin-bottom: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
}

th {
    background: #333;
    color: white;
    padding: 12px;
    text-align: left;
}

td {
    padding: 11px;
    border-bottom: 1px solid #ddd;
}

tr:hover {
    background: #f1f1f1;
}

a {
    color: #0066cc;
    text-decoration: none;
    font-weight: 500;
}

a:hover {
    text-decoration: underline;
}
</style>

</head>

<body>

<div class="container">

<h1>Gene Coverage Reports</h1>

<div class="info">
Total coverage reports: $($files.Count)
</div>

<table>

<thead>
<tr>
    <th>S.No</th>
    <th>File Name</th>
    <th>Report</th>
</tr>
</thead>

<tbody>
"@

$i = 1

foreach ($file in $files) {

    $fileName = $file.Name

    $html += @"
<tr>
    <td>$i</td>
    <td>$fileName</td>
    <td>
        <a href="$fileName" target="_blank">
            Open Report
        </a>
    </td>
</tr>
"@

    $i++
}

$html += @"

</tbody>

</table>

</div>

</body>
</html>
"@

Set-Content -Path $output -Value $html -Encoding UTF8

Write-Host ""
Write-Host "=============================================="
Write-Host "Index created successfully!"
Write-Host "=============================================="
Write-Host $output
Write-Host "Total reports: $($files.Count)"