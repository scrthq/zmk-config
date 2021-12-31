export LS_OPTIONS='-F --color=auto'
alias ls='ls $LS_OPTIONS'

export PATH="$PATH:/root/.local/bin"
export PATH=~/.local/bin:"$PATH"

function update() {
  west update && west zephyr-export
}

function cp_firmware() {
  if [[ `pwd` == "/home/luke/CloudCity/zmk-config" ]]; then
    [[ -d /mnt/zmk ]] || mkdir /mnt/zmk
    [[ -d /mnt/zmk/zen-mk ]] || sudo mount -t cifs -o username=nate //192.168.86.240/e/Git /mnt/zmk
    sudo cp firmware/* /mnt/zmk/zen-mk/firmware
  fi
}

function build() {
  set -E
  START=$(date)
  GITHUB_WORKSPACE=$(pwd)
  [[ -d firmware ]] || mkdir firmware
  [[ -d build ]] && rm -rf build
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
  cp_firmware
  END=$(date)
  echo "Started : ${START}"
  echo "Ended   : ${END}"
}

if [[ ! -f ~/west_initialized.txt ]]; then
  west init -l config
  update
  echo 'west_initialized' > ~/west_initialized.txt
fi
