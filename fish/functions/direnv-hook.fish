function direnv-hook
    function __direnv_update
        command direnv export fish | source

        if test "$direnv_set_aliases" != "$DIRENV_ALIASES"
            for name in $direnv_alias_names
                functions --erase $name
            end
            set -e direnv_alias_names

            for cmd in (echo $DIRENV_ALIASES | string split --no-empty ':alias:')
                echo "direnv: alias $cmd"
                eval alias $cmd
                set parts (echo $cmd | string split --no-empty ' ')
                set -g -a direnv_alias_names $parts[1]
            end

            set -g direnv_set_aliases $DIRENV_ALIASES
        end
    end

    function __direnv_export_eval --on-event fish_prompt
        # Run on each prompt to update the state
        __direnv_update

        if test "$direnv_fish_mode" != "disable_arrow"
            # Handle cd history arrows between now and the next prompt
            function __direnv_cd_hook --on-variable PWD
                if test "$direnv_fish_mode" = "eval_after_arrow"
                    set -g __direnv_export_again 0
                else
                    # default mode (eval_on_pwd)
                    __direnv_update
                end
            end
        end
    end

    function __direnv_export_eval_2 --on-event fish_preexec
        if set -q __direnv_export_again
            set -e __direnv_export_again
            __direnv_update
            echo
        end

        # Once we're running commands, stop monitoring cd changes
        # until we get to the prompt again
        functions --erase __direnv_cd_hook
    end
end
