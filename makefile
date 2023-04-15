create-template:
	echo "Creating template..."
	sh ./templates/packer/scripts/runPrepareTemplate.sh

run-packer:
	echo "Running packer..."
	packer build --var-file=./templates/packer/credentials.pkrvars.hcl ./templates/packer/base.pkr.hcl