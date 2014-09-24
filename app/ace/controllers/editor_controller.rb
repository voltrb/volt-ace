module Ace
  class EditorController < ModelController
    attr_accessor :section
    def index
    end

    def dom_ready
      puts "Index: #{section.container_node}"

      node = section.container_node

      %x{
        var editor = ace.edit('aceEditor');
        editor.setTheme("ace/theme/monokai");
        editor.getSession().setMode("ace/mode/javascript");
      }


    end
  end
end