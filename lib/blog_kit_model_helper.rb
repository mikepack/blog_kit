module BlogKitModelHelper
	def code_highlight_and_markdown(text, options = {})
    text_pieces = text.split(/(<code>|<code lang="[A-Za-z0-9_-]+">|
      <code lang='[A-Za-z0-9_-]+'>|<\/code>)/)
    in_pre = false
    language = nil
    text_pieces.collect do |piece|
      if piece =~ /^<code( lang=(["'])?(.*)\2)?>$/
        language = $3
        in_pre = true
        nil
      elsif piece == "</code>"
        in_pre = false
        language = nil
        nil
      elsif in_pre
        lang = language ? language : "ruby"
        Uv.parse( piece.strip, "xhtml", lang, true, BlogKit.instance.settings['theme'] || 'mac_classic')
      else
        BlueCloth.new(piece).to_html
      end
    end
	end
	
	def user_image_tag
		if self.user && self.user.respond_to?(:blog_image_url) && self.user.blog_image_url
			# Load image from model
			return "<img src=\"#{self.user.blog_image_url}\" />"
		elsif BlogKit.instance.settings['gravatar']
			# Gravatar
			require 'digest/md5'
			if self.respond_to?(:email) && !self.email.blank?
				email = self.email
			elsif self.user && self.user.respond_to?(:email) && !self.user.email.blank?
				email = self.user.email
			else
				return ''
			end
			
			hash = Digest::MD5.hexdigest(email.downcase)
			return "<img src=\"http://www.gravatar.com/avatar/#{hash}.jpg\" />"
		else
			# No Image
			return ''
		end
	end
end