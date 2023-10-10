# AUTOMATION SCRIPTS
This set of scripts has been developed to streamline the automation of environment setup. For each script, we've outlined specific use cases, and when necessary, we've consolidated multiple scripts into a single one for automation. To fully grasp the utility of each script and the prerequisites for their usage, please take the time to understand their functions.

## REGAINING ACCESS TO A REMOTE SERVER WITH A LOST KEY
<p>If you happen to misplace the key for your server, access can only be regained from the machine where you've previously copied the public key to the server. Access from other machines will not be possible as it will require the .pem key specific to that machine.

The <strong>GOOD NEWS</strong> is that the "Gain_access_remote_server_with_lost_key.sh" script enables you to regain access to your server using a new .pem key from the rescue remote server. There are certain prerequisites you need to meet to make this possible.
</p>

### Prerequisites
To prepare for the process, make sure to complete the following steps:

- Generate a new server with a .pem key.
- Record crucial information such as the <strong>instance-id</strong>, <strong>volume-id</strong>, and <strong>device key</strong> for the server with the lost key.
- Document the <strong>instance-id</strong>, <strong>volume-id</strong>, and <strong>device key</strong> for the new server.
- Keep track of the <strong>Public IP</strong> address for the new server.
- Copy your <strong>local machine's SSH public key</strong> to the newly created machine.
- Also, ensure that you copy your <strong>local machine's SSH public key</strong> to the machine that requires restoration.
- It's essential that both servers are in the <strong>same region</strong>.

### Using the <strong>"Gain_access_remote_server_with_lost_key.sh"</strong>
- Open the script and modify the value of "remote_server" on line 15, then save the changes.
- Navigate to the "Automation" directory using the command line.
- Execute the script by passing the values copied during the prerequisites stage. 
- Here's an example command:
```./Gain_access_remote_server_with_lost_key.sh <instance-id-machine-with-lost key> <volume-id-machine-with-lost key> <Device-Name-machine-with-lost key> <Region Name> <Rescue Instance Id> <Rescue Instance Volume Id> <Rescue device Name>```
- The script will run and carry out the necessary tasks.
- After completion, you can log in to the new machine using the <strong>.pem</strong> key associated with the new server.