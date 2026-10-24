hl.monitor({
	output = "DP-3",
	mode = "2560x1440@165.08",
})

-- Turn Monitor Off
hl.bind("SUPER + KP_Divide", hl.dsp.exec_cmd("sleep 1; noctalia msg dpms-off"))
