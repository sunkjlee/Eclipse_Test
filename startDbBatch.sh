CLASS_PATH=.
CLASS_PATH=$CLASS_PATH:/root/Gnew/dbBatch/lib/mybatis-3.5.3.jar
CLASS_PATH=$CLASS_PATH:/root/Gnew/dbBatch/lib/postgresql-42.2.18.jar
CLASS_PATH=$CLASS_PATH:/root/Gnew/dbBatch/bin
export CLASS_PATH
echo $CLASS_PATH
#java -Xms1024m -Xmx1024m -DBatchMain -cp $CLASS_PATH com.gnew.bat.controller.BatchMain BatchMain /root/Gnew/dbBatch/conf/conf.properties

java -DBatchMain -cp $CLASS_PATH com.gnew.bat.controller.BatchMain BatchMain /root/Gnew/dbBatch/conf/conf.properties
