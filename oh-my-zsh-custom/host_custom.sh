hostname=`hostname -s`

dir=""
case "${hostname}" in
    jeromeLaptop1)
        dir="jeromeLaptop1"
        ;;
    Jeromes-MacBook-Pro)
        dir="placeiq"
        ;;
esac

find $HOME/.oh-my-zsh/custom/$dir -name '*.zsh' | while read file; do
    source $file
done
