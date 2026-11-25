# HVLisp updater: download the main branch from GitHub and copy it over Dest.
# Keep this file ASCII only.
# SPDX-License-Identifier: GPL-3.0-or-later
param(
    [string]$Repo,
    [string]$Dest
)

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$log = Join-Path $env:TEMP 'hvlisp-update.log'
$zip = $null
$work = Join-Path $env:TEMP 'hvlisp-update'
$code = 0

try {
    if (Test-Path -LiteralPath $log) { Remove-Item -LiteralPath $log -Force }
    # No Mandatory parameters: a prompt in a hidden window would hang AutoCAD.
    if (-not $Repo -or -not $Dest) { throw 'Missing -Repo or -Dest.' }

    [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

    $stamp = Get-Random
    $url = "https://github.com/$Repo/archive/refs/heads/main.zip?t=$stamp"
    $zip = Join-Path $env:TEMP "hvlisp-$stamp.zip"
    Invoke-WebRequest -Uri $url -OutFile $zip -UseBasicParsing -TimeoutSec 60

    if (Test-Path -LiteralPath $work) { Remove-Item -LiteralPath $work -Recurse -Force }
    Expand-Archive -LiteralPath $zip -DestinationPath $work -Force

    $folders = @(Get-ChildItem -LiteralPath $work -Directory)
    if ($folders.Count -ne 1) { throw "Expected 1 folder in the ZIP, found $($folders.Count)." }
    $source = $folders[0].FullName
    # Refuse to overwrite Dest with something that is not this tool set.
    if (-not (Test-Path -LiteralPath (Join-Path $source 'src/act-load.lsp'))) {
        throw 'The ZIP does not contain src/act-load.lsp.'
    }

    if (-not (Test-Path -LiteralPath $Dest)) { New-Item -ItemType Directory -Path $Dest -Force | Out-Null }
    Get-ChildItem -LiteralPath $source -Force | ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination $Dest -Recurse -Force
    }
}
catch {
    $code = 1
    $message = $_.Exception.Message
    Write-Output "Update failed: $message"
    try { Set-Content -LiteralPath $log -Value $message -Encoding ASCII } catch { }
}
finally {
    if ($zip -and (Test-Path -LiteralPath $zip)) { Remove-Item -LiteralPath $zip -Force -ErrorAction SilentlyContinue }
    if (Test-Path -LiteralPath $work) { Remove-Item -LiteralPath $work -Recurse -Force -ErrorAction SilentlyContinue }
}

exit $code
