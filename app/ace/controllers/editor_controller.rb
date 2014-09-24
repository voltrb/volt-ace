module Ace
  class EditorController < ModelController
    attr_accessor :section
    def index
    end

    # Change the ace editor mode.  Handle if mode isn't passed in.
    def change_mode
      if @mode
        new_mode = @mode.cur.or('ace/mode/javascript')
      else
        new_mode = 'ace/mode/javascript'
      end
      `this.editor.getSession().setMode(new_mode)`
    end

    # When the dom is ready, setup the editor
    def dom_ready
      node = section.container_node

      %x{
        var editorDiv = $(node).find('.ace-editor').get(0);
        this.editor = ace.edit(editorDiv);
        //this.editor.setTheme("ace/theme/monokai");
        this.editor.setTheme("ace/theme/twilight");
      }

      @value_listener = @value.on('changed') do
        unless @updating
          new_value = @value.cur
          `this.editor.setValue(new_value)`
        end
      end

      `var editor = this.editor;`
      `this.editor.getSession().on('change', function(e) {`
        `var new_value = editor.getValue()`
        new_value = "" + new_value

        @updating = true
        @value.cur = new_value
        @updating = false
      `});`
      puts instance_variables.inspect

      if @mode
        @mode_listener = @mode.on('changed') do
          change_mode
        end
      end

      change_mode
    end

    def dom_removed
      @value_listener.remove if @value_listener
      @mode_listener.remove if @mode_listener
    end
  end
end