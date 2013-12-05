new_project \
    -name {controller} \
    -location {N:\373\controller\designer\impl1\controller_fp} \
    -mode {single}
set_device_type -type {A2F200M3F}
set_device_package -package {484 FBGA}
update_programming_file \
    -feature {prog_fpga:on} \
    -fdb_source {fdb} \
    -fdb_file {N:\373\controller\designer\impl1\controller.fdb} \
    -feature {prog_from:off} \
    -feature {prog_nvm:on} \
    -efm_content {location:0;source:efc} \
    -efm_block {location:0;config_file:{N:\373\controller\component\work\controller_MSS\MSS_ENVM_0\MSS_ENVM_0.efc}} \
    -pdb_file {N:\373\controller\designer\impl1\controller_fp\controller.pdb}
set_programming_action -action {PROGRAM}
catch {run_selected_actions} return_val
save_project
close_project
if { $return_val != 0 } {
  exit 1 }
