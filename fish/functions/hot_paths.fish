# https://www.jakobstoeck.de/2017/ramdisk-for-faster-applications-under-macos/
function hot_paths --description "Show hottest filepaths"
  sudo fs_usage -w -t 5 -f filesys | tee fs_usage.log | egrep -o '(/.+?) {3}' | sed -e 's/\/dev\/disk[^ ]+  //' | sort | uniq -c | sort -nr
end
