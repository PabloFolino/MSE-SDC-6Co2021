# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
namespace eval ::optrace {
  variable script "/home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.runs/synth_1/hw_top_edu_bbt.tcl"
  variable category "vivado_synth"
}

# Try to connect to running dispatch if we haven't done so already.
# This code assumes that the Tcl interpreter is not using threads,
# since the ::dispatch::connected variable isn't mutex protected.
if {![info exists ::dispatch::connected]} {
  namespace eval ::dispatch {
    variable connected false
    if {[llength [array get env XILINX_CD_CONNECT_ID]] > 0} {
      set result "true"
      if {[catch {
        if {[lsearch -exact [package names] DispatchTcl] < 0} {
          set result [load librdi_cd_clienttcl[info sharedlibextension]] 
        }
        if {$result eq "false"} {
          puts "WARNING: Could not load dispatch client library"
        }
        set connect_id [ ::dispatch::init_client -mode EXISTING_SERVER ]
        if { $connect_id eq "" } {
          puts "WARNING: Could not initialize dispatch client"
        } else {
          puts "INFO: Dispatch client connection id - $connect_id"
          set connected true
        }
      } catch_res]} {
        puts "WARNING: failed to connect to dispatch server - $catch_res"
      }
    }
  }
}
if {$::dispatch::connected} {
  # Remove the dummy proc if it exists.
  if { [expr {[llength [info procs ::OPTRACE]] > 0}] } {
    rename ::OPTRACE ""
  }
  proc ::OPTRACE { task action {tags {} } } {
    ::vitis_log::op_trace "$task" $action -tags $tags -script $::optrace::script -category $::optrace::category
  }
  # dispatch is generic. We specifically want to attach logging.
  ::vitis_log::connect_client
} else {
  # Add dummy proc if it doesn't exist.
  if { [expr {[llength [info procs ::OPTRACE]] == 0}] } {
    proc ::OPTRACE {{arg1 \"\" } {arg2 \"\"} {arg3 \"\" } {arg4 \"\"} {arg5 \"\" } {arg6 \"\"}} {
        # Do nothing
    }
  }
}

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
OPTRACE "synth_1" START { ROLLUP_AUTO }
set_param chipscope.maxJobs 2
set_msg_config  -id {[BD 41-1306]}  -suppress 
set_msg_config  -id {[BD 41-1271]}  -suppress 
OPTRACE "Creating in-memory project" START { }
create_project -in_memory -part xc7a35ticsg324-1L

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.cache/wt [current_project]
set_property parent.project_path /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part_repo_paths {/home/pablo/.Xilinx/Vivado/2021.1/xhub/board_store/xilinx_board_store} [current_project]
set_property board_part digilentinc.com:arty-a7-35:part0:1.0 [current_project]
set_property ip_output_repo /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
OPTRACE "Creating in-memory project" END { }
OPTRACE "Adding files" START { }
read_vhdl -library xil_defaultlib {
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/channel/prng/adder_signed.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/demodulator/bandpass_filter/bandpass_filter.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/modulator/bask_mapper.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/channel/bb_channel.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/channel/filter/bb_channel_fir.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/demodulator/bb_demodulator.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/bb_modem.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/modulator/bb_modulator.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/demodulator/pll/cordic_pipelined.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/demodulator/dem_control_unit.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/lib/dual_port_ram.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/demodulator/bandpass_filter/hdlcoder_bandpass_filter.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/channel/filter/hdlcoder_channel_fir.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/demodulator/matched_filter/hdlcoder_matched_filter_fir.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/demodulator/pre_filter/hdlcoder_pre_filter.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/modulator/pulse_shaping/hdlcoder_pulse_shaping_fir.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/pkg_edu_bbt.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/demodulator/matched_filter/matched_filter_fir.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/modulator/mod_control_unit.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/demodulator/pll/nco.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/demodulator/pll/pll.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/demodulator/pre_filter/pre_filter.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/modulator/pulse_shaping/pulse_shaping_fir.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/channel/prng/random_gaussian_approx.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/channel/prng/random_uniform.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/lib/shift_reg.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/lib/fifo/sif_fifo.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/lib/uart/sif_uart.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/lib/fifo/simple_fifo.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/demodulator/symb_sync.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/top/top_edu_bbt.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/lib/uart/uart.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/src/modulator/zero_append.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/modem/hw/artyz7-10/edu_bbt/hw_top_edu_bbt.vhd
  /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/imports/system_wrapper.vhd
}
add_files /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/bd/system/system.bd
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_microblaze_0_0/system_microblaze_0_0.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_microblaze_0_0/system_microblaze_0_0_ooc_debug.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_microblaze_0_0/system_microblaze_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_dlmb_v10_0/system_dlmb_v10_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_ilmb_v10_0/system_ilmb_v10_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_dlmb_bram_if_cntlr_0/system_dlmb_bram_if_cntlr_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_ilmb_bram_if_cntlr_0/system_ilmb_bram_if_cntlr_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_lmb_bram_0/system_lmb_bram_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_mdm_1_0/system_mdm_1_0.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_mdm_1_0/system_mdm_1_0_ooc_trace.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_rst_clk_wiz_1_100M_0/system_rst_clk_wiz_1_100M_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_rst_clk_wiz_1_100M_0/system_rst_clk_wiz_1_100M_0.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_rst_clk_wiz_1_100M_0/system_rst_clk_wiz_1_100M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_uartlite_0_0/system_axi_uartlite_0_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_uartlite_0_0/system_axi_uartlite_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_uartlite_0_0/system_axi_uartlite_0_0.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_xbar_0/system_xbar_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_gpio_0_1/system_axi_gpio_0_1_board.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_gpio_0_1/system_axi_gpio_0_1_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_gpio_0_1/system_axi_gpio_0_1.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_gpio_1_0/system_axi_gpio_1_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_gpio_1_0/system_axi_gpio_1_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_gpio_1_0/system_axi_gpio_1_0.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_gpio_2_0/system_axi_gpio_2_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_gpio_2_0/system_axi_gpio_2_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_gpio_2_0/system_axi_gpio_2_0.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_gpio_3_0/system_axi_gpio_3_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_gpio_3_0/system_axi_gpio_3_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_gpio_3_0/system_axi_gpio_3_0.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_gpio_4_0/system_axi_gpio_4_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_gpio_4_0/system_axi_gpio_4_0_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_axi_gpio_4_0/system_axi_gpio_4_0.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/system_ooc.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/bd/system/ip/system_microblaze_0_0/data/mb_bootloop_le.elf]

read_ip -quiet /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/ip/ila_0/ila_0.xci
set_property used_in_synthesis false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/ip/ila_0/ila_v6_2/constraints/ila_impl.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/ip/ila_0/ila_v6_2/constraints/ila_impl.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/ip/ila_0/ila_v6_2/constraints/ila.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/ip/ila_0/ila_0_ooc.xdc]

read_ip -quiet /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/sources_1/ip/clk_wiz_0_1/clk_wiz_0.xci
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/ip/clk_wiz_0_1/clk_wiz_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/ip/clk_wiz_0_1/clk_wiz_0.xdc]
set_property used_in_implementation false [get_files -all /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.gen/sources_1/ip/clk_wiz_0_1/clk_wiz_0_ooc.xdc]

OPTRACE "Adding files" END { }
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/constrs_1/imports/constrs_1/imports/workspace2/arty_A7-35_TP_Final.xdc
set_property used_in_implementation false [get_files /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/TP_FINAL_Micro_ver8/TP_FINAL_Micro_ver8.srcs/constrs_1/imports/constrs_1/imports/workspace2/arty_A7-35_TP_Final.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

OPTRACE "synth_design" START { }
synth_design -top hw_top_edu_bbt -part xc7a35ticsg324-1L -directive AlternateRoutability -retiming
OPTRACE "synth_design" END { }
if { [get_msg_config -count -severity {CRITICAL WARNING}] > 0 } {
 send_msg_id runtcl-6 info "Synthesis results are not added to the cache due to CRITICAL_WARNING"
}


OPTRACE "write_checkpoint" START { CHECKPOINT }
# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef hw_top_edu_bbt.dcp
OPTRACE "write_checkpoint" END { }
OPTRACE "synth reports" START { REPORT }
create_report "synth_1_synth_report_utilization_0" "report_utilization -file hw_top_edu_bbt_utilization_synth.rpt -pb hw_top_edu_bbt_utilization_synth.pb"
OPTRACE "synth reports" END { }
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
OPTRACE "synth_1" END { }
