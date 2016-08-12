module Bipbop
  module Client
    class Table
      @ws
      @dom_node
      @dom
      @database
      
      def initialize(ws, database, dom_node, dom)
        @ws = ws
        @dom_node = dom_node
        @dom = dom
        @database = database
      end
      
      def get_fields
        @dom_node.xpath(".//field").each { |field|
          yield Bipbop::Client::Field.new(self, @database, field, @dom)
        }        
      end
      
      def generate_push(parameters, label, push_callback, push_class = "Bipbop::Client::Push")
        query = "SELECT FROM '%s'.'%s'" % [ @database.name(), self.name() ]
        instance = Kernel.const_get(push_class).new(@ws)
        instance.create(label, push_callback, query, parameters)
      end
      
      def name
        @dom_node['name']
      end
      
      def get(attribute)
        @dom_node[attribute]
      end
      
    end
  end
end
