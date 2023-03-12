# frappe-docker
Using https://github.com/frappe/frappe with docker 

# Using this repo

clone it and follow below commands to use frappe from inside a container.

	cd frappe-docker
	./build.sh
	./run.sh

Above commands will change to the cloned repo, build an image with pre-requisites and frappe's bench installed.
Now that you are inside container shell invoke below command

	setup-frappe.sh

This will setup frappe-bench folder development inside a folder workspace in the repo, and start bench (services) in background.

The shell is available for further development. you may connect to it via VSCode.

## TODOs

- re-organize apt install packages
- Fix invoking nvm etc
- document
