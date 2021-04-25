
class MixColumns
  def initialize(target=nil)
    @target = target || TARGET
  end

  def calculate!(type='binary')
    transform_target
    result = calculate
    if (type == 'hex')
      result.map! {|r| r.map! {|v| "#{bin_to_hex(v[..3])}#{bin_to_hex(v[4..])}"}}
    end
    result
  end

  private

  attr_reader :target

  CONSTANT = [[2, 3, 1, 1], [1, 2, 3, 1], [1, 1, 2, 3], [3, 1, 1, 2]]
  TARGET = %w[
    01110011
    01111110
    10010111
    11001101
    00111101
    01000100
    00001100
    01100100
    00010111
    00010011
    01011101
    11000100
    11101100
    00011001
    10100111
    01011111
  ]

  def calculate
    result = []
    4.times do |i|
      row = []
      4.times do |k|
        value = 0
        4.times do |j|
          c = CONSTANT[i][j]
          t = target[k][j]

          cur_val = case c
                    when 2
                      calmemo[t] ||= calculate_2(t).to_s(2).rjust(8, '0')
                      calmemo[t]
                    when 3
                      calmemo[t] ||= calculate_2(t).to_s(2).rjust(8, '0')
                      xor(calmemo[t], t)
                    else
                      t
                    end
          value ^= cur_val.to_i(2)
        end
        row << value.to_s(2).rjust(8, '0')
      end
      result << row
    end
    result
  end

  def bin_to_hex(n)
    n.to_i(2).to_s(16)
  end

  def xor(a, b)
    (a.to_i(2) ^ b.to_i(2)).to_s(2).rjust(8, '0')
  end

  def calculate_2(t)
    num = t.to_i(2)
    if '10000000'.to_i(2) <= num
      ((num << 1) ^ '100000000'.to_i(2)) ^ '00011011'.to_i(2)
    else
      num << 1
    end
  end

  def calmemo
    @calmemo ||= {}
  end

  def transform_target
    if target.length == 16
      transformed_target = []
      transformed_target << target[..3]
      transformed_target << target[4..7]
      transformed_target << target[8..11]
      transformed_target << target[12..]
      @target = transformed_target
    end
    raise 'form error!' unless target.length == 4
  end
end
