function __nixdatifier_candidates
    set -l words (commandline -opc)
    set -l current (commandline -ct)
    command $words[1] _complete $words[2..-1] "$current"
end
complete -c nixdatifier -f -a '(__nixdatifier_candidates)'
