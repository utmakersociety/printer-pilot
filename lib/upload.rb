module Uploader
  class Upload
    class << self
      def process(file)
        now = Date.today
        # generate a random filename and strip whitespace
        new_filename =  SecureRandom.urlsafe_base64(nil, false).strip
        month = format("%02i", now.month)
        path = "#{Dir.pwd}/public/uploads/#{now.year}/#{month}/#{now.mday}"
        FileUtils.mkdir_p(path)
        # create a path if it doesn't exist and write tmp file
        target = "#{path}/#{new_filename}.stl"
        FileUtils.mv(file, target)
        uploaded = File.file?(target)
        relative_path = "uploads/#{now.year}/#{month}/#{now.mday}/#{target}"
        
        if uploaded
          {
            filename: File.basename(file),
            type: "application/sla",
            size: File.size(target),
            path_name: relative_path,
            uploaded: uploaded
          }
        else
          nil
        end
      end
    end
  end
end