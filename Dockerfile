FROM skhatri/essentials

MAINTAINER Suresh Khatri, servlet2@msn.com

#Install Gradle 
RUN wget https://services.gradle.org/distributions/gradle-2.0-all.zip -O /tmp/gradle-2.0-all.zip
RUN mkdir -p /opt/local/gradle && cd /opt/local/gradle && unzip /tmp/gradle-2.0-all.zip -d .

ENV GRADLE_HOME /opt/local/gradle/gradle-2.0


#Install Java 8
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main"\
  | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main"\
  | tee -a /etc/apt/sources.list.d/webupd8team-java.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886
RUN apt-get update
RUN apt-get -y upgrade

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | \
  /usr/bin/debconf-set-selections
RUN apt-get -y --force-yes=true install oracle-java8-installer
RUN update-alternatives --display java 
RUN apt-get clean


ENV JAVA_HOME /usr/lib/jvm/java-8-oracle


#Download scala
RUN wget http://www.scala-lang.org/files/archive/scala-2.10.4.tgz -O /tmp/scala-2.10.4.tgz
RUN mkdir -p /opt/local/scala && cd /opt/local/scala && tar xzf /tmp/scala-2.10.4.tgz

ENV SCALA_HOME /opt/local/scala/scala-2.10.4

#Download SBT
RUN wget http://dl.bintray.com/sbt/native-packages/sbt/0.13.5/sbt-0.13.5.zip -O /tmp/sbt-0.13.5.zip
RUN mkdir -p /opt/local/sbt && cd /opt/local/sbt && unzip /tmp/sbt-0.13.5.zip -d .

ENV SBT_HOME /opt/local/sbt/sbt-0.13.5

ENV PATH $JAVA_HOME/bin:$SCALA_HOME/bin:$SBT_HOME/bin:$GRADLE_HOME/bin:$PATH

RUN rm -rf /tmp/sbt* && rm -rf /tmp/scala*

