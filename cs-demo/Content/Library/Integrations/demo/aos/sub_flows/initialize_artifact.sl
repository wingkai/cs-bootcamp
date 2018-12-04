namespace: Integrations.demo.aos.sub_flows
flow:
  name: initialize_artifact
  inputs:
    - host: 10.0.46.50
    - username: root
    - password: admin@123
    - artifact_url:
        required: false
    - script_url: 'http://vmdocker.hcm.demo.local:36980/job/AOS-repo/ws/install_postgres.sh'
    - parameters:
        required: false
  workflow:
    - string_equals:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${artifact_url}'
        navigate:
          - SUCCESS: copy_script
          - FAILURE: copy_artifact
    - copy_script:
        do:
          Integrations.demo.aos.sub_flows.remote_copy:
            - host: '${host}'
            - username: '${username}'
            - password: '${password}'
            - url: '${script_url}'
        publish:
          - script_name: '${filename}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: execute_command
    - copy_artifact:
        do:
          Integrations.demo.aos.sub_flows.remote_copy:
            - host: '${host}'
            - username: '${username}'
            - password: '${password}'
            - url: '${artifact_url}'
        publish:
          - artifact_name: '${filename}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: copy_script
    - execute_command:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${host}'
            - command: "${'cd '+get_sp('script_location')+' && chmod 755 '+script_name+' && sh '+script_name+' '+get('artifact_name', '')+' '+get('parameters', '')+' > '+script_name+'.log'}"
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        publish:
          - command_return_code
        navigate:
          - SUCCESS: delete_file
          - FAILURE: delete_file
    - delete_file:
        do:
          Integrations.demo.aos.tools.delete_file:
            - host: '${host}'
            - username: '${username}'
            - password: '${password}'
            - filename: '${script_name}'
        navigate:
          - SUCCESS: has_failed
          - FAILURE: on_failure
    - has_failed:
        do:
          io.cloudslang.base.utils.is_true:
            - bool_value: "${str(command_return_code == '0')}"
        navigate:
          - 'TRUE': SUCCESS
          - 'FALSE': FAILURE
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      string_equals:
        x: 590
        y: 37
      copy_script:
        x: 711
        y: 177
      copy_artifact:
        x: 422
        y: 179
      execute_command:
        x: 393
        y: 315
      delete_file:
        x: 579
        y: 319
      has_failed:
        x: 719
        y: 304
        navigate:
          f9f64b0d-c44c-87d4-0861-32104b88c948:
            targetId: 4b53e8ad-6ce0-36ba-1082-4e419fad23ab
            port: 'TRUE'
          e0d167f5-2e16-aba1-678d-fd2ae68f6e46:
            targetId: 52ae7bba-0857-45ce-6bc8-78ed8ec6a8a9
            port: 'FALSE'
    results:
      FAILURE:
        52ae7bba-0857-45ce-6bc8-78ed8ec6a8a9:
          x: 790
          y: 388
      SUCCESS:
        4b53e8ad-6ce0-36ba-1082-4e419fad23ab:
          x: 791
          y: 254
