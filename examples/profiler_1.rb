require_relative '../lib/memory/profiler'

Memory::Profiler.start_profiling
array = 1000.times.map { |i| Object.new }
Memory::Profiler.end_profiling

Memory::Profiler.print_profiling
