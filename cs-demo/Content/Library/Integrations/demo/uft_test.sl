namespace: Integrations.demo
flow:
  name: rpa
  inputs:
    - aos_host: 10.0.46.31
    - aos_user: cheng
    - aos_password:
        default: P@ssw0rd1234
        sensitive: true
    - catalog: TABLETS
    - item: HP ELITEPAD 1000 G2 TABLET
    - uft_test_location: "C:\\Users\\Administrator\\Documents\\Unified Functional Testing\\AOS_buy_item"
  workflow:
    - uft_test:
        do:
          io.cloudslang.microfocus.uft.run_test:
            - host: "${get_sp('uft_host')}"
            - username: "${get_sp('uft_username')}"
            - password:
                value: "${get_sp('uft_password')}"
                sensitive: true
            - port: "${get_sp('uft_port')}"
            - protocol: "${get_sp('uft_protocol')}"
            - is_test_visible: "${get_sp('uft_is_test_visible')}"
            - test_path: "${get_sp('uft_result_location')}"
            - test_results_path: "${get_sp('uft_result_location')}"
            - uft_workspace_path: "${get_sp('uft_result_location')}"
            - test_parameters: "${'host:'+aos_host+',user:'+aos_user+',password:'+aos_password+',catalog:'+catalog+',item:'+item}"
        publish:
          - reutrn_code: '${return_code}'
          - script_exit_code
          - test_return_result
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  outputs:
    - test_return_result: '${test_return_result}'
    - script_exit_code: '${script_exit_code}'
    - return_code: '${reutrn_code}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      uft_test:
        x: 208
        y: 190
        navigate:
          040ab072-95b1-3a96-729e-1eefd2aff2b5:
            targetId: dd03ecd4-4c8e-4a50-8ca4-b0c31ccff05c
            port: SUCCESS
    results:
      SUCCESS:
        dd03ecd4-4c8e-4a50-8ca4-b0c31ccff05c:
          x: 487
          y: 182
