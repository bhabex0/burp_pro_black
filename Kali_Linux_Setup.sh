#!/bin/bash

echo '
                                                                                                                                                             
BBBBBBBBBBBBBBBBB          444444444                      KKKKKKKKK    KKKKKKKDDDDDDDDDDDDD             000000000          000000000                         
B::::::::::::::::B        4::::::::4                      K:::::::K    K:::::KD::::::::::::DDD        00:::::::::00      00:::::::::00                       
B::::::BBBBBB:::::B      4:::::::::4                      K:::::::K    K:::::KD:::::::::::::::DD    00:::::::::::::00  00:::::::::::::00                     
BB:::::B     B:::::B    4::::44::::4                      K:::::::K   K::::::KDDD:::::DDDDD:::::D  0:::::::000:::::::00:::::::000:::::::0                    
  B::::B     B:::::B   4::::4 4::::4      ccccccccccccccccKK::::::K  K:::::KKK  D:::::D    D:::::D 0::::::0   0::::::00::::::0   0::::::0rrrrr   rrrrrrrrr   
  B::::B     B:::::B  4::::4  4::::4    cc:::::::::::::::c  K:::::K K:::::K     D:::::D     D:::::D0:::::0     0:::::00:::::0     0:::::0r::::rrr:::::::::r  
  B::::BBBBBB:::::B  4::::4   4::::4   c:::::::::::::::::c  K::::::K:::::K      D:::::D     D:::::D0:::::0     0:::::00:::::0     0:::::0r:::::::::::::::::r 
  B:::::::::::::BB  4::::444444::::444c:::::::cccccc:::::c  K:::::::::::K       D:::::D     D:::::D0:::::0 000 0:::::00:::::0 000 0:::::0rr::::::rrrrr::::::r
  B::::BBBBBB:::::B 4::::::::::::::::4c::::::c     ccccccc  K:::::::::::K       D:::::D     D:::::D0:::::0 000 0:::::00:::::0 000 0:::::0 r:::::r     r:::::r
  B::::B     B:::::B4444444444:::::444c:::::c               K::::::K:::::K      D:::::D     D:::::D0:::::0     0:::::00:::::0     0:::::0 r:::::r     rrrrrrr
  B::::B     B:::::B          4::::4  c:::::c               K:::::K K:::::K     D:::::D     D:::::D0:::::0     0:::::00:::::0     0:::::0 r:::::r            
  B::::B     B:::::B          4::::4  c::::::c     cccccccKK::::::K  K:::::KKK  D:::::D    D:::::D 0::::::0   0::::::00::::::0   0::::::0 r:::::r            
BB:::::BBBBBB::::::B          4::::4  c:::::::cccccc:::::cK:::::::K   K::::::KDDD:::::DDDDD:::::D  0:::::::000:::::::00:::::::000:::::::0 r:::::r            
B:::::::::::::::::B         44::::::44 c:::::::::::::::::cK:::::::K    K:::::KD:::::::::::::::DD    00:::::::::::::00  00:::::::::::::00  r:::::r            
B::::::::::::::::B          4::::::::4  cc:::::::::::::::cK:::::::K    K:::::KD::::::::::::DDD        00:::::::::00      00:::::::::00    r:::::r            
BBBBBBBBBBBBBBBBB           4444444444    ccccccccccccccccKKKKKKKKK    KKKKKKKDDDDDDDDDDDDD             000000000          000000000      rrrrrrr 
'

if stat /bin/burp >/dev/null 2>&1; then	
		# execute Keygenerator
		echo 'Starting Keygenerator'
		(java -jar New-loader.jar) &
		sleep 2s

		# Execute Burp Suite Professional with Keyloader
		echo 'Executing Burp Suite Professional with Keyloader'
		java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -javaagent:New-loader.jar -noverify -jar burpsuite_pro.jar &
else 
	if [[ $EUID -eq 0 ]]; then
		# Download Burp Suite Profesional Latet Version
		echo 'Downloading latest Burp Suite Professional'
		Link="https://portswigger-cdn.net/burp/releases/download?product=pro&version=&type=jar"
		wget "$Link" -O burpsuite_pro.jar --quiet --show-progress
		sleep 2

		# execute Keygenerator
		echo 'Starting Keygenerator'
		(java -jar New-loader.jar) &
		sleep 3s

		# Execute Burp Suite Professional with Keyloader
		echo 'Executing Burp Suite Professional with Keyloader'
		# echo "java "--add-opens=java.desktop/javax.swing=ALL-UNNAMED" "--add-opens=java.base/java.lang=ALL-UNNAMED" "--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED" "--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED" "--add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED" -javaagent:$(pwd)/New-loader.jar -noverify -jar $(pwd)/burpsuite_pro.jar &" > burp
		# chmod +x burp
		java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -javaagent:New-loader.jar -noverify -jar burpsuite_pro.jar &
		
		# Create Public Run File
		echo "cd $(pwd)" > burp
		echo "./Kali_Linux_Setup.sh" >> burp
		mv burp /bin/burp
		chmod +x /bin/burp
	else
		echo "Execute Command as Root User"
		exit
	fi
fi
