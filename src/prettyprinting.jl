function subscript(i::Integer)
    return i < 0 ? error("$i is negative") :
           string(Iterators.reverse('₀' + d for d in digits(i))...)
end
function superscript(i::Integer)
    if i < 0
        throw(ArgumentError("$i is negative"))
    else
        # for some reason superscript two and three are not in the logical spots of the table
        return string(map(Iterators.reverse(digits(i))) do x
                          return x == 2 ? '²' : x == 3 ? '³' : '⁰' + x
                      end...)
    end
end

# Show and friends
# ----------------
function Base.show(io::IO, ::MIME"text/plain", ::Type{FR{R,M,N,I}}) where {R,M,N,I}
    if get(io, :compact, true)
        if M == 1
            print(io, "FR$(superscript(R)) $(superscript(N))$(subscript(I))")
        else
            print(io,
                  "FR$(superscript(R)) $(superscript(M)) $(superscript(N))$(subscript(I))")
        end
    else
        show(io, FR{R,M,N,I})
    end
end

function Base.show(io::IO, ::MIME"text/plain", ::Type{UFC{R,M,N,I,D}}) where {R,M,N,I,D}
    if get(io, :compact, true)
        if M == 1
            print(io,
                  "UFC$(superscript(R)) $(superscript(N))$(subscript(I)) $(subscript(D))")
        else
            print(io,
                  "UFC$(superscript(R)) $(superscript(M)) $(superscript(N))$(subscript(I)) $(subscript(D))")
        end
    else
        show(io, UFC{R,M,N,I,D})
    end
end

function Base.show(io::IO, ::MIME"text/plain",
                   ::Type{PMFC{R,M,N,I,D₁,D₂}}) where {R,M,N,I,D₁,D₂}
    if get(io, :compact, true)
        if M == 1
            print(io,
                  "PMFC$(superscript(R)) $(superscript(N))$(subscript(I)) $(subscript(D₁)) $(subscript(D₂))")
        else
            print(io,
                  "PMFC$(superscript(R)) $(superscript(M)) $(superscript(N))$(subscript(I)) $(subscript(D₁)) $(subscript(D₂))")
        end
    else
        show(io, PMFC{R,M,N,I,D₁,D₂})
    end
end

function Base.show(io::IO, ::MIME"text/plain", ψ::Object{FR}) where {FR<:FusionRing}
    if get(io, :typeinfo, Any) !== Object{FR}
        print(io, ψ.id, "∈ 𝒪(", FR, ")")
    else
        print(io, ψ.id)
    end
end
