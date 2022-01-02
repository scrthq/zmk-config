
[CmdletBinding()]
Param(
    [parameter(Position=0)]
    [ValidateSet('Left','Right','Both')]
    [Alias('Half','s','h')]
    [string[]]
    $Side = @('Left')
)
$START = Get-Date
$GITHUB_WORKSPACE=(Get-Location).Path
try {
    if ($Side -in @('Left','Both')) {
        Write-Host -ForegroundColor Magenta "
---------------------------------------

BUILDING LEFT SIDE

---------------------------------------
"
        west build --pristine -s zmk/app -b corne-ish_zen_left -- -DZMK_CONFIG="${GITHUB_WORKSPACE}/config"
        Copy-Item build/zephyr/zmk.uf2 firmware/corneish_zen_left.uf2 -ErrorAction Stop
    }
    if ($Side -in @('Right','Both')) {
        Write-Host -ForegroundColor Magenta "
---------------------------------------

BUILDING RIGHT SIDE

---------------------------------------
"
        west build --pristine -s zmk/app -b corne-ish_zen_right -- -DZMK_CONFIG="${GITHUB_WORKSPACE}/config"
        Copy-Item build/zephyr/zmk.uf2 firmware/corneish_zen_right.uf2 -ErrorAction Stop
    }
    if (Test-Path '/mnt/e/Git/zen-mk/firmware') {
        Get-ChildItem ./firmware -Filter *.uf2 | Copy-Item -Destination '/mnt/e/Git/zen-mk/firmware' -Verbose -ErrorAction Stop
    }
}
catch {
    throw $_
}
finally {
    $END = Get-Date
    Write-Host -ForegroundColor Cyan "
------------------------------------------
Started : $START
Ended   : $END
Total   : $($END - $START)
------------------------------------------
"

}
