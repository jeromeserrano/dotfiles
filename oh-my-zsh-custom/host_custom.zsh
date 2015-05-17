hostname=`hostname -s`

dir=""
case "${hostname}" in
    jeromeLaptop1)
        dir="homeLaptop1"
        ;;
    Jeromes-MacBook-Pro)
        dir="officeLaptop1"
        ;;
esac

if [ $dir ]; then
	find $HOME/.oh-my-zsh/custom/$dir -name '*.zsh' | while read file; do
	    source $file
	done
fi
