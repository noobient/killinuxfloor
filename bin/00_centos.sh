echo -n 'Checking CentOS version... '

check_centos

if [ ${RET} -ne 0 ]
then
    exit 4
fi

${ECHO_DONE}
