# demo_helper
A simple shell utility to make demos way less awkward.

Create a script that contains all your demo commands.  Replay the demo commands--real time, running real commands, with real output--one by one by hitting 'enter' to proceed to the next step of your demo.

## Requirements
### Platforms
- OSX

### Packages
- tput
- pv

OSX has `tput` installed by default.  You'll still need `pv`.  I'd recommend installing `pv` via homebrew.

## Usage
The meat of everything happens in `util.sh`.  To run a demo using this helper, simply create a new script and source `util.sh`.  You can set the demo shell command prompt using the variable $cmdprompt.  You then have two commands available: `desc` prints out comments on the terminal session and `run` executes commands then it halts at a shell prompt.  To advance the demo, simply hit enter.

Note: this is not an interactive session and you cannot type in commands adhoc while the demo is running.

## Example

```#!/bin/bash

source util.sh
cmdprompt="fake prompt"

desc "this inserts a comment telling me what 'ls' does - it lists files"
run "ls"
```

Example usage can be seen by running the `demo.sh` script.

## Contributing
PR's welcomed.  This could be made to run on Linux platforms fairly easily.  I'm open to adding additional functionality.

## License & Authors
- Author:: George Miranda ([gmiranda@chef.io](mailto:gmiranda@chef.io))
- Based on work by the Kubernetes authors (kubernetes.io)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
