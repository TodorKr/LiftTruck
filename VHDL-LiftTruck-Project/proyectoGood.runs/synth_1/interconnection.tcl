# 
# Synthesis run script generated by Vivado
# 

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
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a35ticpg236-1L

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/user1/Desktop/proyectoGood/proyectoGood.cache/wt [current_project]
set_property parent.project_path C:/Users/user1/Desktop/proyectoGood/proyectoGood.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo c:/Users/user1/Desktop/proyectoGood/proyectoGood.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/user1/Desktop/proyectoGood/proyectoGood.srcs/sources_1/imports/Sensor/Divisor_Frecuencia.vhd
  C:/Users/user1/Desktop/proyectoGood/proyectoGood.srcs/sources_1/imports/Desktop/PMW.vhd
  C:/Users/user1/Desktop/proyectoGood/proyectoGood.srcs/sources_1/imports/Desktop/Sensor_Ultrasonido.vhd
  C:/Users/user1/Desktop/proyectoGood/proyectoGood.srcs/sources_1/imports/Desktop/Top.vhd
  C:/Users/user1/Desktop/proyectoGood/proyectoGood.srcs/sources_1/imports/Desktop/dataController.vhd
  C:/Users/user1/Desktop/proyectoGood/proyectoGood.srcs/sources_1/imports/Desktop/motorDireccion.vhdl
  C:/Users/user1/Desktop/proyectoGood/proyectoGood.srcs/sources_1/imports/Desktop/motorPala.vhdl
  C:/Users/user1/Desktop/proyectoGood/proyectoGood.srcs/sources_1/imports/Desktop/motorVelocidad.vhdl
  C:/Users/user1/Desktop/proyectoGood/proyectoGood.srcs/sources_1/imports/Desktop/shovFrecDiv.vhdl
  C:/Users/user1/Desktop/proyectoGood/proyectoGood.srcs/sources_1/imports/Desktop/uart.vhd
  C:/Users/user1/Desktop/proyectoGood/proyectoGood.srcs/sources_1/imports/Desktop/puertoUart.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/user1/Desktop/proyectoGood/proyectoGood.srcs/constrs_1/imports/Desktop/Basys3_Master.xdc
set_property used_in_implementation false [get_files C:/Users/user1/Desktop/proyectoGood/proyectoGood.srcs/constrs_1/imports/Desktop/Basys3_Master.xdc]


synth_design -top interconnection -part xc7a35ticpg236-1L


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef interconnection.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file interconnection_utilization_synth.rpt -pb interconnection_utilization_synth.pb"
