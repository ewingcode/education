sc delete sofficeservice
sc create sofficeservice binpath= "C:\Program Files\OpenOffice.org 3\program\soffice -headless -accept=\"socket,host=127.0.0.1,port=8100;urp;\" -nofirststartwizard" displayname= "sofficeservice" depend= Tcpip
sc config sofficeservice start= auto
sc start sofficeservice

 
