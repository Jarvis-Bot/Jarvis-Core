class Questions
  def initialize(theme, announce = nil)
    print "\n"
    puts Rainbow(announce).color(:yellow) unless announce.nil?
    @answers = {}
    @theme = theme.to_s
  end

  def ask(var, question, hint = nil)
    print Rainbow("#{question} ").color(:magenta)
    print Rainbow("(#{hint})").color(:cyan) unless hint.nil?
    print Rainbow(': ').color(:magenta)
    @answers[var.to_s] = $stdin.gets.chomp.strip
  end

  def results
    { @theme => @answers }
  end
end
