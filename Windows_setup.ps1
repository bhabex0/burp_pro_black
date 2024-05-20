# Name is Important
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
BBBBBBBBBBBBBBBBB           4444444444    ccccccccccccccccKKKKKKKKK    KKKKKKKDDDDDDDDDDDDD             000000000          000000000      rrrrrrr   '
echo "`n"
# Set Wget Progress to Silent, Becuase it slows down Downloading by +50x
echo "Setting Wget Progress to Silent, Becuase it slows down Downloading by +50x`n"
$ProgressPreference = 'SilentlyContinue'
 
# Check JDK-18 Availability or Download JDK-19
$jdk18 = Get-WmiObject -Class Win32_Product -filter "Vendor='Oracle Corporation'" |where Caption -clike "Java(TM) SE Development Kit 19*"
if (!($jdk18)){
    echo "`t`tDownnloading Java JDK-19 ....`n"
    wget "https://download.oracle.com/java/19/archive/jdk-19.0.2_windows-x64_bin.exe" -O jdk-19.exe    
    echo "`t`tJDK-19 Downloaded, lets start the Installation process`n"
    start -wait jdk-19.exe
    rm jdk-19.exe
}else{
    echo "Required JDK-19 is Installed`n"
    $jdk18
}
 
# Check JRE-8 Availability or Download JRE-8
$jre8 = Get-WmiObject -Class Win32_Product -filter "Vendor='Oracle Corporation'" |where Caption -clike "Java 8 Update *"
if (!($jre8)){
    echo "`t`tDownloading Java JRE ....`n"
    wget "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=246474_2dee051a5d0647d5be72a7c0abff270e" -O jre-8.exe
    echo "`n`t`tJRE-8 Downloaded, lets start the Installation process"
    start -wait jre-8.exe
    rm jre-8.exe
}else{
    echo "Required JRE-8 is Installed`n"
    $jre8
}
 
# Downloading Burp Suite Professional
if (Test-Path Burp-Suite-Pro.jar){
    echo "Burp Suite Professional JAR file is available.`n`t`tChecking its Integrity ....`n"
    if (((Get-Item Burp-Suite-Pro.jar).length/1MB) -lt 400 ){
        echo "`t`tFiles Seems to be corrupted`n`t`tDownloading Burp Suite Professional latest version ....`n"
        wget "https://portswigger.net/burp/releases/startdownload?product=pro&version=&type=Jar" -O "burpsuite_pro.jar"
        echo "Burp Suite Professional is Downloaded.`n"
    }else {echo "File Looks fine. Lets proceed for Execution`n"}
}else {
    echo "`t`tDownloading Burp Suite Professional latest version ....`n"
    wget "https://portswigger-cdn.net/burp/releases/download?product=pro&version=&type=jar" -O "burpsuite_pro.jar"
    echo "Burp Suite Professional is Downloaded.`n"
}
 
# Creating Burp.bat file with command for execution
if (Test-Path burp.bat) {rm burp.bat} 
$path = "java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -javaagent:`"$pwd\New-loader.jar`" -noverify -jar `"$pwd\burpsuite_pro.jar`""
$path | add-content -path Burp.bat
echo "Burp.bat file is created`n"
 
 
# Creating Burp-Suite-Pro.vbs File for background execution
if (Test-Path Burp-Suite-Pro.vbs) {
   Remove-Item Burp-Suite-Pro.vbs}
echo "Set WshShell = CreateObject(`"WScript.Shell`")" > Burp-Suite-Pro.vbs
add-content Burp-Suite-Pro.vbs "WshShell.Run chr(34) & `"$pwd\Burp.bat`" & Chr(34), 0"
add-content Burp-Suite-Pro.vbs "Set WshShell = Nothing"
echo "Burp-Suite-Pro.vbs file is created.`n"
 
# Remove Additional files
rm Kali_Linux_Setup.sh
del -Recurse -Force .\.github\
 
# Lets Activate Burp Suite Professional with keygenerator and Keyloader
echo "Reloading Environment Variables ....`n"
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
echo "Executing Loader ....`n"
start-process java.exe -argumentlist "-jar New-loader.jar"
echo "Starting Burp Suite Professional`n"
java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -javaagent:New-loader.jar -noverify -jar burpsuite_pro.jar 