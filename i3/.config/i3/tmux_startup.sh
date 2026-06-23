#!/bin/bash

tmux new-session -d -s startup-session '~/tmux-resurrect/scripts/restore.sh'
