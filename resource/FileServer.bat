cd D:\Program Files (x86)\OpenOffice 4\program
d:
soffice -headless -accept="socket,host=127.0.0.1,port=8100;urp;" -nofirststartwizard
pause

sc create sofficeservice binpath= "D:\Program Files (x86)\OpenOffice 4\program\soffice -headless -accept=\"socket,host=127.0.0.1,port=8100;urp;\" -nofirststartwizard" displayname= "sofficeservice" depend= Tcpip

 