function se
# Simple function to allow choosing editor and file for sudoedit
  SUDO_EDITOR=$argv[1] sudoedit $argv[2..-1]
end
