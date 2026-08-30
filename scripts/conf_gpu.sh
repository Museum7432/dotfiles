#!/bin/sh
# for limiting the clock speed of the amd gpu
GPU=/sys/bus/pci/devices/0000:64:00.0
echo manual > "$GPU/power_dpm_force_performance_level"
echo "s 1 2300" > "$GPU/pp_od_clk_voltage"
echo "c" > "$GPU/pp_od_clk_voltage"
