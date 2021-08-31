namespace: Integrations.AOS_application
flow:
  name: deploy_aos
  inputs:
    - target_host
    - target_host_username: root
    - target_host_password:
        default: Cloud_1234
        sensitive: true
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 116.89234924316406
        'y': 106.76734924316406
      install_java:
        x: 349.8923645019531
        'y': 110.55902099609375
      install_tomcat:
        x: 557.892333984375
        'y': 146.55902099609375
      install_aos_application:
        x: 742
        'y': 133
        navigate:
          816d1105-9a37-61f7-0249-5a61d9a62010:
            targetId: 572a8efb-8a0b-eab9-9baf-7b8f62fa558c
            port: SUCCESS
    results:
      SUCCESS:
        572a8efb-8a0b-eab9-9baf-7b8f62fa558c:
          x: 987.111083984375
          'y': 110.55902099609375
