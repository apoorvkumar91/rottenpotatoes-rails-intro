class Movie < ActiveRecord::Base

  def self.ratings
    ans = Array.new
    select(:rating).uniq.each do |m|
      
        ans.push(m.rating)
      
    end
    return ans
  end

end
