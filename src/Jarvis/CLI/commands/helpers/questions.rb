require 'rainbow'
class Questions
  def initialize(theme, announce = nil)
    print "\n"
    puts Rainbow(announce).color(:yellow) unless announce.nil?
    @answers = {}
    @theme = theme.to_s
  end

  def ask(var, question, hint = nil)
    @last_var = var.to_s
    print Rainbow("#{question} ").color(:magenta)
    print Rainbow("(#{hint})").color(:cyan) unless hint.nil?
    print Rainbow(': ').color(:magenta)
    @answers[var.to_s] = $stdin.gets.chomp.strip
    self
  end

  def add(var, answer)
    @last_var = var.to_s
    @answers[var.to_s] = answer
    self
  end

  def modify(var=nil, &block)
    if var.nil?
      answer = @answers[@last_var]
      answer = yield answer
      @answers[@last_var] = answer
    else
      answer = yield @answers[var.to_s]
      @answers[var.to_s] = answer
    end
    self
  end

  def results
    { @theme => @answers }
  end
end
