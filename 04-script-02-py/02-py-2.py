#!/usr/bin/env python3

import os
git_dir = "."
bash_command = ["cd "+git_dir, "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(os.path.abspath(os.getcwd()))
        print(prepare_result)
