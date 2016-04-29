# Copyright 2016 Bryan J. Hong
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ubuntu:14.04

MAINTAINER bryan@turbojets.net

ENV DEBIAN_FRONTEND noninteractive

# Add Elastic repository
RUN echo "deb http://packages.elastic.co/kibana/4.5/debian stable main" \
 > /etc/apt/sources.list.d/elastic.list \
 && apt-key adv --keyserver pgp.mit.edu --recv-keys D88E42B4

# Update APT repository and install Kibana
RUN apt-get -q update \
 && apt-get -y install kibana

# Install configs
COPY assets/kibana.yml.sh /opt/kibana.yml.sh

# Install Startup script
COPY assets/startup.sh /opt/startup.sh

# Execute Startup script when container starts
ENTRYPOINT [ "/opt/startup.sh" ]
