% Scott Joplin, "Solace" (1909). Mutopia Project edition, placed in the public domain
% by the typesetter. The files of the original edition joined into one for SUNSET RUN.
\include "english.ly"
barRest =  {\skip 2 |}
myBreak =  {} % ... { \break }
myMark =  {} %... {\mark\default}
paperOFF = { \set Score.skipTypesetting = ##t }
paperON = { \set Score.skipTypesetting = ##f }
csrh = { \change Staff = "rh" }
cslh = { \change Staff = "lh" }
ohs = { \once\override Stem.transparent = ##t }
ohh = { \once\override NoteHead.transparent = ##t }
% ---- header.ly
\version "2.19.15"
\header {
                                % LILYPOND HEADERS
    head =  "0.05 (09 Jan 2015)"

    %% dedication = "Dedication"
    title = "Solace"
    subtitle = "A Mexican Serenade"
    %% subsubtitle = "Subsubtitle"

    composer = "Scott Joplin (1868-1905)"
    %% opus = "Opus"
    %% arranger = "Arranger"

    %% poet = "Poet"
    %% texttranslator = "Translator"
    %% meter = "meter"

    %% instrument = "Instrument"
    %% piece = "Piece"

                                % LILYPOND FOOTERS
    license = "Public Domain"
    %% tagline = "Tagline"


                                % MUTOPIA HEADERS
    mutopiatitle = "Solace"
    mutopiacomposer = "JoplinS"
    mutopiainstrument = "Piano"
    date = "1909"
    source = "Original Manuscript (1909)"
    style = "Jazz"
    enteredby = "Magnus Lewis-Smith"
    maintainer = "Magnus Lewis-Smith"
    maintainerEmail = "mlewissmith@users.sourceforge.net"
    maintainerWeb = "http://magware.sourceforge.net/"

 footer = "Mutopia-2015/01/25-482"
 copyright =  \markup { \override #'(baseline-skip . 0 ) \right-column { \sans \bold \with-url #"http://www.MutopiaProject.org" { \abs-fontsize #9  "Mutopia " \concat { \abs-fontsize #12 \with-color #white \char ##x01C0 \abs-fontsize #9 "Project " } } } \override #'(baseline-skip . 0 ) \center-column { \abs-fontsize #11.9 \with-color #grey \bold { \char ##x01C0 \char ##x01C0 } } \override #'(baseline-skip . 0 ) \column { \abs-fontsize #8 \sans \concat { " Typeset using " \with-url #"http://www.lilypond.org" "LilyPond" " by " \maintainer " " \char ##x2014 " " \footer } \concat { \concat { \abs-fontsize #8 \sans{ " Placed in the " \with-url #"http://creativecommons.org/licenses/publicdomain" "public domain" " by the typesetter " \char ##x2014 " free to distribute, modify, and perform" } } \abs-fontsize #13 \with-color #white \char ##x01C0 } } }
 tagline = ##f
}




%{
BUGLIST
*	http:
*	category:  projects/lily
*	group:     sources/lily/joplin_solace


FEATURE REQUEST
*	http:
*	category:  projects/lily
*	group:     sources/lily/joplin_solace

Some interesting Scott Joplin links:
*    http:
*    http:
*    http:
*    http:
%}

% ---- intro.ly
\version "2.19.15"
introGlobal =  {
    \time 2/4
    \repeat unfold 4 {\barRest}
%    \bar "||" % no-instead use \bar".|:-||" at start of next block
    \myBreak
}

introRHnotes =  \relative c'' {
    \clef treble
    \slurUp
    \once \override TextScript.extra-offset = #'(-3 . 1)
    c8.\mf^\markup{\larger \bold{"Very slow march time"}}( d16) e( ds) e8 |
    \stemUp
    g8.( a16) g8 a16( b) |
    c8.( ds,16) e( gs, a8) |
    \stemNeutral
    \slurNeutral
    a8( g4) c8 |
}

introLHnotes =  \relative c' {
    \clef bass
    \stemDown
    c8.( d16) e( ds) e8 |
    \slurDown
    \csrh g8.( a16) g8 a16( b) |
    c8.( ds,16) { \override Beam.damping = #100000 % horizontal beam for this bit
                  e( \cslh gs, a8)
                  \revert Beam.damping } |
    \stemNeutral
    \slurNeutral
    f8( e4) e16( ef) |
}

introRH =  {
    <<
        \introGlobal
        \introRHnotes
    >>
}

introLH =  {
    <<
        \introGlobal
        \introLHnotes
    >>
}

% ---- partOne.ly
\version "2.19.15"
partOneGlobal =  {
    \repeat volta 2 {
                                % 5 - 19
        \bar ".|:-||"
        \barRest | \barRest | \barRest | \barRest |
        \myBreak
        \barRest | \barRest | \barRest | \barRest |
        \myBreak
        \barRest | \barRest | \barRest | \barRest |
        \myBreak
        \barRest | \barRest | \barRest |
    }
    \alternative {
                                % 20
        { \barRest | }
                                % 21
        { \barRest | }
    }
    \myBreak
}

partOneRHnotes =  \relative b' {
    \repeat volta 2 {
                                % 5 - 8
        b16\mf( bf a g~g gs a as) |
        b( <d f> <cs g'> <d f>)~<d f>( <cs g'> <d f> b) |
        c( b a g)~g( gs a b) |
        c( <e g> <ds a'> <e g>)~<e g>( <ds a'> <e g> cs) |

                                % 9 - 12
        d( f a <d f,>)~<d f,> f,( e d)~ |
        d <af d, c>8 <g d b>16~<g d b>8^( d') |
        c16( e g <c e,>)~<c e,> e,( d c)~ |
        c <fs, c>8 <g e c>16~<g e c>8^( c) |

                                % 13 - 16
        b16( bf a g~g gs a as) |
        b( <d f> <cs g'> <d f>)~<d f>( <cs g'> <d f> b) |
        c( b a g~g gs a b) |
        c( <e g> <ds a'> <e g>)~<e g>( <ds a'> <e g> bf) |

                                % 17 - 19
        a <a' f>8 <c a f c>16~<c a f c>(\< <b b,> <c c,> <d d,>)\! |
        <ds c a ds,>4->~<d c a d,>8( <af f c af>) |
        <g e c g>4~<g e c g>16 <d f d'>8( <e g e'>16) |
    }
    \alternative {
                                % 20
        \relative c'' {<c e c'>4 e16( d c8) |}

                                % 21
        \relative c'' {<c e c'>8 e16(\< f) <g e>8 <gs e>-^\! |}
    }
}

partOneLHnotes =  \relative d {
    \repeat volta 2 {
                                % 5 - 8
        << { d8. g16 <b f'>8 d, } \\
           { d4. d8 } >> |
        << { g,8. g'16 <b f'>8 ds, } \\
           { g,4.( ds'8) } >> |
        << { e8. g16 <c e>8 g } \\
           { e4.( g8) } >> |
        << { c,8. g'16 <c e>8 e, } \\
           { c4.( e8) } >> |

                                % 9 - 12
        << { d8. f16 <d' f>8 a } \\
           { d,4.( a'8)} >> |
        f8 f d16( e f8) |
        << { e8. g16 <c e>8 g } \\
           { e4.( g8) } >> |
        ds8( e) c16( d e ef) |

                                % 13 - 16
        << { d8. g16 <b f'>8 d, } \\
           { d4. d8 } >> |
        << { g,8. g'16 <b f'>8 ds, } \\
           { g,4.( ds'8) } >> |
        << { e8. g16 <c e>8 g } \\
           { e4.( g8) } >> |
        << { c,8. g'16 <c e>8 c, } \\
           { c4. c8 } >> |

                                % 17 - 19
        << { f8. a16 <c f>8 a } \\
           { f4.( a8) } >> |
        fs'4->( f) |
        r16 e,( f fs) << { g16 b8. } \\ { g8( g,) } >> |
    }
    \alternative {
                                % 20
        \relative c { <c c'>16( e f fs g f e ef) | }

                                % 21
        \relative c { <c c'>8 r r <c bf'>-^ | }
    }
}

partOneRH =  {
    <<
        \partOneGlobal
        \partOneRHnotes
    >>
}

partOneLH =  {
    <<
        \partOneGlobal
        \partOneLHnotes
    >>
}
% ---- partTwo.ly
\version "2.19.15"
partTwoGlobal =  {
    \repeat volta 2 {
        %% BARS 22 - 38
                                % ridiculous silent grace notes to prevent extra barline from drawing
        \grace{s8.}\barRest | \barRest | \barRest | \barRest |
        \myBreak
        \barRest | \barRest | \barRest | \barRest |
        \myBreak
        \barRest | \barRest | \barRest | \barRest | \barRest |
        \myBreak
        \barRest | \barRest |
    }
    \alternative {
        {\barRest |}
        {\barRest |}
    }
    \myBreak
    \bar "||"
}

partTwoRHnotes =  \relative f'' {
    \repeat volta 2 {
                                % 22 - 25
        << { \stemNeutral <f a>8 c32( d e f \stemUp g16)( f8) \tuplet 3/2 { f32 g f } } \\
                                % ridiculous silent grace notes to prevent extra barline from drawing
           { \grace { s8.\f } s4 a,8. af16 } >> |
        <af f'>16\> <g e'> <g e'> <fs c' ds>\!~<fs c' ds>8 <f b d> |
        <e as cs>4\mp( <f b d>8) <e b' e> |
        <e a c e>8 e'16(\< f) <e g>8 <e gs>-^\! |

                                % 26 - 29
        << { \stemNeutral <f a>8 c32( d e f \stemUp g16)( f8) \tuplet 3/2 { f32 g f } } \\
           { s4\f a,8. af16 } >> |
        <af f'>16 <g e'> <g e'> <g c e>~<g c e>8 <g bf e> |
        << { e'16( d e b)~b( d a8) } \\
           { <g b>8. g16~g8 <fs c> } >> |
        << { a8( g4) } \\
           { <f b,>4 } >>  <b d g>8 |

                                % 30 - 33
        << { g'16( f8) e16 } \\
           { <d a>4 } >> <f d f,>16( <g e g,> <a f a,> <as f as,>) |
        <b f d b>4. <g? d b>8 |
        << { g16( f8) e16 } \\
           { <d a>4 } >> <f d f,>16( <g e g,> <a f a,> <as f as,>) |
        <b f d b>4. <b f d b>8 |

                                % 34 - 36
        <c e, c>4~<c e, c>16 <c c,>( <d d,> <e e,>) |
        <e a, e>8( <d a d,>4) <f, d c f,>8\mp |
        \stemDown
        <f d b f>8 <g d b g>~<g d b g>16 g,( <f b e>8) |
        \stemNeutral
    }
    \alternative {
        \relative c'' {
                                % 37
            <c e,>8 e16(\< f) <g e>8 <gs e>\!-^ |
        }
        \relative c'' {
                                % 38
            <c e,>4 e16(d c8) |
        }
    }
}

partTwoLHnotes =  \relative f, {
    \repeat volta 2 {
                                % 22 - 25
        << { f8. a'16 <c f>8 f,, } \\
           { \appoggiatura { c16[ d e] } f4.\sustainOn f8\sustainOff } >> |
        << { c'8. a'16 <c ds>8 af8 } \\
           { \appoggiatura { g,16[ a b] } c4.( af'8) } >> |
        \appoggiatura { e16[ f fs] }
%        \override Slur.attachment = #'(head . stem)
        g8. g16( g,8) gs |
%        \revert Slur.attachment
        << { a8. a'16 <c e>8 bf-^ } \\
           { a,4.( c8) } >> |

                                % 26 - 29
        << { f,8. a'16 <c f>8 f,, } \\
           { \appoggiatura { c16[ d e] } f4.\sustainOn f8\sustainOff } >> |
        << { c'8. a'16 <c e>8 cs,8 } \\
           { \appoggiatura { g16[ a b] } c4.( cs8) } >> |
        << { d8. g16 <b d>8 d, } \\
           { d4. s8 } >> |
        << { g,8. g'16 <b f'>8 g, } \\
           { g4. g8 } >> |

                                % 30 - 33
        << { d'8. f16 <a d>8 d, } \\
           { d4. d8} >> |
        << { gs,8. gs'16 <b d f>8 <g g,> } \\
           { gs,4.\sustainOn g8\sustainOff } >> |
        << { d'8. f16 <a d>8 d, } \\
           { d4. d8} >> |
        << { gs,8. gs'16 <b d f>8 gs, } \\
           { gs4.\sustainOn gs8\sustainOff } >> |

                                % 34 - 36
        << { a8. a'16 <c e>8 a, } \\
           { a4.\sustainOn a8\sustainOff } >> |
        << { f8. a'16 <d f>8 <af af,> } \\
           { f,4.( af8) } >> |
        << { g'8. g16 <b f'>8 <g g,> } \\
           { <g, g'>4.\sustainOn g8\sustainOff } >> |
    }
    \alternative {
        \relative c {
                                % 37
            <c g'>8 r r <c bf'>-^ |
        }
        \relative c {
                                % 38
            <c g'>16 e( f fs g f e ef) |
        }
    }
}

partTwoRH =  {
    <<
        \partTwoGlobal
        \partTwoRHnotes
    >>
}

partTwoLH =  {
    <<
        \partTwoGlobal
        \partTwoLHnotes
    >>
}
% ---- partThree.ly
\version "2.19.15"
partThreeGlobal =  {
                                % 39 - 42
    \barRest | \barRest | \barRest | \barRest |
    \myBreak
                                % 43 - 46
    \barRest | \barRest | \barRest | \barRest |
    \myBreak
                                % 47 - 50
    \barRest | \barRest | \barRest | \barRest |
    \myBreak
                                % 51 - 54
    \barRest | \barRest | \barRest | \barRest |
    \myBreak
%    \bar "||" % no-use \bar ".|:-||" at next block
}

partThreeRHnotes =  \relative b' {
                                %39 - 42
    b16\mf( bf a g~g gs a as) |
    b( <d f> <cs g'> <d f>)~<d f>( <cs g'> <d f> b) |
    c( b a g)~g( gs a b) |
    c( <e g> <ds a'> <e g>)~<e g>( <ds a'> <e g> cs) |

                                % 43 - 46
    d( f a <d f,>)~<d f,> f,( e d)~ |
    d <af d, c>8 <g d b>16~<g d b>8 d' |
    c16( e g <c e,>)~<c e,> e, d c~ |
    c <fs, c>8 <g e c>16~<g e c>8 c |

                                % 47 - 50
    b16( bf a g~g gs a as) |
    b( <d f> <cs g'> <d f>~<d f> <cs g'> <d f> b) |
    c( b a g~g gs a b) |
    c( <e g> <ds a'> <e g>)~<e g>( <ds a'> <e g> bf) |

                                % 17 - 19
    a <a' f>8 <c a f c>16~<c a f c>(\< <b b,> <c c,> <d d,>)\! |
    <ds c a ds,>4->~<d c a d,>8( <af f c af>) |
    <g e c g>4~<g e c g>16 <d f d'>8( <e g e'>16) |
    <c e c'>4~<c e c'>8\> <e, bf>\! |
}

partThreeLHnotes =  \relative d {
                                %39 - 42
    << { d8. g16 <b f'>8 d, } \\
       { d4. d8 } >> |
    << { g,8. g'16 <b f'>8 ds, } \\
       { g,4.( ds'8) } >> |
    << { e8. g16 <c e>8 g } \\
       { e4.( g8) } >> |
    << { c,8. g'16 <c e>8 e, } \\
       { c4.( e8) } >> |

                                % 43 - 46
    << { d8. f16 <d' f>8 a } \\
       { d,4.( a'8)} >> |
    f8 f d16( e f8) |
    << { e8. g16 <c e>8 g } \\
       { e4.( g8) } >> |
    ds8( e) c16( d e ef) |

                                % 47 - 50
    << { d8. g16 <b f'>8 d, } \\
       { d4. d8 } >> |
    << { g,8. g'16 <b f'>8 ds, } \\
       { g,4.( ds'8) } >> |
    << { e8. g16 <c e>8 g } \\
       { e4.( g8) } >> |
    << { c,8. g'16 <c e>8 c, } \\
       { c4. c8 } >> |

                                % 17 - 19
    << { f8. a16 <c f>8 a } \\
       { f4.( a8) } >> |
    fs'4->( f) |
    r16 e,( f fs) << { g16 b8. } \\ { g8( g,) } >> |
    <c c'>8 g'16 c,~c8 c |
}

partThreeRH =  {
    <<
        \partThreeGlobal
        \partThreeRHnotes
    >>
}

partThreeLH =  {
    <<
        \partThreeGlobal
        \partThreeLHnotes
    >>
}
% ---- partFour.ly
\version "2.19.15"
partFourGlobal =  {
    \repeat volta 2 {
                                % 55 - 58
        \bar ".|:-||"
        \barRest | \barRest | \barRest | \barRest |
        \myBreak
                                % 59 - 62
        \barRest | \barRest | \barRest | \barRest |
        \myBreak
                                % 63 - 66
        \barRest | \barRest | \barRest | \barRest |
        \myBreak
                                % 67 - 69
        \barRest | \barRest | \barRest |
    }
    \alternative {
                                % 70
        {\barRest |}
                                % 71
        {\barRest |}
    }
    \myBreak
%    \bar "||" % no-use \bar ".|:-||" at next block
}

partFourRHnotes =  \relative f' {
    \key f \major
    \repeat volta 2 {
                                % 55 - 58
        << { f4~ <f c>16( a <a d f>8) } \\
           { \once\override DynamicText.extra-offset = #'(0 . -1)
             a,16(\mp bf b c)~ \ohs c8 s8  } >>  |
        << { s8. \ohs bf'16~ bf bf <d f>8 } \\
           { <g, d' f>8. <g bf>16~ g8 g} >> |
        << { s8. \ohs e'16~ e ds e8 } \\
           { <f d g,>8. <e c g>16~ <c g>8 <bf g> } >> |
        <f a e'>8. <f a>16~ <f a>8 <e bf>\fermata |

                                % 59 - 62
        << { f4^\markup{\bold "a tempo"}~ f16( a c d) } \\
           { a,16( bf b c\<)~ c8( a'8\!)  } >>  |
        << { e'4~ e16( ds) e8 } \\
           { r16\mf c( b a)~ a8 <e a c> } >> |
        << { e'4~ e16 ds e8 } \\
           %% [mils] Want to shift this rest a little to the right.
           { b16\rest b( a gs)~ gs8 <gs e> } \\
           { \stemDown e4. s8 } >> |
        <e a e'>4~ <e a e'>8 <e bf>\mp\fermata |

                                % 63 - 66
        << { f4^\markup{\bold "a tempo"}~ <f c>16( a <a d f>8) } \\
           { a,16( bf b c)~ \ohs c8 s8  } >>  |
        << { s8. \ohs bf'16~ bf bf <d f>8 } \\
           { <g, d' f>8. <g bf>16~ g8 g} >> |
        << { s8. \ohs e'16~ e ds e8 } \\
           { <f d g,>8. <e c g>16~ <c g>8 <bf g> } >> |
        <f a e'>8. <f a>16~ <f a>8 <f a> |

                                % 67 - 69
        << { <f bf>8. <f bf>16~ bf( c bf8) } \\
           { s8. \ohs f16~ f8 f } >> |
        <f a>16 <f a>8 <f gs>16~ <f gs>8 <f gs d'> |
        << { d'16 c8 bf16~ <bf e, d>8 <a e c> } \\
           { <a f>8. <e d>16~
             \once\override NoteColumn.force-hshift = #1
             \ohs \tieNeutral<e d>8 s8 } >> |
    }
    \alternative {
                                % 70
        { <f a,>4. <e bf>8\fermata | }
                                % 71
        { \stemUp <f a,>4~ <f a,>8\< d'16(\fermata f)\! \stemNeutral | }
    }
}

partFourLHnotes =  \relative f {
    \key f \major
    \repeat volta 2 {
                                % 55 - 58
        f16( g gs a)~ a( f d c) |
        << { bf16( bf' c d)~ d8 bf, } \\
           { bf4. bf8 } >> |
        << { c16( g' a bf)~ bf8 c,,} \\
           { c'4. c,8 } >> |
        << { f16( gs' a c)~ c8 c,\fermata } \\
           { f,4.( c'8) } >> |

                                % 59 - 62
        f16( g gs a)~ a8( f) |
        << { r16 e'( d c)~ c4 } \\
           { e,4~ e16( a e c) } >> |
        << { r16 d'( c b)~ b8 b8 } \\
           { e,,4~ e8 e'} >> |
        << { c'4~ c8 c, } \\
           { a'8( e16 a,)~ a8 c\fermata } >> |

                                % 63 - 66
        f16( g gs a)~ a( f d c) |
        << { bf16( bf' c d)~ d8 bf, } \\
           { bf4. bf8 } >> |
        << { c16( g' a bf)~ bf8 c,,} \\
           { c'4. c,8 } >> |
        << { f16( gs' a c)~ c8 ef, } \\
           { f,4.( ef'8) } >> |

                                % 67 - 69
        d16( f bf d)~ d8( df) |
        c16 c8 b16~ b8 b |
        c8. c,16~ c4 |
    }
    \alternative {
                                % 70
        { f8.([ c16 f,8)] c'8\fermata }
                                % 71
        { f8.([ c16 f,8)] af8\fermata }
    }
}

partFourRH =  {
    <<
        \partFourGlobal
        \partFourRHnotes
    >>
}

partFourLH =  {
    <<
        \partFourGlobal
        \partFourLHnotes
    >>
}
% ---- partFive.ly
\version "2.19.15"
partFiveGlobal =  {
    \repeat volta 2 {
                                % 72 - 75
        \bar ".|:-||"
        \barRest | \barRest | \barRest | \barRest |
        \myBreak
                                % 76 - 79
        \barRest | \barRest | \barRest | \barRest |
        \myBreak
                                % 80 - 83
        \barRest | \barRest | \barRest | \barRest |
        \myBreak
                                % 84 - 86
        \barRest | \barRest | \barRest |
    }
    \alternative {
                                % 87
        {\barRest |}
                                % 88
        {\barRest |}
    }
    \myBreak
    \bar "|."
}

partFiveRHnotes =  \relative b'' {
    \repeat volta 2 {
                                % 72 - 75
        <bf f>16\f <bf e,> <bf ds,> <bf e,>~ <bf e,> <bf ds,>8 <bf e,>16 |
        <bf f>16 <bf e,> <bf ds,> <bf e,>~ <bf e,> <bf ds,>8 <bf e,>16 |
        <a e>16 <a d,> <a cs,> <a d,>~ <a d,>4~ |
        <a d,>4~ <a d,>16 <d, a>8 <c a>16 |

                                % 76 - 79
        <c a>16( <bf g> <a fs> <bf g>)~ <bf g> <a fs>8 <bf g>16 |
        <c a>16( <bf g> <a fs> <bf g>)~ <bf g> <a fs>8 <bf g>16 |
        <bf g>16 <a f?> <bf g> <c a>~ <c a>4~ |
        <c a>4 ~ <c a>8 d16(\fermata f) |

                                % 80 - 83
        <bf f>16 <bf e,> <bf ds,> <bf e,>~ <bf e,> <bf ds,>8 <bf e,>16 |
        <bf f>16 <bf e,> <bf ds,> <bf e,>~ <bf e,> <bf ds,>8 <bf e,>16 |
        \context Voice = "lower" { <a e>16 <a d,> <a cs,> <a d,>~ <a d,>4~} |
        << \context Voice = "upper" { \stemUp\tieUp\slurUp \ohs a4 ~ a16 a( f ef) } \\
           \context Voice = "lower" { \stemDown\tieNeutral <a d,>4~ \tieDown d,16 c8. } >> |

                                % 84 - 86
        << { d16( f d f)~ f f8( d16) }\\
           { bf 8. gs16~ gs gs8. } >> |
        << { d'16( f d c)~ c f8( g16) } \\
           { a,8. a16~ a bf8. } >> |
        << { s8. \ohs c16~ <c a>16 a8( g?16) } \\
           { <a' c,>16^( <gs b,> <a c,> <c, a>)~ a e8. } >> |
    }
    \alternative {
                                % 87
        { f4. d'16\fermata f | }

                                % 88
        { f,4 <f a c f>8-^ r^\markup{\bold\italic "Fine"}}
    }
}

partFiveLHnotes =  \relative g, {
    \repeat volta 2 {
                                % 72 - 75
        << { g8. g'16 <bf c e>8 c,, } \\
           { g'4. c,8 } >> |
        << { g'8. g'16 <bf c e>8 c,, } \\
           { g'4. c,8 } >> |
        << { f8. a'16 <c f>8 c,, } \\
           { f4. c8} >> |
        << { f16( gs' a d)~ d4 } \\
           { f,,4.( fs8) } >> |

                                % 76 - 79
        << { g8. g'16 <bf c e>8 c,, } \\
           { g'4. c,8 } >> |
        << { g'8. g'16 <bf c e>8 c,, } \\
           { g'4. c,8 } >> |
        << { f8. a'16 <c f>8 c,, } \\
           { f4. c8} >> |
        << { f16 gs'( a c)~ c8 af,\fermata } \\
           { f4. af8 } >> |

                                % 80 - 83
        << { g8. g'16 <bf c e>8 c,, } \\
           { g'4. c,8 } >> |
        << { g'8. g'16 <bf c e>8 c,, } \\
           { g'4. c,8 } >> |
        << { f8. a'16 <c f>8 c,, } \\
           { f4. c8} >> |
        << { f16 gs'( a d)~ d8 f } \\
%           \once\override Slur.attachment = #'(head . stem)
           { f,,4.( a'8) } >> |

                                % 84 - 86
        <bf f'>8. <b f>16~ <b f> <b f>8. |
        << { s8.
             \once\override NoteColumn.force-hshift = #-1.5
             \ohs\ohh
             \tieDown
             ef16~
             \once\override NoteColumn.force-hshift = #-0.6
             ef f8. } \\
           {<c f>8. \tieUp <ef f>16~
             \once\override NoteColumn.force-hshift = #0.6
             f d8( df16) } >> |
        << { s8. \ohs f16~ f c8( bf16) } \\
           { <f' c>8. <f c>16~ c16 c,8. } >> |
    }
    \alternative {
                                % 87
        { << { a'4. r8 } \\
             { f8.([ c16 f,8)] af\fermata } >> | }

                                % 88
        { << { a'4. } \\
             { f8.[ c16 f,8-^] } >> r8 | }
    }
}

partFiveRH =  {
    <<
        \partFiveGlobal
        \partFiveRHnotes
    >>
}

partFiveLH =  {
    <<
        \partFiveGlobal
        \partFiveLHnotes
    >>
}
solaceRH = { \introRHnotes \partOneRHnotes \partTwoRHnotes \partThreeRHnotes \partFourRHnotes \partFiveRHnotes }
solaceLH = { \introLHnotes \partOneLHnotes \partTwoLHnotes \partThreeLHnotes \partFourLHnotes \partFiveLHnotes }
