# Git status shortcut
function gs
    git status
end

# Git add all
function gaa
    git add .
end

# Git add
function ga
    git add $argv
end

# Git commit with a message
function gc
    git commit -m $argv
end

# Git checkout a branch or file
function gco
    git checkout $argv
end

# Git pull from the current branch
function gpl
    git pull
end

# Git push
function gp
    git push
end

# Git fetch
function gf
    git fetch
end

# Confirm before deleting files
function rm
    command rm -i $argv
end

# Confirm before copying files
function cp
    command cp -i $argv
end

# Confirm before moving files
function mv
    command mv -i $argv
end

# Short key for nvim
function nv
    nvim $argv
end

# Short key for vim
function v
    vim $argv
end

# List files with details
function ll
    ls -la $argv
end

