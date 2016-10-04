require_relative "profiler/version"

module Memory
  module Profiler
    class Wrapper < Struct.new(:defined_class, :method_id, :hash) # :nodoc:
      private :defined_class=, :method_id=, :hash=

      def initialize(klass, mid)
        super(klass, mid, nil)
        self.hash = Struct.instance_method(:hash).bind(self).call
      end

      def to_s
        "#{defined_class.inspect}#".sub(/\A\#<Class:(.*)>#\z/, '\1.') << method_id.to_s
      end
      alias inspect to_s
    end

    @@stack = nil
    @@record = nil

    PROFILE_CALL_PROC = TracePoint.new(:call, :c_call, :b_call) do |tp|
      data = ObjectSpace.count_objects
      @@stack.push(data)
    end

    PROFILE_RETURN_PROC = TracePoint.new(:return, :c_return, :b_return) do |tp|
      previous_data = @@stack.pop

      if previous_data
        data = ObjectSpace.count_objects
        key = Wrapper.new(tp.defined_class, tp.method_id)
        @@record[key] ||= [
          0, # number of object this method use
          0, # number of time this method is called
        ]
        @@record[key][0] += data[:T_OBJECT] - previous_data[:T_OBJECT]
        @@record[key][1] += 1
      end
    end

  module_function

    def start_profiling
      @@stack = []
      @@record = {}
      PROFILE_CALL_PROC.enable
      PROFILE_RETURN_PROC.enable
    end

    def end_profiling
      PROFILE_CALL_PROC.disable
      PROFILE_RETURN_PROC.disable
    end

    def print_profiling
      @@record.each do |key, value|
        puts "#{key} #{value}"
      end
    end
  end
end
