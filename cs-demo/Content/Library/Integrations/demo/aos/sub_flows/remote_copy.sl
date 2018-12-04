namespace: Integrations.demo.aos.sub_flows
flow:
  name: remote_copy
  inputs:
    - host
    - username
    - password
    - url
  workflow:
    - extract_filename:
        do:
          io.cloudslang.demo.aos.tools.extract_filename:
            - url: '${url}'
        publish: []
        navigate: []
  results: []
extensions:
  graph:
    steps:
      extract_filename:
        x: 418
        y: 174
