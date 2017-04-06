#!/bin/bash
# Copyright 2017 George Miranda <gmiranda@chef.io>
# Based on work by the Kubernetes authors kubernetes.io
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

readonly   reset=$(tput sgr0)
readonly   green=$(tput bold; tput setaf 2)
readonly  yellow=$(tput bold; tput setaf 3)
readonly    cyan=$(tput bold; tput setaf 6)

# not used, here for reference
readonly   black="$(tput setaf 0)"
readonly     red="$(tput setaf 1)"
readonly    blue="$(tput setaf 4)"
readonly  magenta=$(tput setaf 5)
readonly   white="$(tput setaf 7)"
readonly    grey="$(tput setaf 8)"
readonly lime_yellow=$(tput setaf 190)
readonly powder_blue=$(tput setaf 153)
#---#

function desc() {
  maybe_first_prompt
  echo "$cyan# $@$reset"
  prompt
}

function prompt() {
  if [ -z "$cmdprompt" ]; then
    echo -n "$yellow\$ $reset"
  else
    echo -n "$yellow$cmdprompt $ $reset"
  fi
}

started=""
function maybe_first_prompt() {
  if [ -z "$started" ]; then
    prompt
    started=true
  fi
}

# After a `run` this variable will hold the stdout of the command that was run.
# If the command was interactive, this will likely be garbage.
DEMO_RUN_STDOUT=""

function run() {
  maybe_first_prompt
  rate=25
  timeout=1

  echo "$green$1$reset" | pv -qL $rate
  OFILE="$(mktemp -t $(basename $0).XXXXXX)"
  script -q -F "$OFILE" $1
  r=$?

  read -d '' -t "${timeout}" -n 10000 # clear stdin
  prompt

  if [ -z "$DEMO_AUTO_RUN" ]; then
      read -s
  fi
  DEMO_RUN_STDOUT="$(tail -n +2 $OFILE | sed 's/\r//g')"

  return $r
}

trap "echo" EXIT
