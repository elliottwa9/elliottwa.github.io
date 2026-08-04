<#
.SYNOPSIS
  Generates compressed, web-sized copies of photos for the /photos gallery.

.DESCRIPTION
  Mirrors assets/photos/** into assets/photos-web/** (same relative folder
  structure, filenames normalized to .jpg), resizing anything wider/taller
  than -MaxLongEdge and re-encoding at -Quality. Skips files that already
  have an up-to-date web copy unless -Force is passed.

.PARAMETER Force
  Regenerate every web copy, even if one already exists and is newer than
  the source file.

.PARAMETER MaxLongEdge
  Maximum long-edge dimension, in pixels, for generated web copies.

.PARAMETER Quality
  JPEG quality (1-100) for generated web copies.

.EXAMPLE
  ./scripts/generate-web-photos.ps1

.EXAMPLE
  ./scripts/generate-web-photos.ps1 -Force -Quality 80
#>
param(
  [switch]$Force,
  [int]$MaxLongEdge = 1920,
  [int]$Quality = 85
)

Add-Type -AssemblyName System.Drawing

$repoRoot = Split-Path -Parent $PSScriptRoot
$srcRoot = Join-Path $repoRoot "assets\photos"
$destRoot = Join-Path $repoRoot "assets\photos-web"
$extensions = @(".jpg", ".jpeg", ".png", ".gif", ".webp")

if (-not (Test-Path $srcRoot)) {
  Write-Error "Source folder not found: $srcRoot"
  exit 1
}

$jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
$encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [int64]$Quality)

$sourceFiles = Get-ChildItem -Path $srcRoot -Recurse -File | Where-Object { $extensions -contains $_.Extension.ToLower() }

$generated = 0
$skipped = 0

foreach ($src in $sourceFiles) {
  $relPath = $src.FullName.Substring($srcRoot.Length).TrimStart('\')
  $relJpg = [System.IO.Path]::ChangeExtension($relPath, ".jpg")
  $destPath = Join-Path $destRoot $relJpg

  if (-not $Force -and (Test-Path $destPath) -and (Get-Item $destPath).LastWriteTime -ge $src.LastWriteTime) {
    $skipped++
    continue
  }

  $destDir = Split-Path -Parent $destPath
  if (-not (Test-Path $destDir)) {
    New-Item -ItemType Directory -Path $destDir -Force | Out-Null
  }

  $bytes = [System.IO.File]::ReadAllBytes($src.FullName)
  $stream = New-Object System.IO.MemoryStream(, $bytes)
  $img = [System.Drawing.Image]::FromStream($stream)

  if ($img.Width -gt $MaxLongEdge -or $img.Height -gt $MaxLongEdge) {
    if ($img.Width -ge $img.Height) {
      $newW = $MaxLongEdge
      $newH = [int]([math]::Round($img.Height * $MaxLongEdge / $img.Width))
    } else {
      $newH = $MaxLongEdge
      $newW = [int]([math]::Round($img.Width * $MaxLongEdge / $img.Height))
    }
  } else {
    $newW = $img.Width
    $newH = $img.Height
  }

  $origW = $img.Width
  $origH = $img.Height

  $bmp = New-Object System.Drawing.Bitmap($newW, $newH)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
  $g.DrawImage($img, 0, 0, $newW, $newH)

  $bmp.Save($destPath, $jpegCodec, $encParams)

  $g.Dispose()
  $bmp.Dispose()
  $img.Dispose()
  $stream.Dispose()

  Write-Output "Generated: $relJpg (${origW}x${origH} -> ${newW}x${newH})"
  $generated++
}

Write-Output ""
Write-Output "Done. Generated $generated, skipped $skipped (already up to date)."
