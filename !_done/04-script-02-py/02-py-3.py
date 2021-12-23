#!/usr/bin/env python3
import argparse
import os
parser = argparse.ArgumentParser()
parser.add_argument("--path", "-p", help="set git directory location")
args = parser.parse_args()
if args.path:
    if os.path.isdir(args.path):
        print("git dir is %s" % args.path)
        bash_command = ["cd " + args.path, "git status"]
        result_os = os.popen(' && '.join(bash_command)).read()
        is_change = False
        for result in result_os.split('\n'):
            if result.find('modified') != -1:
                prepare_result = result.replace('\tmodified:   ', '')
                print(os.path.abspath(os.getcwd()))
                print(prepare_result)
    else:
        print("Directory unavailable, Bye!")
        exit(0)


