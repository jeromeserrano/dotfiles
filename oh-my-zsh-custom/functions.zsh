# Quick find
function f() {
    if [[ $# -eq 1 ]]; then
        echo "find . -iname \"*$1*\""
        find . -iname "*$1*"
    elif [[ $# -eq 2 ]]; then
        echo "find $2 -iname \"*$1*\""
        find "$2" -iname "*$1*" 
    fi
}
