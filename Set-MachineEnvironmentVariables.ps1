[CmdletBinding(SupportsShouldProcess=$true)]
param(
    [Parameter(Mandatory = $true)]
    [string] $MappingString,

    [Parameter(Mandatory = $false)]
    [string] $KeySeperator = ";",

    [Parameter(Mandatory = $false)]
    [string] $ValueSeperator = "="
)

$pairs = $MappingString.Split($KeySeperator);
foreach ($kvp in $pairs) {
    $vals = $kvp.Split($ValueSeperator);

    if($vals.Count -ne 2) {
        throw "Unable to parse sub-value '$kvp'";
    } else {
        $key = $vals[0];
        $value = $vals[1];

        if($PSCmdlet.ShouldProcess("'$key' = '$value'", "Set Environment Variable")) {
            $val = New-Item env:$key -Value $value -Force
            [Environment]::SetEnvironmentVariable($key, $value, "Machine")            
        }
    }
}