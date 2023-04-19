
function chpwd() {
  echo $PWD > "$HOME/.lastdir"
}

if [ -f ~/.lastdir ]; then
  cd $(cat "$HOME/.lastdir")
fi
