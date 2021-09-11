use v6;

use DSL::Shared::Roles::English::PipelineCommand;
use DSL::Shared::Roles::English::CommonSpeechParts;
use DSL::Shared::Utilities::FuzzyMatching;

use DSL::Entity::Jobs::Grammar::EntityNames;

# Food preparation specific phrases
role DSL::English::RecruitingWorkflows::Grammar::RecruitingPhrases
        does DSL::Entity::Jobs::Grammar::EntityNames
        does DSL::Shared::Roles::English::PipelineCommand {

    rule recommend-phrase {
        [ <recommend-recruiting-word> | <suggest-recruiting-word> | <tell-recruiting-word> ] <to-preposition>? <me-recruiting-word>?
    }

    rule recommendations-phrase {
        <recommendations-recruiting-word> | <suggestions-recruiting-word>
    }

    ##-------------------------------------------------------
    rule top-nrecs-spec {
        <.top-noun>? <.number-of>? <integer-value> <.of-preposition>? <.recommendations-phrase>? <.for-preposition>?
    }

    ##-------------------------------------------------------
    # Recruiting item is a 1) job (description) or opportunity, and 2) resume or talent.
    rule recruiting-item-phrase {
        <talent-resume-phrase> | <job-description-phrase>
    }

    rule talent-resume-phrase {
        <talent-recruiting-word> | <talents-recruiting-word> | <resume-recruiting-word> | <resumes-recruiting-word> }

    rule job-description-phrase {
        [ <job-recruiting-word> | <jobs-recruiting-word> ] [ <description-recruiting-word> | <descriptions-recruiting-word> ]? |
        [ <opportunity-recruiting-word> | <opportunities-recruiting-word> ]
    }

    ##-------------------------------------------------------
    rule item-of-data-phrase {
        <data-schema-phrase> || <dataset-phrase>
    }

    rule dataset-phrase { <data-frames> | <data-frame> | <data-noun> | <datasets-noun> | <dataset-noun> }

    rule data-schema-phrase  { [ <data-noun> | <dataset-noun> ]? <schema-data-acqui-word> }
    rule data-schemas-phrase { [ <data-noun> | <dataset-noun> ]? <schemas-data-acqui-word> }

    ##-------------------------------------------------------
    rule data-source-spec {
        [ <variable-name> | <local-adjective> ] [ <source-recruiting-word> ]?
    }

    token local-adjective { :i 'local' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'local') }> }

    ##-------------------------------------------------------
    rule mixed-data-spec-list {
        <data-quality-spec-list> <data-source-spec>? ||
        <data-source-spec> <data-quality-spec-list> ||
        [ <data-source-spec> | <data-quality-spec-list> ]+ % <.list-separator> }

    ##-------------------------------------------------------
    rule user-be-phrase {
        <user-spec> <user-be-verb> | <im-recruiting-word>
    }

    token user-spec { <i-recruiting-word> | <we-recruiting-word> }

    token user-be-verb { <am-recruiting-word> | <are-recruiting-word> }

    ##-------------------------------------------------------
    rule head-huntress-spec {
        <huntress-noun>          | <you-recruiting-word>          | <head-huntress-gemma-name>
    }

    token head-huntress-gemma-name { <head-prefix> <huntress-noun> <gemma-noun> | 'hhg' }
    token huntress-noun { :i 'huntress' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'huntress') }> }
    token head-prefix { :i 'head' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'head') }> }
    token gemma-noun { :i 'gemma' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'gemma') }> }

    ##-------------------------------------------------------
    rule period-spec {
        <easter-noun> |
        <christmas-noun> }

    rule period-acquisition-spec {
        <morning-noun> |
        <noon-noun> |
        <afternoon-noun> |
        <evening-noun> |
        <night-noun> }

    token afternoon-noun { :i 'afternoon' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'afternoon') }> }
    token christmas-noun { :i 'christmas' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'christmas') }> }
    token easter-noun { :i 'easter' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'easter') }> }
    token evening-noun { :i 'evening' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'evening') }> }
    token morning-noun { :i 'morning' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'morning') }> }
    token night-noun { :i 'night' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'night') }> }
    token noon-noun { :i 'noon' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'noon') }> }

    ##-------------------------------------------------------
    ## General rules
    token acquisition-phrase { <acquisition-recruiting-word> | <gathering-recruiting-word> | <processing-recruiting-word> }
    token procurement-phrase { <procurmend-recruiting-word> | <acquistion-phrase> }

    rule several-phrase {
        <a-determiner>? <few-recruiting-word> |
        <several-recruiting-word> }

    rule analysis-phrase {
        <analysis-recruiting-word> |
        <examination-recruiting-word> |
        <examinations-recruiting-word> }

    rule analyze-phrase {
        <analyze-recruiting-word> |
        <prepare-recruiting-word> |
        <experiment-with-phrase> }

    rule analyzing-phrase {
        <analyzing-recruiting-word> |
        <preparing-recruiting-word> |
        <experimenting-with-phrase> }

    rule analyzed-phrase {
        <analyzed-recruiting-word> |
        <prepared-recruiting-word> |
        <experiment-with-phrase> }

    rule experiment-with-phrase {
        <experiment-recruiting-word> <with-preposition> |
        <try-recruiting-word> <out-adverb>? }

    rule experimenting-with-phrase {
        <experimenting-recruiting-word> <with-preposition> |
        <trying-recruiting-word> <out-adverb>? }

    rule experimented-with-phrase {
        <experimented-recruiting-word> <with-preposition> |
        <tried-recruiting-word> <out-adverb>? }

    rule ingredients-phrase {
        <ingredient-recruiting-word> |
        <ingredients-recruiting-word> |
        <metadata-recruiting-word> |
        <variable-noun> |
        <variables-noun> |
        <element-recruiting-word> |
        <component-recruiting-word> <part-recruiting-word>? }

    rule which-items-phrase { <what-recruiting-word> | <which-determiner> }
    rule how-many-items-phrase { <what-recruiting-word> <number-recruiting-word> <of-preposition> | <how-recruiting-word> <many-recruiting-word> }

    rule to-acquire-phrase { <to-preposition> [ <acquire-phrase> | <try-recruiting-word> <out-adverb>? ] }

    rule acquire-phrase { <acquire-recruiting-word> | <get-verb> | <process-recruiting-word> | <procure-recruiting-word> }

    rule acquired-phrase { <acquired-recruiting-word> | <got-recruiting-word> | <had-recruiting-word> | <processed-recruiting-word> | <procured-recruiting-word>}

    rule acquiring-phrase { <acquiring-recruiting-word> | <processing-recruiting-word> | <procuring-recruiting-word> }

    rule that-has-phrase { <that-pronoun> [ <has-recruiting-word> | <have-recruiting-word> ] }

    rule job-title-phrase { [ <job-recruiting-word> | <jobs-recruiting-word> ] [ <title-recruiting-word> | <titles-recruiting-word> ] }

    ##-------------------------------------------------------
    rule dataset-variables-phrase { <dataset-phrase>? [ <variable-noun> | <variables-noun> | <column-noun> | <columns> ] }

    ##-------------------------------------------------------
    ## General tokens
    token acquire-recruiting-word { :i 'acquire' | ([\w]+) <?{ $0.Str !(elem) <acquiring acquired> and is-fuzzy-match( $0.Str, 'acquire') }> }
    token acquired-recruiting-word {  :i 'acquired' | ([\w]+) <?{ $0.Str !(elem) <acquire acquiring> and is-fuzzy-match( $0.Str, 'acquired') }>}
    token acquiring-recruiting-word { :i 'acquiring' | ([\w]+) <?{ $0.Str !(elem) <acquire acquired> and is-fuzzy-match( $0.Str, 'acquiring') }> }
    token acquisition-recruiting-word {  :i 'acquisition' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'acquisition') }> }
    token am-recruiting-word { :i 'am' }
    token analysis-recruiting-word { :i 'analysis' | ([\w]+) <?{ $0.Str !(elem) <analyze analyzed analyzing> and is-fuzzy-match( $0.Str, 'analysis') }> }
    token analyze-recruiting-word { :i 'analyze' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'analyze', 1) }> }
    token analyzed-recruiting-word { :i 'analyzed' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'analyzed') }> }
    token analyzing-recruiting-word { :i 'analyzing' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'analyzing') }> }
    token are-recruiting-word { :i 'are' }
    token can-recruiting-word { :i 'can' }
    token component-recruiting-word { :i 'component' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'component') }> }
    token contain-recruiting-word { :i 'contain' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'contain') }> }
    token data-frame-recruiting-word { :i <data-frame> }
    token data-frames-recruiting-word { :i <data-frames> }
    token description-recruiting-word { :i 'description' | ([\w]+) <?{ $0.Str !(elem) <descriptions> and is-fuzzy-match( $0.Str, 'description') }> }
    token descriptions-recruiting-word { :i 'descriptions' | ([\w]+) <?{ $0.Str !(elem) <description> and is-fuzzy-match( $0.Str, 'descriptions') }> }
    token did-recruiting-word { :i 'did' }
    token do-recruiting-word { :i 'do' }
    token element-recruiting-word { :i 'element' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'element') }> }
    token examination-recruiting-word { :i 'examination' | ([\w]+) <?{ $0.Str !(elem) <examinations> and is-fuzzy-match( $0.Str, 'examination') }> }
    token examinations-recruiting-word { :i 'examinations' | ([\w]+) <?{ $0.Str !(elem) <examination> and is-fuzzy-match( $0.Str, 'examinations') }> }
    token experiment-recruiting-word { :i 'experiment' | ([\w]+) <?{ $0.Str !(elem) <experimented experimenting> and is-fuzzy-match( $0.Str, 'experiment') }> }
    token experimented-recruiting-word { :i 'experimented' | ([\w]+) <?{ $0.Str !(elem) <experiment experimenting> and is-fuzzy-match( $0.Str, 'experimented') }> }
    token experimenting-recruiting-word { :i 'experimenting' | ([\w]+) <?{ $0.Str !(elem) <experiment experimenting> and is-fuzzy-match( $0.Str, 'experimenting') }> }
    token feeling-recruiting-word { :i 'feeling' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'feeling') }> }
    token few-recruiting-word { :i 'few' | ([\w]+) <?{ $0.Str ne 'new' and is-fuzzy-match( $0.Str, 'few', 1) }> }
    token form-recruiting-word { :i 'form' | ([\w]+) <?{ $0.Str ne 'format' and is-fuzzy-match( $0.Str, 'form', 1) }> }
    token format-recruiting-word { :i 'format' | ([\w]+) <?{ $0.Str ne 'form' and is-fuzzy-match( $0.Str, 'format', 1) }> }
    token gathering-recruiting-word {  :i 'gathering' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'gathering') }> }
    token generator-recruiting-word {  :i 'generator' | ([\w]+) <?{ $0.Str ne 'generators' and is-fuzzy-match( $0.Str, 'generator') }> }
    token generators-recruiting-word {  :i 'generators' | ([\w]+) <?{ $0.Str ne 'generator' and is-fuzzy-match( $0.Str, 'generators') }> }
    token got-recruiting-word { :i 'got' }
    token had-recruiting-word { :i 'had' | ([\w]+) <?{ $0.Str !(elem) <has have> and is-fuzzy-match( $0.Str, 'had', 1) }> }
    token has-recruiting-word { :i 'has' | ([\w]+) <?{ $0.Str !(elem) <had have> and is-fuzzy-match( $0.Str, 'has', 1) }> }
    token have-recruiting-word { :i 'have' | ([\w]+) <?{ $0.Str !(elem) <has had> and is-fuzzy-match( $0.Str, 'have', 1) }> }
    token how-recruiting-word { :i 'how' | ([\w]+) <?{ $0.Str ne 'show' and is-fuzzy-match( $0.Str, 'how', 1) }> }
    token i-recruiting-word { :i 'i' }
    token im-recruiting-word { :i 'im' | 'i\'m' }
    token ingredient-recruiting-word { :i 'ingredient' | ([\w]+) <?{ $0.Str ne 'ingredients' and is-fuzzy-match( $0.Str, 'ingredient') }> }
    token ingredients-recruiting-word { :i 'ingredients' | ([\w]+) <?{ $0.Str ne 'ingredient' and is-fuzzy-match( $0.Str, 'ingredients') }> }
    token interesting-recruiting-word { :i 'interesting' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'interesting') }> }
    token job-recruiting-word { :i 'job' || ([\w]+) <?{ $0.Str ne 'jobs' and is-fuzzy-match( $0.Str, 'job', 1) }> }
    token jobs-recruiting-word { :i 'jobs' | ([\w]+) <?{ $0.Str ne 'job' and is-fuzzy-match( $0.Str, 'jobs', 1) }> }
    token kind-recruiting-word { :i 'kind' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'kind', 1) }> }
    token know-recruiting-word { :i 'know' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'know', 1) }> }
    token last-recruiting-word { :i 'last' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'last', 1) }> }
    token light-recruiting-word { :i 'light' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'light') }> }
    token local-recruiting-word { :i 'local' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'local') }> }
    token make-recruiting-word { :i 'make' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'make', 1) }> }
    token many-recruiting-word { :i 'many' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'many', 1) }> }
    token me-recruiting-word { :i 'me' }
    token metadata-recruiting-word { :i 'metadata' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'metadata') }> }
    token mood-recruiting-word { :i 'mood' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'mood', 1) }> }
    token most-recruiting-word { :i 'most' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'most', 1) }> }
    token my-recruiting-word { :i 'my' }
    token new-recruiting-word { :i 'new' | ([\w]+) <?{ $0.Str ne 'few' and is-fuzzy-match( $0.Str, 'new', 1) }> }
    token number-recruiting-word { :i 'number' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'number') }> }
    token often-recruiting-word { :i 'often' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'often') }> }
    token opportunity-recruiting-word { :i 'opportunity' | ([\w]+) <?{ $0.Str ne 'opportunities' and is-fuzzy-match( $0.Str, 'opportunity') }> }
    token opportunities-recruiting-word { :i 'opportunities' | ([\w]+) <?{ $0.Str ne 'opportunity' and  is-fuzzy-match( $0.Str, 'opportunities') }> }
    token our-recruiting-word { :i 'our' }
    token part-recruiting-word { :i 'part' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'part', 1) }> }
    token prepare-recruiting-word { :i 'prepare' | ([\w]+) <?{ $0.Str !(elem) <prepared preparing> and is-fuzzy-match( $0.Str, 'prepare') }> }
    token prepared-recruiting-word { :i 'prepared' | ([\w]+) <?{ $0.Str !(elem) <prepare preparing> and is-fuzzy-match( $0.Str, 'prepared') }> }
    token preparing-recruiting-word { :i 'preparing' | ([\w]+) <?{ $0.Str !(elem) <prepare prepared> and is-fuzzy-match( $0.Str, 'preparing') }> }
    token process-recruiting-word { :i 'process' | ([\w]+) <?{ $0.Str !(elem) <processed processing> and is-fuzzy-match( $0.Str, 'process') }> }
    token processed-recruiting-word { :i 'processed' | ([\w]+) <?{ $0.Str !(elem) <process processing> and is-fuzzy-match( $0.Str, 'processed') }> }
    token processing-recruiting-word { :i 'processing' | ([\w]+) <?{ $0.Str !(elem) <process processed> and is-fuzzy-match( $0.Str, 'processing') }> }
    token procure-recruiting-word { :i 'procure' | ([\w]+) <?{ $0.Str !(elem) <procuring procured> and is-fuzzy-match( $0.Str, 'procure') }> }
    token procured-recruiting-word { :i 'procures' | ([\w]+) <?{ $0.Str !(elem) <procuring procure> and is-fuzzy-match( $0.Str, 'procured') }> }
    token procuring-recruiting-word { :i 'procuring' | ([\w]+) <?{ $0.Str !(elem) <procure procured> and is-fuzzy-match( $0.Str, 'procuring') }> }
    token reaction-recruiting-word { :i 'reaction' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'reaction') }> }
    token recipe-recruiting-word { :i 'recipe' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'recipe') }> }
    token recipes-recruiting-word { :i 'recipes' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'recipes') }> }
    token recommend-recruiting-word { :i 'recommend' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'recommend') }> }
    token recommendations-recruiting-word { :i 'recommendations' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'recommendations') }> }
    token resume-recruiting-word { :i 'resume' | ([\w]+) <?{ $0.Str ne 'resumes' and is-fuzzy-match( $0.Str, 'resume') }> }
    token resumes-recruiting-word { :i 'resumes' | ([\w]+) <?{ $0.Str ne 'resume' and is-fuzzy-match( $0.Str, 'resumes') }> }
    token schema-recruiting-word { :i 'schema' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'schema') }> }
    token schemas-recruiting-word { :i 'schemas' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'schemas') }> }
    token several-recruiting-word { :i 'several' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'several') }> }
    token show-recruiting-word { :i 'show' | ([\w]+) <?{ $0.Str ne 'how' and is-fuzzy-match( $0.Str, 'show', 1) }> }
    token skill-recruiting-word { :i 'skill' | ([\w]+) <?{  $0.Str ne 'skills' and is-fuzzy-match( $0.Str, 'skill', 1) }> }
    token skills-recruiting-word { :i 'skills' | ([\w]+) <?{  $0.Str ne 'skill' and is-fuzzy-match( $0.Str, 'skills') }> }
    token some-recruiting-word { :i 'some' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'some', 1) }> }
    token something-recruiting-word { :i 'something' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'something') }> }
    token source-recruiting-word { :i 'source' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'source') }> }
    token star-recruiting-word { :i 'star' | ([\w]+) <?{ $0.Str ne 'start' and is-fuzzy-match( $0.Str, 'star', 1) }> }
    token suggest-recruiting-word { :i 'suggest' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'suggest') }> }
    token suggestions-recruiting-word { :i 'suggestions' | ([\w]+) <?{ $0.Str ne 'start' and  is-fuzzy-match( $0.Str, 'suggestions') }> }
    token talent-recruiting-word { :i 'talent' | ([\w]+) <?{ $0.Str ne 'talents' and is-fuzzy-match( $0.Str, 'talent') }> }
    token talents-recruiting-word { :i 'talents' | ([\w]+) <?{  $0.Str ne 'talent' and is-fuzzy-match( $0.Str, 'talents') }> }
    token tell-recruiting-word { :i 'tell' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'tell', 1) }> }
    token time-recruiting-word { :i 'time' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'time', 1) }> }
    token times-recruiting-word { :i 'times' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'times') }> }
    token title-recruiting-word { :i 'title' | ([\w]+) <?{ $0.Str ne 'titles' and is-fuzzy-match( $0.Str, 'title') }> }
    token titles-recruiting-word { :i 'titles' | ([\w]+) <?{ $0.Str ne 'title' and is-fuzzy-match( $0.Str, 'titles') }> }
    token tried-recruiting-word { :i 'tried' | ([\w]+) <?{ $0.Str !(elem) <try trying> and is-fuzzy-match( $0.Str, 'tried') }> }
    token try-recruiting-word { :i 'try' | ([\w]+) <?{ $0.Str !(elem) <tried trying> and is-fuzzy-match( $0.Str, 'try', 1) }> }
    token trying-recruiting-word { :i 'trying' | ([\w]+) <?{ $0.Str !(elem) <tried try> and is-fuzzy-match( $0.Str, 'trying') }> }
    token want-recruiting-word { :i 'want' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'want', 1) }> | 'wants' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'wants') }> }
    token was-recruiting-word { :i 'was' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'was', 1) }> }
    token we-recruiting-word { :i 'we' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'we', 1) }> }
    token what-recruiting-word { :i 'what' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'what', 1) }> }
    token when-recruiting-word { :i 'when' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'when', 1) }> }
    token with-recruiting-word { :i 'with' }
    token year-recruiting-word { :i 'year' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'year', 1) }> }
    token you-recruiting-word { :i 'you' | ([\w]+) <?{ is-fuzzy-match( $0.Str, 'you', 1) }> }
}
