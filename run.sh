SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
mkdir -p ${SCRIPT_DIR}/workspace
sudo docker run --rm -it -v ${SCRIPT_DIR}/bin:/home/dev/bin -v ${SCRIPT_DIR}/workspace:/home/dev/ws frappe:jammy /bin/bash
