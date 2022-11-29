function profile_fish_startup
  fish --profile-startup /tmp/fish.profile -i -c exit
  sort -nk2 /tmp/fish.profile
  echo ""
  echo "Total: $(math (cat /tmp/fish.profile | awk '{s+=$1} END {print s}') / 1000)ms"
end
