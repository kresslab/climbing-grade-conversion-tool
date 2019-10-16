module OverlayContent exposing
    ( Content
    , contentFrench
    , contentInfo
    , contentSkill
    , contentUIAA
    , contentYDS
    )

import Html exposing (Html)
import Html.Attributes exposing (class)
import Markdown
import Messages exposing (..)


type alias Content =
    { body : Html Msg
    , title : String
    }


contentInfo : Content
contentInfo =
    { title = "Welcome to Climbing Grade Conversion Tool"
    , body =
        Markdown.toHtml [ class "overlay__content" ] """
Climbing conversion tool is little utility to help understand climbing grades.

“In rock climbing, mountaineering, and other climbing disciplines, climbers
give a grade to a climbing route or boulder problem, intended to describe
concisely the difficulty and danger of climbing it. Different types of climbing
(such as sport climbing, bouldering or ice climbing) each have their own
grading systems, and many nationalities developed their own, distinctive
grading systems.” -- [wikipedia](http://shorturl.at/krAV4)



Designed and built by [Travis Shears](https://travisshears.com).
"""
    }


contentYDS : Content
contentYDS =
    { title = "Yosemite Decimal System"
    , body =
        Markdown.toHtml [ class "overlay__content" ] """
"The Yosemite Decimal System (YDS) is a three-part system used for rating the difficulty of walks,
hikes, and climbs, primarily used by mountaineers in the United States and Canada. It was first
devised by members of the Sierra Club in Southern California in the 1950s as a refinement of earlier
systems, particularly those developed in Yosemite Valley, and quickly spread throughout North
America." -- [wikipedia](https://en.wikipedia.org/wiki/Yosemite_Decimal_System)
"""
    }


contentUIAA : Content
contentUIAA =
    { title = "Union Internationale des Associations d'Alpinisme Grades"
    , body =
        Markdown.toHtml [ class "overlay__content" ] """
The UIAA grading system[15] is mostly used for short rock routes in Germany, Austria,
Switzerland, Czech Republic, Slovakia and Hungary. On long routes it is often used in the
Alps and Himalaya. Using Roman numerals, it was originally intended to run from I (easiest)
to VI (hardest), but as with all other grading systems, improvements to climbing standards
have led to the system being open-ended after the grade VII was accepted in 1977. An
optional + or − may be used to further differentiate difficulty. As of 2016, the hardest
climbs are XII. -- [wikipedia](http://shorturl.at/hBDX3)
"""
    }


contentFrench : Content
contentFrench =
    { title = "French numerical grades"
    , body =
        Markdown.toHtml [ class "overlay__content" ] """
The French numerical system (distinct from the adjectival system, described later) rates a climb
according to the overall technical difficulty and strenuousness of the route. Grades start at 1
(very easy) and the system is open-ended. Each numerical grade can be subdivided by adding a letter
(a, b or c). Examples: 2, 4, 4b, 6a, 7c. An optional + may be used to further differentiate
difficulty. For example, these routes are sorted by ascending difficulty: 5c+, 6a, 6a+, 6b, 6b+.
Although some countries in Europe use a system with similar grades but not necessarily matching
difficulties, the French system remains the main system used in the vast majority of European
countries and in many international events outside the USA. -- [wikipedia](http://shorturl.at/jEN46)
"""
    }


contentSkill : Content
contentSkill =
    { title = "Basic Skill Rating"
    , body =
        Markdown.toHtml [ class "overlay__content" ] """
The basic skill rating is completly made up and just for general idea. I found it in tables [here](https://www.guidedolomiti.com/en/rock-climbing-grades/)
"""
    }
