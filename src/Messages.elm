module Messages exposing (ContentKind(..), Msg(..))

--Global messages


type Msg
    = SetCurrentOverlay ContentKind
    | SetCurrentGrade Int
    | NoOp


type ContentKind
    = Info
    | YDSWiki
    | UIAAWiki
    | FrenchWiki
    | EwbankWiki
    | None
