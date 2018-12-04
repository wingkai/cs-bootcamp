namespace: Integrations.demo.aos.sub_flows
flow:
  name: deploy_wars
  inputs:
    - tomcat_host: 10.0.46.50
    - account_service_host: 10.0.46.50
    - db_host: 10.0.46.50
    - username: root
    - password: admin@123
    - url: "${get_sp('war_repo_root_url')}"
  workflow:
    - deploy_account_service:
        do:
          Integrations.demo.aos.sub_flows.initialize_artifact:
            - host: '${account_service_host}'
            - username: '${username}'
            - password: '${password}'
            - artifact_url: "${url+'accountservice/target/accountservice.war'}"
            - script_url: "${get_sp('script_deploy_wars')}"
            - parameters: "db_host+' postgres admin '+tomcat_host+' '+account_service_host"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: deploy_tm_wars
    - deploy_tm_wars:
        loop:
          for: "war in 'catalog','MasterCredit','order','ROOT','ShipEx','SafePay'"
          do:
            Integrations.demo.aos.sub_flows.initialize_artifact:
              - host: '${tomcat_host}'
              - username: '${username}'
              - password: '${password}'
              - artifact_url: "${url+war.lower()+'/target/'+war+'.war'}"
              - script_url: "${get_sp('script_deploy_wars')}"
              - parameters: "db_host+' postgres admin '+tomcat_host+' '+account_service_host"
          break:
            - FAILURE
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      deploy_account_service:
        x: 348
        y: 151
      deploy_tm_wars:
        x: 540
        y: 153
        navigate:
          2ee203a8-9415-496f-2b69-e44afd0b232e:
            targetId: 808c3463-1e5d-fd2f-34d1-a0d2564d36c1
            port: SUCCESS
    results:
      SUCCESS:
        808c3463-1e5d-fd2f-34d1-a0d2564d36c1:
          x: 742
          y: 165
