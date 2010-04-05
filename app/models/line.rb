class Line < ActiveRecord::Base

  serialize :stations

  #def stations
    #self[:stations] ? Marshal.load(self[:stations]) : nil
  #end

  #def stations=(value)
    #self[:stations] = Marshal.dump(value)
  #end

end
