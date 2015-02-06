module BuildJS
  class FileRecord
    def initialize(options={})
      @hash_history = []
      @options = options

      # Default options
      @options[:include_file_in_hash] ||= false
    end

    # Add file to the record
    def add(filepath)
      @hash_history.push gen_hash(filepath)
    end

    # Is the file in the record?
    def include?(filepath)
      @hash_history.include? gen_hash(filepath)
    end

    private
    def gen_hash(filepath)
      if should? :include_file_in_hash
        Digest::MD5.hexdigest("#{filepath}-#{File.read(filepath)}")
      else
        Digest::MD5.hexdigest(filepath)
      end
    end

    # Options helper
    def should?(option)
      if @options.include? option
        @options[option]
      end
    end
  end

  class Builder
    def initialize(start_file, options={})
      @options = options
      @start_file = start_file

      # Default options
      @options[:lib_root] ||= '.'
      @options[:verbose] ||= false
    end

    def build
      Dir.chdir(@options[:lib_root])

      # Start the recursion loop
      FileParse.parse(@start_file, FileRecord.new, @options)
    end
  end

  class FileParse
    def self.parse(filename, file_record, options={})
      # Do verbose logging?
      l = options[:verbose]

      # Compiler will check if the file exists and either throw exception or return the compiled file.
      l && log("Compiling #{filename}")
      file = Compiler.compile(filename)

      # require('somefile');
      match_gsub = /require\s?\(\s?['"]\s?(.*)\s?['"]\s?\)\s?;/

      # Look for all of the require directives
      loop do
        match = file.index(match_gsub)
        if match.nil?
          # No more matches? Kill the loop
          l && log("No more matches for #{filename}")
          break
        else
          l && log("Parsing directive at index #{match} on #{filename}.")
          statement_end = file.index(';', match) # Look for the semicolon

          file_to_include = file[match..statement_end][/['"]\s?(.*)\s?['"]\s?/].gsub(/[\"']/, '') # Uses regex to determine the file to include
          file[match..statement_end] = '' # Removes the require directive

          l && log("Matched file to #{file_to_include} on #{filename}")

          # As long as this file isn't already included...
          unless file_record.include? file_to_include
            l && log("#{file_to_include} is not already included. Including.")
            # Add the file to the record
            file_record.add file_to_include

            # Add the file at the match index and repeat
            file.insert(match, FileParse.parse(file_to_include, file_record, options))
          end
        end
      end
      file
    end

    # Log helper
    def self.log(message)
      puts message
    end
  end

  class Compiler
    def initialize(filepath)
      @file = filepath
    end

    def self.compile(filepath)
      listing = Dir.glob("#{filepath}.{js,coffee}")

      if listing.empty?
        raise "File #{filepath} in #{Dir.pwd} does not exist."
      else
        @file = listing.first
      end

      compiler = Compiler.new(@file)

      case File.extname @file
      when '.coffee'
        compiler.compile_coffee
      when '.ts'
        compiler.compile_typescript
      when '.js'
        File.read(@file)
      end
    end

    def compile_coffee
      `cat #{@file} | coffee -scb`
    end

    def compile_typescript
      # Because TypeScript doesn't offer a STDIN option we have to hack it up with tmp files
      Dir.mkdir('tmp')
      `cp #{@file} tmp/#{@file}`
      `tsc tmp/#{@file}`
      compiled = `cat tmp/#{@file}`
      `rm -rf tmp`
      compiled
    end
  end
end
