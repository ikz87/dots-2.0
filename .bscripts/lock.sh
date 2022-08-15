#!/usr/bin/env bash

pkill -SIGUSR1 dunst # pause 
mantablockscreen -sc        
pkill -SIGUSR2 dunst # resume 
