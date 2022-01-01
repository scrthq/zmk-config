function build() {
  $START = Get-Date
  $GITHUB_WORKSPACE=(pwd).Path
  try {
      Write-Host -ForegroundColor Magenta "
------------------

BUILDING LEFT SIDE

------------------
"
      west build --pristine -s zmk/app -b corne-ish_zen_left -- -DZMK_CONFIG="${GITHUB_WORKSPACE}/config"
      Copy-Item build/zephyr/zmk.uf2 firmware/corneish_zen_left.uf2
      Write-Host -ForegroundColor Magenta "
------------------

BUILDING RIGHT SIDE

------------------
"
    west build --pristine -s zmk/app -b corne-ish_zen_right -- -DZMK_CONFIG="${GITHUB_WORKSPACE}/config"
  Copy-Item build/zephyr/zmk.uf2 firmware/corneish_zen_right.uf2
  sudo cp firmware/* /mnt/e/Git/zen-mk/firmware
  $END = Get-Date
  Write-Host -ForegroundColor Magenta "
---------------------
  Started : $START
  Ended   : $END
  Total   : $($END - $START)
---------------------"
    }
    catch {
        throw $_
    }
}

build
