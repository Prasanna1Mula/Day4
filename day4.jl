struct OurRational{T<:Integer} <: Real
    num::T
    den::T
    function OurRational{T}(num::T, den::T) where T<:Integer
        if num == 0 && den == 0
             error("invalid rational: 0//0")
        end
        num = flipsign(num, den)
        den = flipsign(den, den)
        g = gcd(num, den)
        num = div(num, g)
        den = div(den, g)
        new(num, den)
    end
end

struct SummedArray{T<:Number, S<:Number}
    data::Vector{T}
    sum::S
end 

struct SummedArray{T<:Number, S<:Number}
    data::Vector{T}
    sum::S
    function SummedArray(a::Vector{T}) where T 
        S = widen(T)
        new{T,S}(a, sum(s,a))
    end
end 

julia> struct Foo
       bar
       baz
       end

julia> foo = Foo(1,2)
Foo(1, 2)

julia> foo.bar
1

julia> foo.baz
2

julia> Foo(x) = Foo(x,x)
Foo

julia> Foo(1)
Foo(1, 1)

julia> Foo() = Foo(0)
Foo

julia> Foo()
Foo(0, 0)
julia> struct OrderedPair
       x::Real
       y::Real
       OrderedPair(x,y) = x > y ? error("out of order") : new(x,y)
       end

julia> OrderedPair(1,2)
OrderedPair(1, 2)

julia> OrderedPair(2,1)
ERROR: out of order
Stacktrace:
 [1] error(s::String)
   @ Base .\error.jl:35
 [2] OrderedPair(x::Int64, y::Int64)
   @ Main .\REPL[9]:4
 [3] top-level scope
   @ REPL[11]:1

julia> struct Foo
       bar
       baz
       Foo(bar, baz) = new(baz, bar)
       end

julia> struct T1
       x::Int64
       end

julia> struct T2
       x::Int64
       T2(x) = new(x)
       end

julia> T1(1)
T1(1)

julia> T2(1)
T2(1)

julia> T1(1.0)
T1(1)

julia> T2(2.3)
ERROR: InexactError: Int64(2.3)
Stacktrace:
 [1] Int64
   @ .\float.jl:994 [inlined]
 [2] convert
   @ .\number.jl:7 [inlined]
 [3] T2(x::Float64)
   @ Main .\REPL[14]:3
 [4] top-level scope
   @ REPL[18]:1

julia> mutable struct SelfReferential
       obj::SelfReferential
       end

julia> b = SelfReferential(a)
ERROR: UndefVarError: `a` not defined in `Main`
Suggestion: check for spelling errors or missing imports.      
Stacktrace:
 [1] top-level scope
   @ REPL[20]:1

julia> b = SelfReferential(a)
ERROR: UndefVarError: `a` not defined in `Main`
Suggestion: check for spelling errors or missing imports.      
Stacktrace:
 [1] top-level scope
   @ REPL[20]:1

julia> mutable struct SelfReferential
       obj::SelfReferential
       SelfRefrencial() = (x = new(); x.obj = x)
       end
ERROR: invalid redefinition of constant Main.SelfReferential
Stacktrace:
 [1] top-level scope
   @ REPL[21]:1

julia> x = SelfReferential();
ERROR: MethodError: no method matching SelfReferential()
The type `SelfReferential` exists, but no method is defined for this combination of argument types when trying to construct it.

Closest candidates are:
  SelfReferential(::SelfReferential)
   @ Main REPL[19]:2
  SelfReferential(::Any)
   @ Main REPL[19]:2

Stacktrace:
 [1] top-level scope
   @ REPL[22]:1

julia> x === x
ERROR: UndefVarError: `x` not defined in `Main`
Suggestion: check for spelling errors or missing imports.      
Stacktrace:
 [1] top-level scope
   @ REPL[23]:1

julia> mutable struct SelfReferential
       obj::SelfReferential
       SelfReferential() = (x = new(); x.obj = x)
       end
ERROR: invalid redefinition of constant Main.SelfReferential
Stacktrace:
 [1] top-level scope
   @ REPL[24]:1

julia> mutable struct Incomplete
       data
       Incomplete() = new()
       end

julia> z = Incomplete();

julia> struct HasPlain
       n::Int
       HasPlain() = new()
       end

julia> HasPlain()
HasPlain(0)

julia> mutable struct Lazy
       data
       Lazy(v) = complete_me(new(), v)
       end

julia> struct Point{T<:Real}
       x::T
       y::T
       Point{T}(x,y) where {T<:Real} = new(x,y)
       end

julia> Point(x::T, y::T) where {T<Real} = Point{T}(x,y);       
ERROR: syntax: invalid variable expression in "where" around REPL[31]:1
Stacktrace:
 [1] top-level scope
   @ REPL[31]:1

julia> p = Point(1,2.5)
ERROR: MethodError: no method matching Point(::Int64, ::Float64)
The type `Point` exists, but no method is defined for this combination of argument types when trying to construct it.
Stacktrace:
 [1] top-level scope
   @ REPL[32]:1

julia> OurRational(n::T, d::T) where {T<:Integer} = OurRational{T}(n,d)
OurRational

julia> OurRationl(n::Integer, d::Integer) = OurRational(n, one(n))
OurRationl (generic function with 1 method)

ERROR: UndefVarError: `Vctor` not defined in `Main`
Suggestion: check for spelling errors or missing imports.      
Stacktrace:
 [1] top-level scope
   @ c:\Users\Dell\OneDrive\Desktop\Day4\day4.jl:17

        
julia> SummedArray(Int32[1;2;3], Int32(6))
SummedArray{Int32, Int32}(Int32[1, 2, 3], 6)

        
julia> SummedArray(Int32[1;2;3], Int32(6))
SummedArray{Int32, Int32}(Int32[1, 2, 3], 6)

julia> methods(Bool)
# 10 methods for type constructor:
  [1] Bool(x::BigFloat)
     @ Base.MPFR mpfr.jl:393
  [2] Bool(x::Float16)
     @ Base float.jl:356
  [3] Bool(x::Rational)
     @ Base rational.jl:149
  [4] Bool(x::Real)
     @ Base float.jl:251
  [5] (dt::Type{<:Integer})(ip::Sockets.IPAddr)
     @ Sockets C:\Users\Dell\.julia\juliaup\julia-1.11.3+0.x64.w64.mingw32\share\julia\stdlib\v1.11\Sockets\src\IPAddr.jl:11
  [6] (::Type{T})(x::Enum{T2}) where {T<:Integer, T2<:Integer} 
     @ Base.Enums Enums.jl:19
  [7] (::Type{T})(z::Complex) where T<:Real
     @ Base complex.jl:44
  [8] (::Type{T})(x::Base.TwicePrecision) where T<:Number
     @ Base twiceprecision.jl:265
  [9] (::Type{T})(x::T) where T<:Number
     @ boot.jl:900
 [10] (::Type{T})(x::AbstractChar) where T<:Union{AbstractChar, Number}
     @ char.jl:50
