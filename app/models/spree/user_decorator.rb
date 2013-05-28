Spree::User.class_eval do
  attr_accessible :first_name, :last_name, :phone, :health_issues, :fitness_goals, :fitness_routines, :cats_attributes
  attr_accessible :newsletter
  has_many :cats
  accepts_nested_attributes_for :cats, allow_destroy: true, :reject_if => proc { |attributes| attributes['name'].blank? }

  FITNESS_GOALS =  ['Lose weight', 'Increase energy', 'Build muscle', 'Gain flexibility']
  def cats_or_build
    cats.present? || [cats.new]
  end
  def fitness_goals
    read_attribute(:fitness_goals).to_s.split(", ")
  end
  def fitness_goals=(v)
    if v.is_a?(Array)
      write_attribute(:fitness_goals, v.join(', '))
    else
      write_attribute(:fitness_goals, v)
    end
  end

end
