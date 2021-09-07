use v6;

use DSL::English::RecruitingWorkflows::Grammar::RecruitingPhrases;
use DSL::English::RecruitingWorkflows::Grammar::IngredientSpec;
use DSL::Shared::Roles::English::CommonSpeechParts;

role DSL::English::RecruitingWorkflows::Grammar::IngredientQuery
        does DSL::English::RecruitingWorkflows::Grammar::IngredientSpec {

    rule ingredient-query-command {
        <ingredient-query-which-items-query>    | <ingredient-query-how-many-items-query>
    }

    rule ingredient-query-which-items-query {
        <.which-items-phrase> <ingredient-query-body>
    }

    rule ingredient-query-how-many-items-query {
        <.how-many-items-phrase> <ingredient-query-body>
    }

    rule do-you-know-phrase {
        <do-verb> <you-recruiting-word> <know-recruiting-word>
    }

    rule have-phrase {
        <that-pronoun>? [ <have-recruiting-word> | <contain-recruiting-word> | <are-verb>? <with-preposition> ]
    }

    rule do-you-know-to-have-phrase { <do-you-know-phrase>? <to-preposition>? <have-phrase> }

    rule ingredient-query-body {
        <recruiting-item-phrase> <.have-phrase> [ <.a-determiner> | <.the-determiner> ]? <.ingredients-phrase>? <ingredient-query-main-part> |
        <recipes-recruiting-word> <.do-you-know-to-have-phrase> [ <.a-determiner> | <.the-determiner> ]? <.ingredients-phrase>? <ingredient-query-main-part> |
        <data-frames-recruiting-word> <.do-you-know-to-have-phrase> [ <.a-determiner> | <.the-determiner> ]? <.ingredients-phrase>? <ingredient-query-main-part>
    }

    rule ingredient-query-main-part { <data-quality-spec-list> [ <data-noun> | <dataset-variables-phrase> ]? }
}