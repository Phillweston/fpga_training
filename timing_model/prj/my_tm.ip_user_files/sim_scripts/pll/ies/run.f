-makelib ies_lib/xil_defaultlib -sv \
  "D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../my_tm.srcs/sources_1/ip/pll/pll_clk_wiz.v" \
  "../../../../my_tm.srcs/sources_1/ip/pll/pll.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

