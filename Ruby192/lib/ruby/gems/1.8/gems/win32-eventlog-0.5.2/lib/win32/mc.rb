# The Win32 module serves as a namespace only.
module Win32
   
   # The MC class encapsulates the mc (eventlog message compiler) commands.
   class MC
      
      # Raised if any of the MC methods fail.
      class Error < StandardError; end;
      
      # The version of the win32-mc library.
      VERSION = '0.1.5'
		
      # The name of the message category file initially processed.
      attr_accessor :mc_file
      
      # The name of the resource file generated by the mc command.
      attr_accessor :res_file
      
      # The name of the dll file generated by the link command.
      attr_accessor :dll_file
		
		# Accepts three file names as arguments and returns an MC object.  The
      # +mc_file+ is the name of the .mc file to be used to ultimately
      # generate the .dll file.
      #
      # If +res_file+ or +dll_file+ are not specified, then the basename
      # of +mc_file+ is used to generate their names, with .res and .dll
      # extensions, respectively.
      # 
      def initialize(mc_file, res_file=nil, dll_file=nil)
         @mc_file = mc_file
			
         if res_file
            @res_file = res_file
         else
            @res_file = File.basename(mc_file, '.mc') + '.res'
         end
			
         if dll_file
            @dll_file = dll_file
         else
            @dll_file = File.basename(mc_file, '.mc') + '.dll'
         end
      end
		
		# Uses the message compiler (mc) program to generate the .h and .rc
		# files based on the .mc (message category) file.  This method must
		# be called before MC#create_res_file or MC#create_dll_file.
		# 
      def create_header
         system("mc #{@mc_file}")
      end
		
		# Creates the .res (resource) file from the .rc file generated by the
		# MC#create_header method.  Raises an MC::Error if the .rc file is not
		# found.
      # 
      def create_res_file
         rc_file = File.basename(@mc_file, '.mc') + '.rc'
         unless File.exists?(rc_file)
            raise MC::Error, "No .rc file found: #{@rc_file}"
         end
         system("rc -r -fo #{@res_file} #{rc_file}")
      end
		
		# Creates the .dll file from the .res file generated by the
		# MC#create_res_file method.  Raises an MC::Error if the .res file is not
		# found.
		# 
      def create_dll_file
         unless File.exists?(@res_file)
			   raise MC::Error, "No .res file found: #{@res_file}"
         end
         system("link -dll -noentry -out:#{@dll_file} #{@res_file}")
      end
		
		# A shortcut for MC#create_header + MC#create_res_file +
		# MC#create_dll_file.
		# 
      def create_all
         create_header
         create_res_file
         create_dll_file
      end
		
		# Delete .h, .rc and .res files created from the corresponding
		# .mc file (but *not* the .dll file).  This also deletes all MSG*.bin
		# files in the current directory.
		#
      def clean
         base = File.basename(@mc_file, '.mc')
         %w/.h .rc .res/.each do |ext|
            file = base + ext
            File.delete(file) if File.exists?(file)
         end
         Dir["MSG*.bin"].each do |binfile|
            File.delete(binfile)
         end
      end
   end
end

if $PROGRAM_NAME == __FILE__
	mc_file = ARGV[0]
	
	if mc_file
	   mc_file.chomp!
	else
		msg = "Usage: ruby mc.rb 'filename.mc'"
		raise Win32::MC::Error, msg
	end
	
	m = Win32::MC.new(mc_file)
	m.create_header
	m.create_res_file
	m.create_dll_file
	puts "MC finished"
end