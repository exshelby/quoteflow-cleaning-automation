param(
    [string]$RepositoryRoot = (Split-Path -Parent $PSScriptRoot)
)

$patterns = @(
    '@gmail\.com',
    'https://[a-z0-9-]+\.app\.n8n\.cloud',
    'app[A-Za-z0-9]{14}',
    'tbl[A-Za-z0-9]{14}',
    'viw[A-Za-z0-9]{14}',
    '"credentials"\s*:',
    'client_secret',
    'access_token',
    'refresh_token'
)

$trackedFolders = @('workflows', 'demo-form', 'docs', 'airtable-import', 'README.md', 'SECURITY.md')
$failed = $false

foreach ($pattern in $patterns) {
    $matches = Get-ChildItem -Path ($trackedFolders | ForEach-Object { Join-Path $RepositoryRoot $_ }) -File -Recurse -ErrorAction SilentlyContinue |
        Where-Object { $_.Extension -in @('.json', '.html', '.md', '.csv', '.ps1') } |
        Select-String -Pattern $pattern -CaseSensitive:$false

    if ($matches) {
        $failed = $true
        Write-Error "Unsafe public-export match for pattern '$pattern':`n$($matches | Out-String)"
    }
}

if ($failed) {
    exit 1
}

Write-Host 'Public export validation passed.' -ForegroundColor Green

