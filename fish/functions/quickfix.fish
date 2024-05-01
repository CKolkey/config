function quickfix --description "Opens STDIN in quickfix list"
  echo "$(read)" > /tmp/quickfix && nvim -q /tmp/quickfix
end
