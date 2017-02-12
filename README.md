# Playground to test out distributed system

## Virtual Machines
* Install `Vagrant`
* Edit `Vagrantfile` where variable `the_box` is the VM you choose (in GFW, I downloaded and `vagrent box add`-ed an [Ubuntu 16.04 Xenial](https://cloud-images.ubuntu.com/xenial/current/) in advance)
* `vagrant up`
  * 3 vm will be up: `master`, `data1`, `data2`
  * each vm has a dedicated synced folder `/vagrant/local`, and `/vagrant/shared` is shared across all (this is useful so we can share the same rumtime files in `shared`, and config same paths in `local`, but actually result in different output files in different vm)
  * `vagrant ssh <machine_name>` to each, and run `/vagrant/shared/init-ssh-key.sh` (some how my provision doesn't work, this is a walk-around)
* Usage
  * `vagrant ssh <machine_name>`
  * `vagrant suspend` & `vagrant resume`
  * `vagrant halt` & `vagrant up`
  * and `vagrant destroy`

## Hadoop Setup
* Download: http://hadoop.apache.org/releases.html. As the time of writing, I chose ver `2.7.3`
* We will use `HDFS` but not other parts (no `mapred` since we will use `Spark`, and probably no need for `Yarn`)
* Guide: http://hadoop.apache.org/docs/r2.7.3/hadoop-project-dist/hadoop-common/ClusterSetup.html
* Setup Java in each vm
  * `sudo apt-get install -y openjdk-8-jdk`
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
    ```
  * Initialize HDFS
    * `vagrant ssh master`
    * `echo export HADOOP_PREFIX=/vagrant/shared/hadoop >> ~/.bashrc`
    * `echo export PATH="\$HADOOP_PREFIX/bin:\$PATH" >> ~/.bashrc`
    * `source ~/.bashrc`
    * `hdfs namenode -format cluster0`
    * `$HADOOP_PREFIX/sbin/start-dfs.sh`
    * check: http://192.168.100.100:50070
    * test: `hadoop fs -put <some_local_file> /`

## Spark
* Download: http://spark.apache.org/downloads.html. As the time of writing, I chose ver `2.1.0 pre-built for Hadoop 2.7 and later`
* Guide: http://spark.apache.org/docs/2.1.0/spark-standalone.html

* Configure Spark (you can do it in host machine)
  * extract Spark in synced folder `shared` and rename it `spark`
  * we will use the `standalone` mode
  * `cp conf/spark-env.sh.template conf/spark-env.sh`
    * refer to my `spark-env.sh`, basically the configs are paths and params for small mem vm
  * `cp conf/slaves.template conf/slaves`
    ```
    master
    data1
    data2
    ```
  * Initialize Spark
    * `vagrant ssh master`
    * `echo export SPARK_HOME=/vagrant/shared/spark >> ~/.bashrc`
    * `echo export PATH="\$SPARK_HOME/bin:\$PATH" >> ~/.bashrc`
    * `source ~/.bashrc`
    * `$SPARK_HOME/sbin/start-all.sh`
    * check: http://192.168.100.100:8080
    * test: `spark-shell`
