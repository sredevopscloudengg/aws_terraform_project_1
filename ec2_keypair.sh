#initial params
work_dir=$(PWD)
dir_sep_char="/"
file_prefix="AWSKeyPair_"
#aws keypair extension
file_ext=".pem"
#current date with timestamp
current_date=$(date +"%d%b%Y_%H%M%S")
#build aws keypair filename
AWS_KEY_PAIR=$file_prefix$current_date
key_pair_name="lab_keypair_1"
key_pair_file="lab_keypair_1.pem"
#build aws keypair file path
#AWS_KEY_PAIR_PATH=$work_dir$dir_sep_char$file_prefix$current_date$file_ext
AWS_KEY_PAIR_PATH=$work_dir$dir_sep_char$key_pair_file

#create and download key pair
#aws ec2 create-key-pair --key-name $key_pair_name --query KeyMaterial --output text > $AWS_KEY_PAIR_PATH
aws ec2 create-key-pair --key-name $key_pair_name --query KeyMaterial --output text > $key_pair_file
aws ec2 wait key-pair-exists --key-name $key_pair_name
echo "**************AWS KEY PAIR $AWS_KEY_PAIR EXISTS**************"