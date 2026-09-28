# Primary Plus Provider - tiny local static server (enables PWA install / service worker).
# Run:  powershell -ExecutionPolicy Bypass -File serve.ps1
# Then open the URL it prints and use the browser's Install / Add to Home Screen.
$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot; if (-not $root) { $root = (Get-Location).Path }
$port = 8080
$prefix = "http://localhost:$port/"
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($prefix)
try { $listener.Start() } catch { Write-Host "Could not bind $prefix - try another port or run as admin."; exit 1 }
$url = $prefix + "provider-mobile-app.html"
Write-Host "Serving $root"
Write-Host "Open: $url"
Write-Host "(Press Ctrl+C to stop)"
Start-Process $url
$mime = @{ '.html'='text/html; charset=utf-8'; '.js'='application/javascript'; '.png'='image/png';
           '.webmanifest'='application/manifest+json'; '.json'='application/json'; '.css'='text/css'; '.svg'='image/svg+xml' }
while ($listener.IsListening) {
  try {
    $ctx = $listener.GetContext()
    $rel = [System.Uri]::UnescapeDataString($ctx.Request.Url.LocalPath).TrimStart('/')
    if ([string]::IsNullOrEmpty($rel)) { $rel = 'provider-mobile-app.html' }
    $file = Join-Path $root $rel
    if ((Test-Path $file -PathType Leaf) -and ($file.StartsWith($root))) {
      $bytes = [System.IO.File]::ReadAllBytes($file)
      $ext = [System.IO.Path]::GetExtension($file).ToLower()
      if ($mime[$ext]) { $ctx.Response.ContentType = $mime[$ext] }
      $ctx.Response.Headers.Add('Service-Worker-Allowed','/')
      $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    } else { $ctx.Response.StatusCode = 404 }
    $ctx.Response.Close()
  } catch { }
}
