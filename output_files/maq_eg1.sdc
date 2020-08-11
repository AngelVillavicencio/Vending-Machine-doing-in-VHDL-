set_time_format-unit ns -decimal_places 3
create_clock -name {clock_sys}-period 10.000 -waveform { 0.000 5.000 } [get_ports {clock_50}] 
derive_clock_uncertainty 
set_input_delay -clock {clock_sys} 2.0 ns [get_ports {en}]
set_false_path -from [get_ports {reset_n}] 

