---
- name: Install MongoDB 3.2
  hosts: all
  become: true
  tasks:
  # Добавим ключ репозитория для последующей работы с ним
  - name: Add APT key
    apt_key:
      id: EA312927
      keyserver: keyserver.ubuntu.com

  # Подключаем репозиторий с пакетами mongodb
  - name: Add APT repository
    apt_repository:
      repo: deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse
      state: present

  # Выполним установку пакета
  - name: Install mongodb package
    apt:
      name: mongodb-org
      state: present

  # Включаем сервис
  - name: Configure service supervisor
    systemd:
      name: mongod
      enabled: yes
