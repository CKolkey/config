function n --wraps nnn --description 'support nnn quit and change directory'
  # Block nesting of nnn in subshells
  if test -n "$NNNLVL"
    if [ (expr $NNNLVL + 0) -ge 1 ]
      echo "nnn is already running"
      return
    end
  end

  # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
  # To cd on quit only on ^G, remove the "-x" as in:
  #  set NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
  #  (or, to a custom path: set NNN_TMPFILE "/tmp/.lastd")
  # or, export NNN_TMPFILE after nnn invocation
  if test -n "$XDG_CONFIG_HOME"
    set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
  else
    set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
  end


  # NNN Config
  set -gx BLK     "04"
  set -gx CHR     "04"
  set -gx DIR     "04"
  set -gx EXE     "00"
  set -gx REG     "00"
  set -gx HARDLINK "00"
  set -gx SYMLINK "06"
  set -gx MISSING "00"
  set -gx ORPHAN  "01"
  set -gx FIFO    "0F"
  set -gx SOCK    "0F"
  set -gx OTHER   "02"
  set -gx NNN_FCOLORS "$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
  set -gx NNN_PLUG 'd:diffs;g:-!git diff;x:!chmod +x $nnn;f:fzopen;'
  set -gx NNN_FIFO '/tmp/nnn.fifo'

  # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
  # stty start undef
  # stty stop undef
  # stty lwrap undef
  # stty lnext undef

  nnn $argv

  if test -e $NNN_TMPFILE
    source $NNN_TMPFILE
    rm $NNN_TMPFILE
  end
end
