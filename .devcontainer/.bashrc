export LS_OPTIONS='-F --color=auto'
alias ls='ls $LS_OPTIONS'

if [[ ! -f ~/west_initialized.txt ]]; then
  west init -l config
  west update && west zephyr-export
  echo 'west_initialized' > ~/west_initialized.txt
fi

function build() {
  GITHUB_WORKSPACE=$(pwd)
  [[ -d firmware ]] || mkdir firmware
  cat << EOH
------------------

BUILDING LEFT SIDE

------------------
EOH
  west build --pristine -s zmk/app -b corne-ish_zen_left -- -DZMK_CONFIG="${GITHUB_WORKSPACE}/config" && \
  cp build/zephyr/zmk.uf2 firmware/corneish_zen_left.uf2
  cat << EOH
------------------

BUILDING RIGHT SIDE

------------------
EOH
  west build --pristine -s zmk/app -b corne-ish_zen_right -- -DZMK_CONFIG="${GITHUB_WORKSPACE}/config" && \
  cp build/zephyr/zmk.uf2 firmware/corneish_zen_right.uf2
}