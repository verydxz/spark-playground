## Hadoop Setup
* Download: http://hadoop.apache.org/releases.html. As the time of writing, I chose ver `2.7.3`
* We will use `HDFS` but not other parts for now (no `mapred` or `Yarn`)
* Guide: http://hadoop.apache.org/docs/r2.7.3/hadoop-project-dist/hadoop-common/ClusterSetup.html
* Configure Hadoop (you can do it in host machine)
  * extract Hadoop in synced folder `shared` and rename it `hadoop`
  * edit `etc/hadoop/hadoop-env.sh`
    ```
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
    export HADOOP_HEAPSIZE=200 # for small mem vm
    export HADOOP_LOG_DIR=/vagrant/local/hadoop/logs.d
    ```
  * edit `etc/hadoop/core-site.xml`
    ```
    <property>
      <name>fs.defaultFS</name>
      <value>hdfs://master:9000</value>
    </property>
    ```
  * edit `etc/hadoop/hdfs-site.xml` (some configs are for small vm)
    ```
    <property>
      <name>dfs.replication</name>
      <value>2</value>
    </property>
    <property>
      <name>dfs.blocksize</name>
      <value>16777216</value>
    </property>
    <property>
      <name>dfs.namenode.name.dir</name>
      <value>/vagrant/local/hadoop/names/</value>
    </property>
    <property>
      <name>dfs.datanode.data.dir</name>
      <value>/vagrant/local/hadoop/data/</value>
    </property>
    ```
  * edit `etc/hadoop/slaves`
    ```
    master
    data1
    data2
    data3
    ```
* Initialize HDFS (in virtual machine)
  * `vagrant ssh master`
  * `echo export HADOOP_PREFIX=/vagrant/shared/hadoop >> ~/.bashrc`
  * `echo export PATH="\$HADOOP_PREFIX/bin:\$PATH" >> ~/.bashrc`
  * `source ~/.bashrc`
  * `hdfs namenode -format cluster0`
  * `$HADOOP_PREFIX/sbin/start-dfs.sh`
  * check: http://192.168.100.100:50070
  * test: `hadoop fs -put <some_local_file> /`

* `hadoop fs` reference:
  * http://hadoop.apache.org/docs/r2.7.3/hadoop-project-dist/hadoop-common/FileSystemShell.html
