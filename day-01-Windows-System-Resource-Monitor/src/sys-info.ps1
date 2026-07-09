$os =  Get-CimInstance -ClassName Win32_OperatingSystem
$cs = Get-CimInstance -ClassName Win32_ComputerSystem
$ld = Get-CimInstance -ClassName Win32_LogicalDisk

Write-Host "Hostname: $($cs.Name)"

Write-Host "Operating System : $($os.Caption)"

$bt = $os.LastBootUpTime

$Uptime = (Get-date) - $bt
Write-Host "System is Up for $($Uptime.Days) days $($Uptime.Hours) hours $($Uptime.Minutes) minutes"

#$cs |member

function Format-to-GB{
    param($size)

    $gb = [math]::Floor($size/ 1MB)
    $mb = [math]::Floor(($size % 1MB) / 1KB)
    $kb = $size % 1KB

    return [PSCustomObject]@{
        GB = $gb
        MB = $mb
        KB = $kb
    }
}



$totalMemory = $os.TotalVisibleMemorySize
$result = Format-to-GB $totalMemory
Write-Host "Total Memory : $($result.GB) GB $($result.MB) MB $($result.KB) KB"

$freeMemory = $os.FreePhysicalMemory
$result = Format-to-GB $freeMemory
Write-Host "Free Memory : $($result.GB) GB $($result.MB) MB $($result.KB) KB"

$usage = (($totalMemory - $freeMemory)/ $totalMemory ) *100
Write-Host ("Memory Usage: {0:N2}%" -f $usage)


$drive = Get-CimInstance -ClassName Win32_LogicalDisk

for($i=0 ; $i -lt $drive.Count; $i++){

   $id = $drive[$i].DeviceID

   $s = $drive[$i].Size
   $fs = $drive[$i].FreeSpace
   $dsk_usage = (($s-$fs)/$s) * 100

   Write-Host( "$id Total Space: {0:N2}GB  Free-Space: {1:N2}  Disk Usage: {2:N2} %" -f ($s/1GB), ($fs/1GB), $dsk_usage)

  
}

$cpu_usage = (Get-CimInstance -ClassName Win32_PerfFormattedData_PerfOS_Processor | Where-Object Name -EQ "_Total").PercentProcessorTime
Write-Host "CPU Usage : $($cpu_usage)%"
