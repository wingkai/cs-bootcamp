namespace: Integrations.demo.aos.sub_flows
flow:
  name: remote_copy
  inputs:
    - host: 10.0.46.50
    - username: root
    - password: admin@123
    - url: 'http://vmdocker.hcm.demo.local:36980/job/AOS-repo/ws/install_java.sh'
  workflow:
    - extract_filename:
        do:
          io.cloudslang.demo.aos.tools.extract_filename:
            - url: '${url}'
        publish:
          - filename
        navigate:
          - SUCCESS: get_file
    - get_file:
        do:
          io.cloudslang.base.http.http_client_action:
            - url: '${url}'
            - destination_file: '${filename}'
            - method: GET
        navigate:
          - SUCCESS: remote_secure_copy
          - FAILURE: on_failure
    - remote_secure_copy:
        do:
          io.cloudslang.base.remote_file_transfer.remote_secure_copy:
            - source_path: '${filename}'
            - destination_host: '${host}'
            - destination_path: "${get_sp('script_location')}"
            - destination_username: '${username}'
            - destination_password:
                value: '${password}'
                sensitive: true
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - filename: '${filename}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      extract_filename:
        x: 416
        y: 105
      remote_secure_copy:
        x: 598
        y: 264
        navigate:
          e142b159-583d-a60b-e51c-edaf45d5af94:
            targetId: 8cdcc61e-1c0a-e9ad-9d17-cb9b57791536
            port: SUCCESS
      get_file:
        x: 413
        y: 263
    results:
      SUCCESS:
        8cdcc61e-1c0a-e9ad-9d17-cb9b57791536:
          x: 588
          y: 124
