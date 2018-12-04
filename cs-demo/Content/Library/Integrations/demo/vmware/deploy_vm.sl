namespace: Integrations.demo.vmware
flow:
  name: deploy_vm
  inputs:
    - host: "${get_sp('vcenter_host')}"
    - user: "${get_sp('vcenter_user')}"
    - pass: "${get_sp('vcenter_password')}"
    - image: "${get_sp('vcenter_image')}"
    - datacenter: "${get_sp('vcenter_datacenter')}"
    - folder: "${get_sp('vcenter_folder')}"
    - prefix: kai-
  workflow:
    - provision_vm:
        do:
          io.cloudslang.vmware.vcenter.provision_vm: []
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      provision_vm:
        x: 478
        y: 325
        navigate:
          19c63685-afa1-ddbf-11b1-ce4edac2e414:
            targetId: 962490fb-ba65-a997-61b5-6bbb790f34d2
            port: SUCCESS
    results:
      SUCCESS:
        962490fb-ba65-a997-61b5-6bbb790f34d2:
          x: 630
          y: 323
