namespace: ''
properties:
  - script_location: /tmp
  - vm_username: root
  - vm_password:
      value: admin@123
      sensitive: true
  - script_deploy_wars: 'http://vmdocker.hcm.demo.local:36980/job/AOS-repo/ws/deploy_war.sh'
  - script_install_java: 'http://vmdocker.hcm.demo.local:36980/job/AOS-repo/ws/install_java.sh'
  - script_install_postgres: 'http://vmdocker.hcm.demo.local:36980/job/AOS-repo/ws/install_postgres.sh'
  - script_install_tomcat: 'http://vmdocker.hcm.demo.local:36980/job/AOS-repo/ws/install_tomcat.sh'
  - war_repo_root_url: 'http://vmdocker.hcm.demo.local:36980/job/AOS/lastSuccessfulBuild/artifact/'
  - vcenter_host: capa1-vc55.capa1.example.com
  - vcenter_user: "CAPA1\\1024-capa1user"
  - vcenter_password:
      value: Automation123
      sensitive: true
  - vcenter_image: Ubuntu
  - vcenter_folder: Students/Kai
  - vcenter_datacenter: CAPA1 Datacenter
