

if [ ! -z "$1" ] &&  [ ! -z "$2" ];then

USER=$1
PWD=$2

echo -e "Please run the following command on any Elasticsearch instance"
echo -e "export JAVA_HOME="/var/vcap/packages/java8" && bash /var/vcap/packages/elasticsearch/plugins/search-guard-6/tools/hash.sh -p $PWD"

echo "Please enter the generated password"
read pass

echo "Please enter the role from /var/vcap/jobs/elasticsearch/config/searchguard/sg_roles.yml "
read role 

echo -e "Please copy and paste the following result in /var/vcap/jobs/elasticsearch/config/searchguard/sg_internal_users.yml"
echo -e "\n\n"
echo -e "$USER"
echo -e "  hash: '$pass'"
echo -e "  roles:"
echo -e "    - $role"

else
   echo -e "Please provide the user and the password. Ex: $0 elastic sasdfiuhaflsdufhd"
fi

