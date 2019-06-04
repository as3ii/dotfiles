# Defined in - @ line 1
function tree --description 'alias tree=exa --classify --long --tree --level=2'
	exa --header --classify --long --git --tree --level=3 $argv;
end
