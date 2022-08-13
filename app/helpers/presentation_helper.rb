class Jour1
  def initialize(h,mth)
    @month=mth
    @date=h
    @fromthismonth = @month == @date.month

    @monthid=I18n.l(@date, format: :monthid)
    @monthname=I18n.l(@date, format: :nomdumois)
    @dayid=I18n.l(@date, format: :dayid)
    @daynb=@date.day
    @daytoday=@date== Date.today

  end
  def fromthismonth
    @fromthismonth
  end
  def dayid
    @dayid
  end
  def ajd
    @date
  end
  def daytoday
    @daytoday
  end
  def daynumber
    @daynb
  end
  def monthname
    @monthname
  end

  def monthid
    @monthid
  end

end
class Semaine1
  def initialize(jours,mth)
    @month = mth
    @jours=jours.map{|x|Jour1.new(x,@month)}
    
  end
  def month
    @month
  end
  def joursem
    @jours
  end
end
class Month1
  def initialize(firstday,weeks)
    @weeks1 = weeks.map {|x| Semaine1.new(x,firstday.month)}
    @firstday = firstday
    @year=@firstday.year
    @monthnumber=@firstday.month
    @monthyear =@firstday.year

    @nextmonth=@firstday.next_month
    @prevmonth=@firstday.prev_month
    @nextmonthname=I18n.l(@nextmonth, format: :nomdumois)
    @nextmonthvalue=@nextmonth.month
    @nextmonthyear =@nextmonth.year
    @nextmonthid =I18n.l(@nextmonth, format: :monthid)
    @nextmonthshortid =I18n.l(@nextmonth, format: :monthshortid)
    @prevmonthname=I18n.l(@prevmonth, format: :nomdumois)
    @prevmonthvalue=@prevmonth.month
    @prevmonthyear =@prevmonth.year
    @prevmonthid =I18n.l(@prevmonth, format: :monthid)
    @prevmonthshortid =I18n.l(@prevmonth, format: :monthshortid)

    @monthid=I18n.l(@firstday, format: :monthid)
    @monthshortid=I18n.l(@firstday, format: :monthshortid)
    @dayid=I18n.l(@firstday, format: :dayid)
    @name=I18n.l(@firstday, format: :nomdumois)

  end
  def year
    @year
  end
  def prevmonthname
    @prevmonthname
  end
  def prevmonthid
    @prevmonthid
  end
  def prevmonthshortid
    @prevmonthshortid
  end

  def prevmonthvalue
    @prevmonthvalue
  end
  def prevmonthyear
    @prevmonthyear
  end

  def nextmonthname
    @nextmonthname
  end

  def nextmonthvalue
    @nextmonthvalue
  end
  def nextmonthyear
    @nextmonthyear
  end
  def monthnumber
    @monthnumber
  end
  def nextmonthid
    @nextmonthid
  end
  def nextmonthshortid
    @nextmonthshortid
  end
  def monthshortid
    @monthshortid
  end
  def monthyear
    @monthyear
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
  def monthname
    
    @name
  end

  def name
    
    @name
  end
end

class Calendar
  def initialize(year=nil,month=nil)
    @today= year && month ? Date.new(year.to_i,month.to_i,1) : Date.today
    @firstdaythismonth=@today.beginning_of_month
    @lastdaythismonth=@today.end_of_month.sunday
    @firstday = @firstdaythismonth.monday
    @firstdaynextmonth=@today.next_month
    @firstdayprevmonth=@today.prev_month
    @lastday = @firstdaynextmonth.end_of_month.sunday
    @weeks = (@firstday..@lastday).to_a.each_slice(7).to_a
    p @weeks
    @m1=Month1.new(@today, @weeks.select {|x| x[6].month == @today.month || x[0].month == @today.month})
    @m2=Month1.new(@firstdaynextmonth, @weeks.select {|x| x[6].month == @firstdaynextmonth.month || x[0].month == @firstdaynextmonth.month})

  end
  def weeks
    @weeks
  end
  def mois
    [@m1]
  end
  def firstmonth
    @m1
  end
  def secondmonth
    @m2
  end

end

module PresentationHelper
  
end