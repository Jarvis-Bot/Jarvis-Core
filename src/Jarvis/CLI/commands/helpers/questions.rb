class Questions
  def initialize(theme, announce = nil)
    print "\n"
    puts Rainbow(announce).color(:yellow) unless announce.nil?
    @answers = {}
    @theme = theme.to_s
  end

  def question(var, question)
    print Rainbow("#{question} : ").color(:magenta)
    @answers[var.to_s] = $stdin.gets.chomp.strip
  end

  def results
    { @theme => @answers }
  end
end
