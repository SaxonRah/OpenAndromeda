
EVR TOOL SOFTWARE (VFK1162B)
                1998.9.4 (Fri)

1. General

   EVR TOOL SOFTWARE runs by command "CAM_TOOL" at DOS prompt on a PC.
   Then the communication software "BPCEVR19.HEX" is sent to the EVR Interface
   box (VFKW1000AA). User can be seen this sending by horizontal bar graph
   (0 to 100 %). 
   This BPCEVR19.HEX is an assembler program to exchange the RS-232C and camera
   recorder serial communication.
   The communication protocol is triggerd by VD pulse (frame pulse) from a 
   camera recorder.
   The serial communication timing is slightly different at each camera
   recorder model from the rising edge of VD pusle. Because the VD pule width 
   is various at each model. The communication timing from the falling edge of
   VD pulse is same (0.5 msec), so this software changed the VD tirgger from 
   rising to falling edge.

2. History

   This disk includes the following BPCEVR19.HEX file.
   The extension is named 700, 800, 900 and when they are used, the extension 
   name must be changed to HEX.

   (1) BPCEVR19.700 --- BPCEVR19.HEX file for AJ-D700
                        This program works only for AJ-D700.
                        Communication timiming is same with AG-DP800.

   (2) BPCEVR19.800 --- BPCEVR19.HEX file for AJ-D800 and AJ-D700.
                        This program works for AJ-D700 and AJ-D800.
                        Communication timing is adjusted for AJ-D800 and 
                        AJ-D700.

   (3) BPCEVR19.900 --- BPCEVR19.HEX file for AJ-D900, AJ-D800, and AJ-D700.
                        This program works for AJ-D900, AJ-D800, and AJ-D700.
                        Communication timing trigger is changed from rising 
                        edge to falling edge, then automatically follow the 
                        above model's communication timing.



