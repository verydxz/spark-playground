## Spark Setup
* Download: http://spark.apache.org/downloads.html. As the time of writing, I chose ver `2.1.0 pre-built for Hadoop 2.7 and later`
* Guide: http://spark.apache.org/docs/2.1.0/spark-standalone.html

* Configure Spark (you can do it in host machine)
  * extract Spark in synced folder `shared` and rename it `spark`
  * we will use the `standalone` mode
  * `cp conf/spark-env.sh.template conf/spark-env.sh` and edit
    * basically the configs are paths and params for small mem vm
    ```
    export SPARK_LOCAL_DIRS=/vagrant/local/spark/local.d
    export SPARK_EXECUTOR_INSTANCES=1
    export SPARK_EXECUTOR_MEMORY=500M
    export SPARK_DRIVER_MEMORY=500M
    export SPARK_MASTER_HOST=master
    export SPARK_WORKER_MEMORY=500M
    export SPARK_WORKER_DIR=/vagrant/local/spark/work.d
    export SPARK_WORKER_OPTS="-Dspark.worker.cleanup.enabled=true"
    export SPARK_DAEMON_MEMORY=500M
    export SPARK_LOG_DIR=/vagrant/local/spark/logs.d
    ```
  * `cp conf/slaves.template conf/slaves` and edit
    ```
    master
    data1
    data2
    data3
    ```
* Initialize Spark (in virtual machine)
  * `vagrant ssh master`
  * `echo export SPARK_HOME=/vagrant/shared/spark >> ~/.bashrc`
  * `echo export PATH="\$SPARK_HOME/bin:\$PATH" >> ~/.bashrc`
  * `source ~/.bashrc`
  * `$SPARK_HOME/sbin/start-all.sh`
  * check: http://192.168.100.100:8080
  * test: `spark-shell --master spark://master:7077`
