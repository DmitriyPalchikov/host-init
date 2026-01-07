# Init OS 

1. Start init script:
    ```bash
    sudo ./init.sh
    ```
2. Start ansible playbook:
    ```bash
    ansible-playbook ./playbook-init.yaml --extra-vars "main_pass=<some_password>" -K
    ```
