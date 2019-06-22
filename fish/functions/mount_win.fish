# Defined in - @ line 1
function mount_win --description 'alias mount_win=sudo mount /dev/nvme0n1p5 /mnt/win'
	sudo mount /dev/nvme0n1p5 /mnt/win $argv;
end
