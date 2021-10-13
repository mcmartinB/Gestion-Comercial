cd upx
del GComerBAG.old
ren GComerBAG.exe GComerBAG.old
del GComerSAT.old
ren GComerSAT.exe GComerSAT.old
cd ..
copy /Y GComerBAG.exe upx
copy /Y GComerSAT.exe upx
cd upx
notepad GComerBAG.ver 
notepad GComerSAT.ver 
upx -9 GComerBAG.exe 
upx -9 GComerSAT.exe 
cd ..
