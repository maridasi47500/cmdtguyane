
class Calendar
  def initialize
    @firstdaythismonth=Date.today.beginning_of_month
    @firstday = @firstdaythismonth.monday
    @firstdaynextmonth=Date.today.next_month
    @lastday = @firstdaynextmonth.end_of_month.sunday
    @weeks = (@firstday..@lastday).to_a.each_slice(7).to_a
p @weeks
begin
    w1= @weeks.select {|x| x[6].month == @firstdaythismonth.month || x[0].month == @firstdaythismonth.month}
    @m1=Month1.new(@firstdaythismonth, w1)
rescue => e
  p "ok"
end
begin
    w2= @weeks.select {|x| x[6].month == @firstdaynextmonth.month || x[0].month == @firstdaynextmonth.month}
    @m2=Month1.new(@firstdaynextmonth, w2)
rescue => e
  p "ok"
end
    self

  end
  def weeks
    @weeks
  end
  def mois
    [@m1,@m2]
  end
  def firstmonth
    @m1
  end
  def secondmonth
    @m2
  end

end
class Jour1
  def initialize(h)
    @date=h
    @monthid=I18n.l(@date, format: :monthid)
    @dayid=I18n.l(@date, format: :dayid)
    @daynb=@date.day
    self

  end
  def dayid
    @dayid
  end
  def daynumber
    @daynb
  end

  def monthid
    @monthid
  end

end
class Semaine1
  def initialize(jours)
    @jours=jours.map{|x|Jour1.new(x)}
    self
  end
  def joursem
    @jours
  end
end
class Month1
  def initialize(firstday,weeks)
    @firstday = firstday
    @weeks1 = weeks.map {|x| Semaine1.new(x)}

    @monthid=I18n.l(@firstday, format: :monthid)
    @dayid=I18n.l(@firstday, format: :dayid)
    @name=I18n.l(@firstday, format: :nomdumois)
    self

  end
  def monthid
    @monthid
  end
  def dayid
    @dayid
  end

  def weeks
    @weeks1
  end
  def name
    
    @name
  end
end

