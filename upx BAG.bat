cd upx
del GComerBAG.old
ren GComerBAG.exe GComerBAG.old
cd ..
copy /Y GComerBAG.exe upx
cd upx
notepad GComerBAG.ver 
upx -9 GComerBAG.exe 
cd ..