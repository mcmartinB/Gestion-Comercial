cd upx
del GComerSAT.old
ren GComerSAT.exe GComerSAT.old
cd ..
copy /Y GComerSAT.exe upx
cd upx
notepad GComerSAT.ver 
upx -9 GComerSAT.exe 
cd ..