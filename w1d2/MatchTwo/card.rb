class Card
  attr_accessor :face_value, :face_up

  def initialize(face_value)
    @face_value = face_value
    @face_up = false
  end

  def hide
    self.face_up = false
  end

  def reveal
    self.face_up = true
  end

  def to_s
    if face_up
      face_value
    else
      "__"
    end
  end

  def ==(other_card)
    self.face_value == other_card.face_value
  end

end
