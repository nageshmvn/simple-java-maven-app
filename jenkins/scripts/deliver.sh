#!/usr/bin/env bash

echo 'The following Maven command installs your Maven-built Java application'
echo 'into the local Maven repository, which will ultimately be stored in'
echo 'Jenkins''s local Maven repository (and the "maven-repository" Docker data'
echo 'volume).'
set -x
mvn jar:jar install:install help:evaluate -Dexpression=project.name
set +x

echo 'The following command extracts the value of the <name/> element'
echo 'within <project/> of your Java/Maven project''s "pom.xml" file.'
set -x
NAME=`mvn -q -DforceStdout help:evaluate -Dexpression=project.name`
set +x

echo 'The following command behaves similarly to the previous one but'
echo 'extracts the value of the <version/> element within <project/> instead.'
set -x
VERSION=`mvn -q -DforceStdout help:evaluate -Dexpression=project.version`
set +x

# echo 'The following command runs and outputs the execution of your Java'
# echo 'application (which Jenkins built using Maven) to the Jenkins UI.'
# set -x
# java -jar target/${NAME}-${VERSION}.jar

echo 'The following command runs and outputs the execution of your Java and Store in UUUU'
echo 'application (which Jenkins built using Maven) to the Jenkins UI.'

# Remove all special characters from NAME and VERSION, keeping only alphanumerics, hyphens, and underscores
NAME=$(echo "$NAME" | tr -cd '[:alnum:]_-')
VERSION=$(echo "$VERSION" | tr -cd '[:alnum:]_-')

set -x
java -jar target/${NAME}-${VERSION}.jar

