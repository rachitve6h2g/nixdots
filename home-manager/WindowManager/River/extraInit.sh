      for i in $(seq 1 9)
      do
          tags=$((1 << ($i - 1)))

          # Mod+[1-9] to focus tag [0-8]
          riverctl map normal ''${mod} $i set-focused-tags $tags

          # Mod+Shift+[1-9] to tag focused view with tag [0-8]
          riverctl map normal ''${mod}+Shift $i set-view-tags $tags

          # Mod+Ctrl+[1-9] to toggle focus of tag [0-8]
          riverctl map normal ''${mod}+Control $i toggle-focused-tags $tags

          # Mod+Shift+Ctrl+[1-9] to toggle tag [0-8] of focused view
          riverctl map normal ''${mod}+Shift+Control $i toggle-view-tags $tags
      done

      # Mod+0 to focus all tags
      # Mod+Shift+0 to tag focused view with all tags
      all_tags=$(((1 << 32) - 1))
      riverctl map normal ''${mod} 0 set-focused-tags $all_tags
      riverctl map normal ''${mod}+Shift 0 set-view-tags $all_tags

      # The scratchpad will live on an unused tag. Which tags are used depends on your
      # config, but rivers default uses the first 9 tags.
      scratch_tag=$((1 << 20 ))

      # Toggle the scratchpad with Super+P
      riverctl map normal Mod4 P toggle-focused-tags ''${scratch_tag}

      # Send windows to the scratchpad with Super+Shift+P
      riverctl map normal Mod4+Shift P set-view-tags ''${scratch_tag}

      # Set spawn tagmask to ensure new windows don't have the scratchpad tag unless
      # explicitly set.
      all_but_scratch_tag=$(( ((1 << 32) - 1) ^ $scratch_tag ))
      riverctl spawn-tagmask ''${all_but_scratch_tag}
