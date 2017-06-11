## Hive Setup
* Before that, we need to configure and start `mapred`
  * `$HADOOP_PREFIX/sbin/start-yarn.sh`
  * test:
    * `hadoop fs -mkdir /temp`
    * `hadoop fs -put /vagrant/shared/hadoop/README.txt /temp/`
    * `hadoop jar /vagrant/shared/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.3.jar wordcount /temp/README.txt /temp/README-wordcount`
    * `hadoop fs -text /temp/README-wordcount/*`
  * check: http://192.168.100.100:8088

* Download: http://www.apache.org/dyn/closer.cgi/hive/. As the time of writing, I chose ver `2.1.1`
* Guide: https://cwiki.apache.org/confluence/display/Hive/GettingStarted

* Configure Hive (you can do it in host machine)
  * extract Hive in synced folder `shared` and rename it `hive`
  * hive's logs are in `local /tmp` folder, we will leave where it is as this is only a test env

* Initialize Hive (in virtual machine)
  * `vagrant ssh master`
  * `echo export HIVE_HOME=/vagrant/shared/hive >> ~/.bashrc`
  * `echo export PATH="\$HIVE_HOME/bin:\$PATH" >> ~/.bashrc`
  * `source ~/.bashrc`
  * `hadoop fs -mkdir /tmp`
  * `hadoop fs -mkdir -p /user/hive/warehouse`
  * `hadoop fs -chmod g+w /tmp`
  * `hadoop fs -chmod g+w /user/hive/warehouse`
  * `$HIVE_HOME/bin/schematool -dbType derby -initSchema` (if it fails, delete folder `metastore_db` in your user home and re-try)
  * test:
    * `$HIVE_HOME/bin/hive`
    * `CREATE TABLE invites (foo INT, bar STRING) PARTITIONED BY (ds STRING);`
    * `INSERT INTO TABLE invites PARTITION (ds='ds1') VALUES (1, 'a'), (2, 'b'), (3, 'c');`
    * `SELECT * FROM invites;`
    * `hadoop fs -cat /user/hive/warehouse/invites/ds=ds1/*`

* Hive reference:
  * https://cwiki.apache.org/confluence/display/Hive/Home
