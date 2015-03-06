@echo off 
echo %~dp1%~nx1
echo %~dp2%~nx2 
cd D:\Program Files\SWFTools
d: 
pdf2swf.exe %~dp1%~nx1 -o %~dp2%~nx2
swfcombine rfxview.swf  viewport=%~dp2%~nx2 -o %~dp2%~nx2
 
