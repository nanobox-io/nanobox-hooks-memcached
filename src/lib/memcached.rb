module Hooky
  module Memcached

    CONFIG_DEFAULTS = {
      # global settings
      before_deploy:                {type: :array, of: :string, default: []},
      after_deploy:                 {type: :array, of: :string, default: []},

      # memcached_settings
      return_error_on_memory_exhausted: {type: :on_off, default: false}, # -M            return error on memory exhausted (rather than removing items)
      max_connections:                  {type: :integer, default: 1024}, # -c <num>      max simultaneous connections (default: 1024)
      chunk_size_growth_factor:         {type: :float, default: 1.25}, # -f <factor>   chunk size growth factor (default: 1.25)
      minimum_allocated_space:          {type: :integer, default: 48}, # -n <bytes>    minimum space allocated for key+value+flags (default: 48)
      maximum_requests_per_event:       {type: :integer, default: 20}, # -R            Maximum number of requests per event, limits the number of requests process for a given connection to prevent starvation (default: 20)
      disable_cas:                      {type: :on_off, default: false}, # -C            Disable use of CAS
      max_backlog:                      {type: :integer, default: 1024}, # -b            Set the backlog queue limit (default: 1024)
      binding_protocol:                 {type: :string, default: 'auto', from: ['ascii', 'binary', 'auto']} # -B            Binding protocol - one of ascii, binary, or auto (default)
    }

  end
end
