# Image de base : Jenkins version 2.426.2, utilisant JDK 17
FROM jenkins/jenkins:2.426.2-jdk17

# Passage à l'utilisateur root pour avoir les permissions nécessaires à l'installation de paquets
USER root

# Mise à jour de la liste des paquets apt et installation de lsb-release, un utilitaire fournissant des informations sur le système d'exploitation actuel
RUN apt-get update && apt-get install -y lsb-release

# Téléchargement de la clé GPG de Docker pour assurer l'authenticité du logiciel
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg

# Ajout du dépôt Docker au système
# Cela implique de définir l'architecture, de spécifier la clé GPG pour la vérification et de définir l'URL du dépôt ainsi que la distribution
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Mise à jour de nouveau de la liste des paquets apt avec le nouveau dépôt Docker et installation du CLI Docker
RUN apt-get update && apt-get install -y docker-ce-cli

# Retour à l'utilisateur jenkins pour exécuter les commandes spécifiques à Jenkins
USER jenkins

# Installation des plugins Jenkins : Blue Ocean et Docker Pipeline
# Blue Ocean fournit une interface utilisateur moderne pour Jenkins, et Docker Pipeline permet aux pipelines Jenkins de construire et d'utiliser des conteneurs Docker
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"

# Référence : Documentation officielle de Jenkins pour l'installation de Jenkins dans Docker
# https://www.jenkins.io/doc/book/installing/docker/
