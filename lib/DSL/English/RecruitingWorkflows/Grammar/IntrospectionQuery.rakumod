use v6;

role DSL::English::RecruitingWorkflows::Grammar::IntrospectionQuery {

    rule introspection-query-command {
        <introspection-counts-query> |
        <introspection-profile-query> |
        <introspection-last-time-query> |
        <introspection-when-query> |
        <introspection-timeline-query>
    }

    ## Counts
    rule introspection-counts-query {
        <.how-many-times-phrase> <user-spec> [ <acquired-phrase> | <analyzed-phrase> ] [ <data-with-quality-spec-list> || <data-source-spec> ] <time-interval-spec>
    }
    rule how-many-times-phrase {
        [ <.what-pronoun> <.number-noun> <.of-preposition> | <.how-adverb> <.many-recruiting-word> ] <.times-noun>
    }

    ## Kind of data
    rule introspection-profile-query {
        <.what-pronoun> <.kind-of-data-phrase>? [ <.do-verb> | <.did-recruiting-word> ] <user-spec> <introspection-action>
           [ [ <for-preposition> | <at-preposition> | <during-preposition> | <in-preposition> ] <period-spec> <period-acquisition-spec>? | <time-interval-spec> ] |
        <.what-pronoun> <.kind-of-phrase>? <data-with-quality-spec> <user-spec> <introspection-action> <.most-recruiting-word> <.often-recruiting-word>
    }

    rule kind-of-phrase { [ <kind-recruiting-word> | <type-noun> ] <of-preposition> }
    rule kind-of-data-phrase { <kind-of-phrase>? <recruiting-item-phrase> }

    rule introspection-action {
        <acquire=.acquire-phrase> | <analyze=.analyze-phrase> |
        <.data-noun>? [ <acquire=.acquired-phrase> | <analyze=.analyzed-phrase> | <analyze=.experimented-with-phrase> ] |
        <acquire=.acquiring-phrase> | <analyze=.analyzing-phrase> |
        <acquire=.acquisition-phrase> | <analyze=.analysis-phrase>
    }

    ## Point-in-time
    rule introspection-last-time-query {
        [ <.when-pronoun> | <.what-pronoun> ] [ <.was-recruiting-word> | <.is-verb> ] <.the-determiner> <last-recruiting-word> <time-recruiting-word>
        <user-spec>
        <introspection-action>
        [ <data-with-quality-spec-list> || <data-source-spec> ]? }

    ## When
    rule introspection-when-query {
        <.at-what-time-phrase> <.did-recruiting-word> <user-spec> <introspection-action> <data-source-spec>?
    }
    rule at-what-time-phrase { <when-pronoun> | <at-preposition>? <what-pronoun> <time-noun> }

    ## Timeline
    rule introspection-timeline-query {
        [ <.display-timeline-phrase> | <.what-timeline-phrase> ] <.of-preposition>? [ <my-determiner> | <our-determiner> ]
            [ [ <data-with-quality-spec-list> || <data-source-spec> ] <introspection-action> | <introspection-action> <.of-preposition>? [ <data-with-quality-spec-list> || <data-source-spec> ]? ] |
        [ <.display-timeline-phrase> | <.what-timeline-phrase> ] <.of-preposition>?
           [ <.when-pronoun> | <.the-determiner> <.times-food-word-prep> ]
           <user-spec>
           <introspection-action>
           [ <data-with-quality-spec-list> || <data-source-spec> ]? |
        [ <.display-timeline-phrase> | <.what-timeline-phrase> ]
           [ <.of-preposition> | <.for-preposition> ]?
           [ <.my-recruiting-word> | <.our-recruiting-word> ]?
           <introspection-action>
           [ <.of-preposition> | <.for-preposition> ]?
           [ <data-with-quality-spec-list> || <data-source-spec> ]?
    }
    rule display-timeline-phrase { [ <display-directive> | <plot-directive> ] <the-determiner>? <timeline-noun> }
    rule what-timeline-phrase { <what-pronoun> <is-verb> <the-determiner>? <timeline-noun> }
}