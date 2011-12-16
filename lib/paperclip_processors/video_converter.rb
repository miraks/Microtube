module Paperclip
  class VideoConverter < Processor
    def initialize(file, options = {}, attachment = nil)
      super
      @whiny = options[:whiny].nil? ? true : options[:whiny]
      @basename = File.basename(file.path, File.extname(file.path))
    end

    def make
      video = Tempfile.new([@basename, 'flv'].compact.join('.'))

      command = "-i #{File.expand_path(file.path)} -ar 44100 -ab 128k -ac 2 -f flv -b 800k -r 25 -vf \"scale=-1:360\" -g 25 -y #{File.expand_path(video.path)} >/dev/null 2>&1"

      begin
        Paperclip.run('ffmpeg', command)
      rescue StandardError => e
        raise PaperclipError, "error while converting your video" if @whiny
      end

      video
    end
  end
end
