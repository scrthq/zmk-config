export LS_OPTIONS='-F --color=auto'
alias ls='ls $LS_OPTIONS'

export PATH="$PATH:/root/.local/bin"
export PATH=~/.local/bin:"$PATH"

function update() {
  west update && west zephyr-export
}

function cp_firmware() {
  if [[ `pwd` == "/home/luke/CloudCity/zmk-config" ]]; then
    [[ -d /mnt/e ]] || mkdir /mnt/e
    [[ -d /mnt/e/Git/zen-mk ]] || sudo mount -t cifs -o username=nate,uid=1000,gid=1000 //192.168.86.240/e /mnt/e
    sudo cp firmware/* /mnt/e/Git/zen-mk/firmware
  fi
}

function build() {
  set -E
  START=$(date)
  GITHUB_WORKSPACE=$(pwd)
  [[ -d firmware ]] || mkdir firmware
  # [[ -d build ]] && rm -rf build
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
  echo "---------------------"
  echo "Started : ${START}"
  echo "Ended   : ${END}"
  echo "---------------------"
}

if [[ ! -f ~/west_initialized.txt ]]; then
  west init -l config
  update
  echo 'west_initialized' > ~/west_initialized.txt
fi
