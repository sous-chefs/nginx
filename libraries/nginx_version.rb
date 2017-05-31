class NginxVersion
  include Comparable

  attr_reader :version

  def initialize(version)
    @version = version
  end

  def <=>(other)
    lhsegments = segments
    rhsegments = other.segments

    parts = [lhsegments.size, rhsegments.size].max

    (0..(parts - 1)).each do |index|
      lhs = lhsegments[index] || 0
      rhs = rhsegments[index] || 0

      next if lhs == rhs

      return lhs <=> rhs
    end

    0
  end

  def to_s
    version
  end

  protected

  def segments
    version.split('.').map { |part| Integer(part) }
  end
end
