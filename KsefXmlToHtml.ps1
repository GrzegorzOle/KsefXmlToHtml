Add-Type -AssemblyName System.Windows.Forms

$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.InitialDirectory = 'F:\xsef'
$dialog.Filter = 'Pliki XML (*.xml)|*.xml|Wszystkie pliki (*.*)|*.*'

if ($dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
    $xml = $dialog.FileName
}


$xsl = Join-Path $PSScriptRoot 'kseffaktura_fa(3).xsl'
$out = Join-Path $PSScriptRoot 'faktura.html'
$xmlNameNoExt = [System.IO.Path]::GetFileNameWithoutExtension($xml)
$out = Join-Path $PSScriptRoot ($xmlNameNoExt + '.html')


# tylko to jest potrzebne
Add-Type -AssemblyName System.Xml

$xslt = New-Object System.Xml.Xsl.XslCompiledTransform
$xslt.Load($xsl)

$settings = $xslt.OutputSettings.Clone()
$settings.Indent = $true
$settings.Encoding = [System.Text.UTF8Encoding]::new($false)

$reader = [System.Xml.XmlReader]::Create($xml)
$writer = [System.Xml.XmlWriter]::Create($out, $settings)

$xslt.Transform($reader, $writer)

$writer.Close()
$reader.Close()

Write-Host "Gotowe: $out"
