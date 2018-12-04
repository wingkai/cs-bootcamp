namespace: Integrations.demo.aos.tools
flow:
  name: delete_file
  inputs:
    - host: 10.0.46.50
    - username: root
    - password: admin@123
    - filename: install_java.sh
  workflow:
    - delete_file:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${host}'
            - command: "${'cd '+get_sp('script_location')+' && rm -f '+filename}"
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      delete_file:
        x: 164
        y: 114
        navigate:
          2b43e486-2b41-c7c2-9f7f-0a3e2a3af4d7:
            targetId: 6cd4a8a8-19b9-bfba-6221-fcb79585f024
            port: SUCCESS
    results:
      SUCCESS:
        6cd4a8a8-19b9-bfba-6221-fcb79585f024:
          x: 369
          y: 97
