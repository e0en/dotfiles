grep export $HOME/dotfiles/osx-env.sh | while IFS=' =' read ignoreexport envvar ignorevalue; do
  echo $envvar
  launchctl setenv ${envvar} ${!envvar}
done
