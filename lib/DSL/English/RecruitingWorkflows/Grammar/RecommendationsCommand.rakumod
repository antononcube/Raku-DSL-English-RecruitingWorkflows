use v6;

role DSL::English::RecruitingWorkflows::Grammar::RecommendationsCommand {

    rule recommendations-command {
        [ <.recommend-phrase> | <.what-pronoun> ]
          <top-nrecs-spec>?
          [ <several-phrase> | <a-determiner> | <the-determiner> ]?
          [ <.something-recruiting-word> | <.some-determiner>? <.recruiting-item-phrase> | <.recruiting-item-phrase>? <job-description-phrase> ]?
          [ <.to-preposition> [ <analyze-phrase> | <acquire-phrase> ] ]?
          [ <.for-preposition> <.the-determiner>? [ <period-spec> | <period-acquisition-spec> ] ]?
    }

    rule recommendations-by-profile-command {
        <.can-recruiting-word> <.head-huntress-spec> <recommendations-by-profile-main> |
        <recommendations-by-profile-opportunistic> |
        <recommendations-by-profile-user-wants> |
        <recommendations-by-profile-main> }

    rule recommendations-by-profile-opportunistic {
        <.can-recruiting-word> <.head-huntress-spec> <.recommend-phrase> <.a-determiner>? [ <data-source-spec> <.recruiting-item-phrase> | <.recruiting-item-phrase> <.from-preposition> <data-source-spec> ] }

    rule recommendations-by-profile-user-wants {
        <user-spec> <.want-recruiting-word> <.to-acquire-phrase>? [
           <.a-determiner>? [ <data-quality-spec-list> | <mixed-data-spec-list> ] <.recruiting-item-phrase>? <period-acquisition-spec>? |
           <something-recruiting-word> <.from-preposition>? [ <data-source-spec> | <enhanced-data-with-quality-spec-list> ] [ [ <.for-preposition> | <.at-preposition> | <.during-preposition> ] <period-acquisition-spec> ]? |
           <period-acquisition-spec> <.from-preposition>? <data-source-spec> ] }

    rule recommendations-by-profile-main {
        [ <recommend-phrase> | <tell-recruiting-word>  | <show-recruiting-word> ] <.me-recruiting-word>? <.a-determiner>? <.few-recruiting-word>?
          <top-nrecs-spec>? [
            <recruiting-item-phrase>
              [ <.for-preposition> | <.with-preposition> | <.that-has-phrase> <.the-determiner>? ]
              [ <skill-spec-list> || <job-title-spec-list> || <ingredient-spec-list> ] |
            <recruiting-item-phrase> <.from-preposition> <data-source-spec> |
            <recruiting-item-phrase> [
               <.from-preposition> <data-source-spec> |
               <.with-preposition> <enhanced-data-with-quality-spec-list> ] |
            <enhanced-data-with-quality-spec-list> [ <job-description-phrase> | <recruiting-item-phrase> ] |
            <some-recruiting-word>? [ <data-quality-spec-list> || <mixed-data-spec-list> ] [ <job-description-phrase> | <recruiting-item-phrase> <.recommendations-phrase>? | <recommendations-phrase> ] |
            <something-recruiting-word> <.with-preposition>? <enhanced-data-with-quality-spec-list> |
            <period-spec> <.recruiting-item-phrase> |
            <new-recruiting-word> <item-of-data-job-description-phrase> |
            <.some-recruiting-word>? <interesting-recruiting-word> [ <enhanced-data-with-quality-spec-list> [ <recruiting-item-phrase> | <acquisition-phrase> ]? ]? <job-description-phrase>? |
            <enhanced-ingredient-spec-list> <recruiting-item-phrase> <.recommendations-phrase> |
            <non-prefix> <data-source-spec> <job-description-phrase> |
            <.some-recruiting-word>? <interesting-recruiting-word> <data-source-spec> <job-description-phrase> ]
    }
}