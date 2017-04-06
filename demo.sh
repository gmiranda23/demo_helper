#!/bin/bash

. $(dirname ${BASH_SOURCE})/util.sh

cmdprompt="mydemo"

run "echo 'this is a really long command OMG this would be so awkward while everyone waits for me to complete this line successfully'"

desc "this runs real system commands with real output"
run "pwd"

desc "there is no timer... it waits for you to be ready"
if [ -x "$(command -v kitchen)" ]; then
  run "kitchen init"
else
	run "touch testfile"
fi

desc "i can insert comments if appropriate"
desc "that explain what i'm doing and why"
desc "maybe this is a video recording"
desc "this script allows me to run real cmds"
if [ -x "$(command -v kitchen)" ]; then
  run "kitchen list"
else
	run "ls -la testfile"
fi

desc "we can also get proper return codes"
desc "here's a command that works"
run "ls"
desc "i'm using \$? here after the echo command"
run "echo $?"
desc "here's one that doesn't"
run "wqoieqwoue"
run "echo $?"

run "say 'typing out long drawn out commands while everyone watches me and my typing go to hell is now a thing of the past!'"

desc "there are two basic usage commands..."
desc "'run \$1' runs the command you want'"
desc "'desc \$1' prints the comments you want'"
desc "a variable called \$cmdprompt sets your psuedo shell prompt"

run "echo thats all folks!"

if [ -x "$(command -v kitchen)" ]; then
	rm -rf .kitchen .kitchen.yml chefignore test/ .gitignore
else
	rm -rf testfile
fi
