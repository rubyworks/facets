# Title:
#
#   Quaternion
#
# Copyright:
#
#   Copyright (c) 2002 K. Kodama
#
# Authors:
#
#   K. Kodama
#
# TODO: The following documentation should occur before the methods
# they describe.

require "mathn"
require "complex"

# = Quaternion
#
# NOTE This Quaternion class is still very experimental.
#
# Quaternions are attributed to Sir William Rowan Hamilton
# who find it in 1843, and published a major analysis in 1844 called
# "On a Species of Imaginary Quantities Connected with a Theory of Quaternions"
# in the Proceedings of the Royal Irish Academ. (2, pp 424-434).
#
# Typical quaternion number q is of the form q = r + a i + b j + c k.
# Bases i j k behaves as follows:
#
#   i^2 = j^2 = k^2 = -1
#   i j = k, j k = i, k i = j
#   j i = -k, k j = -i, i k = -j
#
# Quaternion numbers are not Commutative.
# Quaternion is 4-D space over Real number,
# and 2-D space over Complex numbers as q = (a + b i) + (c + d i)j.
#
# === Polar Coordinates
#
# A Quaternion q = r + a i + b j + k c have 1st level polar form such that
#
#    q = |q|(cos t1 + sin t1 u1) , where u1 is unit vector of u1 = a1 i + b1 j + c1 k.
#
# u1 have 2nd level
#
#    u1 = i cos t2 + sin t2 u2, where u2 is unit vector of u2 = b2 j + c2 k.
#
# And u2 have 3rd level
#
#    u2 = j cos t3 + k sin t3.
#
# So we have
#
#    q=|q|( cos t1 + sin t1 ( i cos t2 + sin t2 ( j cos t3 + k sin t3 )))
#
# The equivalent to polar coordinates in quaternion space are
#
#   r = |q| cos(t1)
#   a = |q| sin(t1) cos(t2)
#   b = |q| sin(t1) sin(t2) cos(t3)
#   c = |q| sin(t1) sin(t2) sin(t3)
#
# |q| is known as the magnitude of the quaternion, t1 is the amplitude(or angle),
# t2 and t3 are the latitude (or co-latitude) and longitude respectively.
#
# === Vector
#
# A Quaternions q= r + a i + b j + c k is 4-D space over Real numbers.
# A Quaternions with zero real part q = a i + b j + c k is 3-D space,
# and called a vector quaternion or, simply, vector.
# For q = r + a i + b j + c k,
# v=a i + b j + c k is called vector part of q.
# A vector u of |u|=1 is called  a unit vector.
# We can write q = r + u |v| = |q|(cos t + u sin t).
# Note that u^2=-1.
# Vectors are 3-D space And can define cross-product q1 x q2.
#
# === Rotation
#
# Quaternion can be used to describe rotation in 3-D space.
# For a vector v and a Quaternion q = |q|(cos t/2 + u sin t/2),
# q v q^(-1) is a vector v t-rotated along u.
# Composit rotation of q1, q2 is described as q2 q1,
# because q2 (q1 v q1^(-1)) q2^(-1) = (q2 q1) v (q2 q1)^(-1).
#
# === GCD
#
# D4 lattice space is lattice points of Quaternion q = r + a i + b j + c k as follows.
# (1) r,a,b,c are all integer, or
# (2) r,a,b,c are all half-integer.
# D4 is sub-ring of Quaternion with GCD.
# (Ring means a space with +, -, *.)

=begin

* Building quaternions and taking them apart
Quaternion(real number r)  #  r as quaternion
Quaternion(a+bi)  #  a+bi as quaternion
Quaternion(a+bi,c+di)  #  a+bi+cj+dk = (a+bi)+(c+di)j
Quaternion(a,b=0,c=0,d=0)  #   a+bi+cj+dk
Quaternion(quaternion number  q)  #  return q
Quaternion::Zero  (=0 as quaternion)
Quaternion::One   (=1 as quaternion)
Quaternion::I     (=i as quaternion)
Quaternion::J     (=j)
Quaternion::K     (=k)
q.re      ( = real part of q)
q.real ( = real part of q)
q.real_part ( = real part of q)
q.im    ( = i part of q)
q.image     ( = i part of q)
q.jm    ( = j part of q)
q.km    ( = k part of q)
orthogonal_split(o)
  return [q1,q2].
  q = q1 + q2 such that q1 parallel to o, and q2 orthogonal to o.

* Vector
q.vector    ( = vector part of q = non-real part of q)
q.unit_vector ( = unit vector of q)
Quaternian::vector(v)
  # 3-D vector v=[x,y,z] as array to Quaternion vector
Quaternion::rotation(v,t)
  # t-rotatin along the 3-D vector v
q.rotate(r)
  rotate by r = q r^(-1)
q.rotate_angle
  # = q.amplitude/2

* Polar notation
Quaternion::polar(m,t1=0,t2=0,t3=0)
q.magnitude  (= |q|)
q.amplitude (=arg1)
q.latitude  (=arg2)
q.longitude (=arg3)
q.arg1
q.arg2
q.arg3
q.abs    ( = |q| )
q.abs2  ( = |q|^2 )
q.polar   # get array of [magnitude, amplitude, latitude, longitude]

* Boolean
Quaternion::generic?(other)
q.is_vector?      # have no real part
q.is_unit_vector?   # q is vector and |q|=1
q.is_complex?     # j part =0 and k part = 0
q.is_quaternion?     # have j or k part
q.is_real?     # i,j,k parts are all 0

* Arithmetic
q.conjugate   (= q~)
q.inverse     (=1/q)
q1<=>q2     ( same as  |q1|<=>|q2| )
q1==q2
q1 + q2
q1 - q2
q1 * q2
q1 / q2
q1.dot_product(q2)   (Dot product q1, q2 = (q1*q2.conjugate).real_part )
q1.cross_product(q2) (Cross product as vectors q1,q2)
   Assume q1, q2 be 3-D vectors.
q1.rdiv(q2) # right division: q1/q2 (same as /)
q1.ldiv(q2) # left division: 1/q1 * q2

* lattice or D4-lattice
q.round #  round to integer coefficients
q.round_D4 # round to D4 lattice
q1.divmod(q2) # right divmod: q1=d*q2+m
q1.ldivmod(q2) # left divmod: q2=q1*d+m
q1 % q2 # right mod
q1.rmod(q2) # right mod(same as %)
q1.lmod(q2) # left mod
divmod_D4 other # right divmod: q1=d*q2+m, d be D4 value
ldivmod_D4 other # left divmod: q2=q1*d+m, d be D4 value
rmod_D4 other # right mod with d be D4 value
lmod_D4 other # left mod with d be D4 value
q1.gcd(q2) # Asume that q1, q2 are D4 value

* Exponential and logarithmic functions
q.exp # e^(r+uv)=exp(r)(cos(v)+u*sin(v))
q.log #  log(r+uv)=1/2 log(r^2+v^2)+u atan(v/w)
q1**q2  ( = q1^q2 )
q.sqrt   ( = q^1/2 )
q.sinh
q.cosh
q.tanh

* Trigonometric functions
q.sin
q.cos
q.tan

* Inverse trigonometric functions
q.asin
q.acos
q.atan

* Conversion
to_s   #  get string
to_c  #  real and i part as complex
to_c2  #  j and k part as complex
to_v  # vector part as array
to_a   # array of parts

* Other
q.hash
q.inspect
=end

def Quaternion(a=0, b=0,c=0, d=0)
  if a.kind_of?(Quaternion);
    a;
  elsif a.kind_of?(Complex) and b.kind_of?(Complex);
    Quaternion.new(a.real, a.image, b.real, b.image)
  elsif a.kind_of?(Complex);
    Quaternion.new(a.real, a.image)
  else
    Quaternion.new(a,b,c,d);
  end
end

module_function :Quaternion

class Quaternion < Numeric
  attr :re
  attr :im
  attr :jm
  attr :km
  def image; return @im; end
  def real_part; return @re; end
  def real; return @re; end
  def to_c; return Complex(@re,@im); end
  def to_c2; return Complex(@jm,@km); end
  def to_a; return [@re, @im, @jm, @km]; end
  def Quaternion::generic?(other)
    return (other.kind_of?(Complex) or Complex.generic?(other));
  end
  def initialize(a=0,b=0,c=0,d=0)
    raise "non numeric 1st arg `#{a.inspect}'" if !a.kind_of? Numeric;
    raise "non numeric 2nd arg `#{b.inspect}'" if !b.kind_of? Numeric;
    raise "non numeric 3rd arg `#{c.inspect}'" if !c.kind_of? Numeric;
    raise "non numeric 4th arg `#{d.inspect}'" if !d.kind_of? Numeric;
    @re=a; @im=b; @jm=c; @km=d
  end
  private :initialize

  Zero=Quaternion(0)
  One=Quaternion(1)
  I=Quaternion(0,1)
  J=Quaternion(0,0,1)
  K=Quaternion(0,0,0,1)

  def Quaternion::polar(m,t1=0,t2=0,t3=0)
    # q=
    #   m*cos(t1)
    #   +m*sin(t1)cos(t2)i
    #   +m*sin(t1)sin(t2)cos(t3)j
    #   +m*sin(t1)sin(t2)sin(t3)k
    # m is known as the magnitude,
    # t1 is the amplitude(or angle) of the quaternion,
    # t2 and t3 are the latitude (or co-latitude) and longitude respectively.
    if m.kind_of?(Array) and (m.size==4); t1=m[1]; t2=m[2]; t3=m[3]; m=m[0]; end;
    s=m
    r_part=s*Math.cos(t1); s=s*Math.sin(t1)
    i_part=s*Math.cos(t2); s=s*Math.sin(t2)
    j_part=s*Math.cos(t3); k_part=s*Math.sin(t3)
    new(r_part, i_part, j_part, k_part)
  end
  def amplitude; Math.atan2(Math.sqrt((@im*@im+@jm*@jm+@km*@km).to_f),@re.to_f); end
  def latitude; Math.atan2(Math.sqrt((@jm*@jm+@km*@km).to_f),@im.to_f); end
  def longitude; Math.atan2( @km.to_f, @jm.to_f); end
  def arg1; return amplitude; end
  def arg2; return latitude; end
  def arg3; return longitude; end
  def polar; [magnitude, amplitude, latitude, longitude]; end

  def round; Quaternion(@re.round,@im.round,@jm.round,@km.round);end
  def round_D4
    # round to D4 lattice
    r1=@re.round; a1=@im.round; b1=@jm.round; c1=@km.round;
    q1=Quaternion(r1,a1,b1,c1); d1=(q1-self).abs2
    if d1<=1/4; return q1; end
    if @re<r1; r2=r1-1/2; else r2=r1+1/2; end
    if @im<r1; a2=a1-1/2; else a2=a1+1/2; end
    if @jm<r1; b2=b1-1/2; else b2=b1+1/2; end
    if @km<r1; c2=c1-1/2; else c2=c1+1/2; end
    q2=Quaternion(r2,a2,b2,c2); d2=(q2-self).abs2
    if d1<=d2; return q1; else return q2; end
  end
  def abs2; return @re*@re+@im*@im+@jm*@jm+@km*@km; end
  def abs; Math.sqrt((@re*@re+@im*@im+@jm*@jm+@km*@km).to_f); end
  def magnitude; return abs; end
  def conjugate; Quaternion(@re,-@im,-@jm,-@km); end
  def inverse; conjugate/abs2; end

  def is_real?; @im==0 and @jm==0 and @km==0; end
  def is_complex?; @jm==0 and @km==0; end
  def is_quaternion?; not(is_complex?); end

  def vector; Quaternion(0,@im,@jm,@km); end
  def is_vector?; @re==0; end
  def to_v; return [@im, @jm, @km]; end
  def Quaternion::vector(v)
    # 3-D vector v=[x,y,z]
    Quaternion(0,v[0],v[1],v[2])
  end
  def unit_vector
    if is_real?; return Quaternion(0,1); end
    m=Math::sqrt((@im*@im+@jm*@jm+@km*@km).to_f)
    Quaternion(0,@im/m,@jm/m,@km/m);
  end
  def is_unit_vector?; @re==0 and abs2==1; end
  def Quaternion::rotation(v,t)
    # t-rotatin along the 3-D vector v
    (Quaternion::vector(v).unit_vector) * Math::sin(t/2) + Math::cos(t/2)
  end
  def rotate(r); r * self * r.conjugate / r.abs2; end
  def rotate_angle; amplitude/2; end

  # Arithmetic
  def coerce(other)
    if other.kind_of?(Complex); return Quaternion(other), self
    elsif Complex::generic?(other); return Quaternion(other), self
    else super
    end
  end
  def <=> (other); self.abs <=> other.abs; end
  def == (other)
    if other.kind_of?(Quaternion)
      return (@re==other.re and @im==other.im and @jm==other.jm and @km==other.km)
    elsif other.kind_of?(Complex)
      @re==other.real and @im==other.image and @jm==0 and @km==0
    elsif Complex.generic?(other)
      @re==other and @im==0 and @jm==0 and @km==0
    else x , y = other.coerce(self); x == y
    end
  end
  def + (other)
    if other.kind_of?(Quaternion)
      Quaternion(@re+other.re,@im+other.im,@jm+other.jm,@km+other.km)
    elsif other.kind_of?(Complex)
      Quaternion(@re+other.real,@im+other.image, @jm, @km)
    elsif Complex.generic?(other)
      Quaternion(@re+other.real,@im, @jm, @km)
    else x , y = other.coerce(self); x + y
    end
  end
  def - (other)
    if other.kind_of?(Quaternion)
      Quaternion(@re-other.re,@im-other.im,@jm-other.jm,@km-other.km)
    elsif other.kind_of?(Complex)
      Quaternion(@re-other.real,@im-other.image, @jm, @km)
    elsif Complex.generic?(other)
      Quaternion(@re-other.real,@im, @jm, @km)
    else x , y = other.coerce(self); x - y
    end
  end
  def * (other)
    if other.kind_of?(Quaternion)
      Quaternion(@re*other.re-@im*other.im-@jm*other.jm-@km*other.km,
           @re*other.im+@im*other.re+@jm*other.km-@km*other.jm,
           @re*other.jm-@im*other.km+@jm*other.re+@km*other.im,
           @re*other.km+@im*other.jm-@jm*other.im+@km*other.re)
    elsif other.kind_of?(Complex)
      Quaternion(@re*other.real - @im*other.image,
           @re*other.image + @im*other.real,
           @jm*other.real + @km*other.image,
           @km*other.real - @jm*other.image)
    elsif Complex.generic?(other)
      Quaternion(@re * other, @im * other, @jm * other, @km * other)
    else x , y = other.coerce(self); x * y
    end
  end
  def dot_product other
    (self*other.conjugate).re
  end
  def cross_product other
    -(self*other.conjugate).vector
  end
  def / other
    if other.kind_of?(Quaternion); self*other.conjugate/other.abs2
    elsif other.kind_of?(Complex); self*other.conjugate/other.abs2
    elsif Complex.generic?(other);
      Quaternion(@re/other, @im/other, @jm/other, @km/other )
    else x, y = other.coerce(self); x / y
    end
  end
  def rdiv other
    # right division: q1/q2
    self/other
  end
  def ldiv other
    # left division: 1/q1 * q2
    (self.conjugate)*other/self.abs2
  end
  def divmod other
    # right divmod: q1=d*q2+m
    d=self.rdiv(other).round; m=self-d*other; return d,m
  end
  def divmod_D4 other
    # right divmod: q1=d*q2+m, d be D4
    d=self.rdiv(other).round_D4; m=self-d*other; return d,m
  end
  def ldivmod other
    # left divmod: q2=q1*d+m
    d=self.ldiv(other).round; m=other-self*d; return d,m
  end
  def ldivmod_D4 other
    # left divmod: q2=q1*d+m, d be D4
    d=self.ldiv(other).round_D4; m=other-self*d; return d,m
  end
  def % other
    # right mod
    d,m=divmod(other); return m
  end
  def rmod other
    # right mod(same as %)
    d,m=divmod(other); return m
  end
  def rmod_D4 other
    # right mod with D4
    d,m=divmod_D4(other); return m
  end
  def lmod other
    # left mod
    d,m=ldivmod(other); return m
  end
  def lmod_D4 other
    # left mod with D4
    d,m=ldivmod_D4(other); return m
  end
  def gcd other
    a=self; b=other
    while true
      if b==0 ; return a;end
      a=a.rmod_D4(b)
      if a==0 ; return b;end
      b=a.lmod_D4(b)
    end
  end
  def orthogonal_split(o)
    # [q1,q2]. q = q1 + q2 such that q1 parallel to o, and q2 orthogonal to o.
    q1 = o * dot_product(o); q2=self-q1; return q1,q2
  end

  # Exponential and logarithmic functions
  def exp
    # e^(r+uv)=exp(r)(cos(v)+u*sin(v))
    if is_real?; return Quaternion(Math::exp(@re)); end
    vec=self.vector; v=vec.abs; u = vec/v;
    Math::exp(@re)*(Math::cos(v)+u*Math::sin(v))
  end
  def log
    # log(r+uv)=1/2 log(r^2+v^2)+u atan(v/r)
    if is_real?;
      if @re>=0; return Quaternion(Math::log(@re));
      else return Quaternion(Math::log(-@re),Math::PI,0,0);
      end
    end
    vec=self.vector; v=vec.abs; u = vec/v;
    Math::log(self.abs2.to_f)/2+u*Math::atan2( v, @re)
  end
  def ** other
    # q1^q2 = exp((log q1)*q2)
    if other.kind_of?(Quaternion); ((self.log)*other).exp
    elsif other.kind_of?(Complex); ((self.log)*other).exp
    elsif other.kind_of?(Integer);
      if other==0; return One;
      elsif other>0;
        x = self; q = x; n = other - 1
        while n != 0
          while (d, m = n.divmod(2); m == 0); x = x*x; n = d; end
          q *= x; n -= 1
        end
        return q
      else return self.inverse**(-other)
      end
    elsif Quaternion::generic?(other); ((self.log)*other).exp
    else x, y = other.coerce(self); x ** y
    end;
  end
  def sqrt; self**(0.5); end
  def sinh; e=exp; return (e-e.inverse)/2; end
  def cosh; e=exp; return (e+e.inverse)/2; end
  def tanh; e=exp; e=e*e; return (e-1)/(e+1); end
  #  Trigonometric functions
  def sin
    # sin(r+uv)=sin r cosh v + u cos r sinh v
    vec=self.vector; v=vec.abs; if v==0; return Quaternion(Math::sin(@re)); end
    u = vec/v; e=Math::exp(v); er=1/e; c=e+er; s=e-er
    (Math::sin(@re)*c+u*Math::cos(@re)*s)/2
  end
  def cos
    # cos(r+uv)=cos r cosh v - u sin r sinh v
    vec=self.vector; v=vec.abs; if v==0; return Quaternion(Math::cos(@re)); end
    u = vec/v; e=Math::exp(v); er=1/e; c=e+er; s=e-er
    (Math::cos(@re)*c-u*Math::sin(@re)*s)/2
  end
  def tan
    vec=self.vector; v=vec.abs; if v==0; return Quaternion(Math::tan(@re)); end
    u = vec/v; e=Math::exp(v); er=1/e; c=e+er; s=e-er
    co=Math::cos(@re); si=Math::sin(@re);  (si*c+u*co*s)/(co*c-u*si*s)
  end

  # Inverse trigonometric functions
  def asin
    # asin q = -u log(uq+sqrt(1-q^2))
    q=self; u=unit_vector; -u*((u*q+(1-q*q).sqrt).log)
  end
  def acos
    # acos q = -u log(q+sqrt(q^2-1))
    q=self; u=unit_vector; -u*((q+(q*q-1).sqrt).log)
  end
  def atan
    # atan q = u/2 log( (u+q)/(u-q)  )
    q=self; u=q.unit_vector; u*((u+q)/(u-q)).log/2
  end


  def hash; @re^@im^@jm^@km; end

  def inspect
    sprintf("Quaternion(%s,%s,%s,%s)",
        @re.inspect, @im.inspect, @jm.inspect, @km.inspect)
  end
  def to_s
    s=""
    if @re!=0; s=@re.to_s; end
    if @im!=0;
      if s==""; s=sprintf("%si", @im);
      else if @im>0; s=sprintf("%s+%si",s,@im); else s=sprintf("%s-%si",s,-@im); end
      end
    end
    if @jm!=0;
      if s==""; s=sprintf("%sj", @jm);
      else if @jm>0; s=sprintf("%s+%sj",s,@jm); else s=sprintf("%s-%sj",s,-@jm); end
      end
    end
    if @km!=0;
      if s==""; s=sprintf("%sk", @km);
      else if @km>0; s=sprintf("%s+%sk",s,@km); else s=sprintf("%s-%sk",s,-@km); end
      end
    end
    if s=="" ; s="0"; end;
    return s
  end

end # Quaternion

