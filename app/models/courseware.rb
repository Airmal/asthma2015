class Courseware < ActiveRecord::Base
  require 'fileutils'
  require 'RMagick'

  belongs_to :uploader, class_name: 'User'
  belongs_to :program
  validates :uploader_id, :type_of_courseware, :name, :program_id, presence: true
  validates :remote_url, presence: true, if: :is_live_courseware?, on: [:create, :update]
  before_save :reset_remote_or_local
  before_update :reset_time_line
  
  serialize :time_line

  TYPE = {
    video: 1, # 视频类型
    document: 2, # 文档类型
    remote_video_with_local_doc: 3 # 远端视频+本地文档，通常用于直播
  }

  REMOTE_OR_LOCAL = {
    remote: 1, # 远端
    local: 2, # 本地
    both: 3 # 同时
  }

  has_attached_file :courseware_file, 
    :url => "/system/programs/temp.pdf",
    :path => ":rails_root/public:url"
    validates_attachment_content_type :courseware_file, :content_type => ['application/pdf']
    before_post_process :delete_temp_pdf
    after_commit :convert_pdf_to_png
    # add a delete_<asset_name> method: 
    attr_accessor :delete_courseware_file
    before_validation { self.courseware_file.clear if self.delete_courseware_file == '1' }

  has_attached_file :file_path, 
    :url => "/system/programs/:id/:id.:extension",
    :path => ":rails_root/public:url"
    validates_attachment_content_type :file_path, :content_type => ["video/mp4"]

  protected
    def reset_time_line
      courseware = Courseware.find(self.id)
      if self.time_line.present? && self.offset_time.present?
        array = Array.new
        for time in time_line
          array.push(time.to_i + offset_time.to_i - courseware.offset_time)
        end
        self.time_line = array
      end
    end

    def is_live_courseware?
    	return self.type_of_courseware == TYPE[:remote_video_with_local_doc]
    end

    def reset_remote_or_local
      if self.type_of_courseware == TYPE[:remote_video_with_local_doc]
        self.remote_or_local = REMOTE_OR_LOCAL[:remote]
      end
    end

    def delete_temp_pdf
      temp_file = "public/system/programs/temp.pdf"
      if File.exists?(temp_file)
          File.delete(temp_file)
      end
    end 

    def convert_pdf_to_png
      program_path = "public#{Settings.programs_images_url}#{self.program_id}/"
      pdf_file = "#{program_path}#{self.program_id}.pdf"
      temp_file = "public/system/programs/temp.pdf"

      if File.exists?(temp_file)

        # 删除既存图片
        Dir.foreach(program_path) do |item|
          if item.start_with?("live_") 
            File.delete("#{program_path}#{item}")
          end
        end

        # 复制pdf到当前program下
        copy_with_path(temp_file, pdf_file)

        # 切割pdf
        pdf = Magick::ImageList.new(pdf_file) do
          self.quality = 80
          self.density = '100'
          self.interlace = Magick::NoInterlace
        end

        $global_redis.set("program_#{self.program_id}_total_page_number", pdf.count);

        pdf.each_with_index do |img, i|
          file_png = program_path+"live_" + i.to_s.rjust(2, "0")+".png"
          img.write file_png
        end
        File.delete(temp_file)        
      end
    end

    def copy_with_path(src, dst)
      FileUtils.mkdir_p(File.dirname(dst))
      FileUtils.cp(src, dst)
    end
end
