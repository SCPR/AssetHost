module Paperclip
  class Trimmer < Processor
    def initialize(file, options={}, attachment=nil)
      super

      @current_format   = File.extname(@file.path)
      @basename         = File.basename(@file.path, @current_format)
    end

    # This class is meant to help trim off letterboxing from
    # YouTube poster images. YouTube always delivers a 4:3 poster
    # image (the HQ version), and adds black edges if the video
    # doesn't fit.
    def make
      source = @file
      destination = Tempfile.new(@basename)

      Paperclip.run("convert",
        ":source " \
        "-quality 100 " \
        "-bordercolor \"#000000\" " \
        "-border 1x1 " \
        "-fuzz 10% " \
        "-trim +repage " \
        ":dest",
        :source => File.expand_path(source.path),
        :dest   => File.expand_path(destination.path)
      )

      destination
    end
  end
end
