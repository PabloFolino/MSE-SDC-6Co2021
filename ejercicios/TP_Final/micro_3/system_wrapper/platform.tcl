# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/micro_3/system_wrapper/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/micro_3/system_wrapper/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {system_wrapper}\
-hw {/home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/micro_3/system_wrapper.xsa}\
-out {/home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace2/micro_3}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {system_wrapper}
platform generate -quick
platform generate
