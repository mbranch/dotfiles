#!/bin/bash -e
#
# Michael's dotfile installer, based on Chris'
# https://github.com/Cbeck527/dotfiles
#
#   curl https://raw.githubusercontent.com/mbranch/dotfiles/master/install.sh | sh
#
# or:
#
#   ~/.dotfiles/install.sh
#

basedir=$HOME/.dotfiles
gitbase=git://github.com/mbranch/dotfiles.git
tarball=https://github.com/mbranch/dotfiles/tarball/master

function has() {
    return $( which $1 >/dev/null )
}

function note() {
    echo "[32;1m * [0m$*"
}

function warn() {
    echo "[31;1m * [0m$*"
}

function die() {
    warn $*
    exit 1
}

function link() {
    src=$1
    dest=$2

    if [ -e $dest ]; then
        if [ -L $dest ]; then
            # Already symlinked -- I'll assume correctly.
            return
        else
            # Rename files with a ".old" extension.
            warn "$dest file already exists, renaming to $dest.old"
            backup=$dest.old
            if [ -e $backup ]; then
                die "$backup already exists. Aborting."
            fi
            mv -v $dest $backup
        fi
    fi

    # Update existing or create new symlinks.
    ln -vsf $src $dest
}

function unpack_tarball() {
    note "Downloading tarball..."
    mkdir -vp $basedir
    cd $basedir
    tempfile=TEMP.tar.gz
    if has curl; then
        curl -L $tarball >$tempfile
    elif has wget; then
        wget -O $tempfile $tarball
    else:
        die "Can't download tarball."
    fi
    tar --strip-components 1 -zxvf $tempfile
    rm -v $tempfile
}

if [ -e $basedir ]; then
    # Basedir exists. Update it.
    cd $basedir
    if [ -e .git ]; then
        note "Updating dotfiles from git..."
        # git pull --rebase origin master
    else
        unpack_tarball
    fi
else
    # .dotfiles directory needs to be installed. Try downloading first with
    # git, then use tarballs.
    if has git; then
        note "Cloning from git..."
        git clone $gitbase $basedir
        cd $basedir
    else
        warn "Git not installed."
        unpack_tarball
    fi
fi

note "Installing dotfiles..."
for path in * ; do
    case $path in
        .|..|.git|README.md|install.sh)
            continue
            ;;
        *)
            link $basedir/$path $HOME/.$path
            ;;
    esac
done


note "Installing apps..."

cd $basedir
cat ./brew | xargs brew install $@
cat ./cask | xargs brew cask install $@
cat ./mas | awk '{print $1}' | xargs mas install $@

note "Done."
