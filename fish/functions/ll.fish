# Defined in - @ line 1
function ll --description 'alias ll=exa --classify --group --long --header'
	exa --classify --group --long --header --git $argv;
end
