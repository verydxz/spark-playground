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

## Hadoop
* Download http://hadoop.apache.org/releases.html. As the time of writing, I used ver `2.7.3`

* We will mainly use `HDFS` not other parts (no `mapred` since we will use `Spark`)

* Guide: http://hadoop.apache.org/docs/r2.7.3/hadoop-project-dist/hadoop-common/ClusterSetup.html

* My steps
  * setup java on each vm
    * `sudo apt-get install openjdk-8-jdk`

  * configure hadoop (you can do it in host machine)
    * extract Hadoop in synced folder `shared`
    * edit `etc/hadoop/hadoop-env.sh`
        ```
        export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
        export HADOOP_HEAPSIZE=200 # the VM mem is small
        export HADOOP_LOG_DIR=/vagrant/local/hadoop/logs.d
        ```

    * edit `etc/hadoop/core-site.xml`
        ```
        <property>
          <name>fs.defaultFS</name>
          <value>hdfs://master:9000</value>
        </property>
        ```

    * edit `etc/hadoop/hdfs-site.xml`
        ```
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

  * start HDFS
      * `mv /vagrant/shared/hadoop-2.7.3 /vagrant/shared/hadoop`
      * `echo export HADOOP_PREFIX=/vagrant/shared/hadoop >> ~/.bashrc`
      * `echo export PATH="\$HADOOP_PREFIX/bin:\$PATH" >> ~/.bashrc`
      * `source ~/.bashrc`
      * `$HADOOP_PREFIX/bin/hdfs namenode -format master` (only the 1st time)
      * `$HADOOP_PREFIX/sbin/start-dfs.sh`

## Spark
* Download: http://spark.apache.org/downloads.html. As the time of writing, I used ver `2.1.0 pre-built for Hadoop 2.7 and later`
* Guide: http://spark.apache.org/docs/2.1.0/spark-standalone.html
