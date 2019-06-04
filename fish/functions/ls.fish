# Defined in - @ line 1
function ls --description 'alias ls=exa --across --classify'
	exa --across --classify $argv;
end
