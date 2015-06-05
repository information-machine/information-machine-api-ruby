

module InformationMachineApi 
  class JSONable
    
    # Creates JSON of the curent object  
    def to_json
      hash = {}
      self.instance_variables.each do |var|
        hash[var.to_s.delete "@"] = self.instance_variable_get var
      end
      hash.to_json
    end

  end
end