## Hive Setup

* First, we need to configure and start `yarn`
  * edit `etc/hadoop/yarn-env.sh`, before `log directory & file` section
    ```
    export YARN_LOG_DIR=/vagrant/local/hadoop/logs.d
    ```
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
  * hive's logs are in the machine's `/tmp` folder, we will leave where it is as this is only a test env

* Initialize Hive (in virtual machine)
  * `vagrant ssh master`
  * `echo export HIVE_HOME=/vagrant/shared/hive >> ~/.bashrc`
  * `echo export PATH="\$HIVE_HOME/bin:\$PATH" >> ~/.bashrc`
  * `source ~/.bashrc`
  * `hadoop fs -mkdir /tmp`
  * `hadoop fs -mkdir -p /user/hive/warehouse`
  * `hadoop fs -chmod g+w /tmp`
  * `hadoop fs -chmod g+w /user/hive/warehouse`

* Setup Hive metastore
  * install MySQL and setup
    * `sudo apt install -y mysql-server mycli`, login mysql as `root`:
      * `CREATE DATABASE hive_metastore;`
      * `CREATE USER 'hive'@'%' IDENTIFIED BY '(your password)';`
      * `GRANT ALL on hive_metastore.* TO 'hive'@'%';`
      * `FLUSH PRIVILEGES;`
    * [download](https://dev.mysql.com/downloads/connector/j/) and copy mysql driver to `$HIVE_HOME/lib`
  * in `hive/conf`, `cp hive-default.xml.template hive-site.xml`, and in `hive-site.xml`
    ```
    <property>
      <name>javax.jdo.option.ConnectionURL</name>
      <value>jdbc:mysql://localhost/hive_metastore?createDatabaseIfNotExist=true</value>
    </property>
    <property>
      <name>javax.jdo.option.ConnectionDriverName</name>
      <value>com.mysql.jdbc.Driver</value>
    </property>
    <property>
      <name>javax.jdo.option.ConnectionUserName</name>
      <value>hive</value>
    </property>
    <property>
      <name>javax.jdo.option.ConnectionPassword</name>
      <value>(your password)</value>
      <description>password to use against metastore database</description>
    </property>
    ```
  * also put below at the beginning of `hive-site.xml` (somehow several system props from java are incorrect)
    ```
    <property>
      <name>system:java.io.tmpdir</name>
      <value>/tmp/hivetmp</value>
    </property>
    <property>
      <name>system:user.name</name>
      <value>hive</value>
    </property>
    ```
  * `$HIVE_HOME/bin/schematool -dbType mysql -initSchema`
  * test:
    * `$HIVE_HOME/bin/hive`
    * `CREATE TABLE invites (foo INT, bar STRING) PARTITIONED BY (ds STRING);`
    * `INSERT INTO TABLE invites PARTITION (ds='ds1') VALUES (1, 'a'), (2, 'b'), (3, 'c');`
    * `SELECT * FROM invites;`
    * exit to shell and `hadoop fs -cat /user/hive/warehouse/invites/ds=ds1/*`
  * hiveserver2
    * update `hadoop`'s `core-site.xml`
      ```
      <property>
        <name>hadoop.proxyuser.ubuntu.hosts</name>
        <value>*</value>
      </property>
      <property>
        <name>hadoop.proxyuser.ubuntu.groups</name>
        <value>*</value>
      </property>
      ```
      you can change 'ubuntu' to any user you use to connect to `hs2`, see [hadoop proxy user](http://hadoop.apache.org/docs/r2.7.3/hadoop-project-dist/hadoop-common/Superusers.html) for more information
    * `$HIVE_HOME/bin/hiveserver2`, may put to background
    * `$HIVE_HOME/bin/beeline -u jdbc:hive2://master:10000/default -n ubuntu`, again 'ubuntu' is just the default user, can change to others
  * python
    * `sudo apt install libsasl2-dev`
    * `pip3 install impyla thrift_sasl sasl pandas ptpython -i https://pypi.douban.com/simple`
    * run below
    ``` python
    import impala.dbapi
    import impala.util
    # see: https://github.com/cloudera/impyla/blob/master/impala/dbapi.py
    conn = impala.dbapi.connect(host='master', port=10000, auth_mechanism='PLAIN')
    cur = conn.cursor()
    cur.execute('SELECT * FROM invites')
    df = impala.util.as_pandas(cur)
    print(df)
    ```

* Hive reference:
  * https://cwiki.apache.org/confluence/display/Hive/Home
