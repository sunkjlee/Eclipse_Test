CLASS_PATH=.
CLASS_PATH=$CLASS_PATH:/root/Gnew/decryptor/lib/postgresql-42.2.18.jar
CLASS_PATH=$CLASS_PATH:/root/Gnew/decryptor/bin
CLASS_PATH=$CLASS_PATH:/root/Gnew/decryptor/lib/decpBat.jar
export CLASS_PATH
echo $CLASS_PATH

java -DDecryptFileBatch -cp $CLASS_PATH com.gnew.bat.main.DecryptFileBatch DecryptFileBatch /root/Gnew/decryptor/conf/conf.properties
