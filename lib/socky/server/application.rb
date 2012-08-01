module Socky
  module Server
    class Application

      attr_accessor :name, :secret, :webhook_url
      attr_reader :webhook_handler

      class << self
        # list of all known applications
        # @return [Hash] list of applications
        def list
          @list ||= {}
        end

        # find application by name
        # @param [String] name name of application
        # @return [Application] found application or nil
        def find(name)
          list[name]
        end
      end

      # initialize new application
      # @param [String] name application name
      # @param [String] secret application secret key
      # @param [String] webhook url
      def initialize(name, secret, webhook_url = nil)
        @name = name
        @secret = secret
        @webhook_url = webhook_url
        @webhook_handler = WebhookHandler.new(self)
        self.class.list[name] ||= self
      end

      # list of all connections for this application
      # @return [Hash] hash of all connections
      def connections
        @connections ||= {}
      end

      # add new connection to application
      # @param [Connection] connection connetion to add
      def add_connection(connection)
        self.connections[connection.id] = connection
      end

      # remove connection from application
      # @param [Connection] connection connection to remove
      def remove_connection(connection)
        self.connections.delete(connection.id)
      end

    end
  end
end
