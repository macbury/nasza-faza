class Rate < ActiveRecord::Base
  belongs_to :ratable, :polymorphic => true
  
  def self.names
    ['Żałosne','Słabe', 'Znośne', 'Dobre', 'Dobre jak wino', 'LOL']
  end
end
