=begin comment
#==============================================================================
#
#   Recruiting Workflows WL-System actions in Raku (Perl 6)
#   Copyright (C) 2021  Anton Antonov
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#   Written by Anton Antonov,
#   antononcube @ posteo . net,
#   Windermere, Florida, USA.
#
#==============================================================================
#
#   For more details about Raku (Perl6) see https://raku.org/ .
#
#==============================================================================
=end comment

use v6;

use DSL::Entity::Geographics::Actions::WL::System;
use DSL::Entity::Jobs::Actions::WL::System;
use DSL::Shared::Actions::English::TimeIntervalSpec;
use DSL::Shared::Actions::English::WL::PipelineCommand;
use DSL::Shared::Entity::Actions::WL::System;


class DSL::English::RecruitingWorkflows::Actions::WL::Ecosystem
        is DSL::Shared::Actions::English::TimeIntervalSpec
        is DSL::Shared::Entity::Actions::WL::System {

    ##=====================================================
    ## General
    ##=====================================================
    has Str $.userID is rw;

    has DSL::Entity::Geographics::Actions::WL::System $.geoActions;
    has DSL::Entity::Jobs::Actions::WL::System $.jobsActions;

    method makeUserIDTag() {
        (!$.userID.defined or $.userID.chars == 0 or $.userID (elem) <NONE NULL>) ?? '' !! '"UserID:' ~ $.userID ~ '"';
    }

    method make-time-interval-predicate(%tiSpecArg) {
        my %tiSpec = self.normalize-time-interval-spec(%tiSpecArg);
        'AbsoluteTime[DateObject["' ~ %tiSpec<From> ~ '"]] <= AbsoluteTime[#Timestamp] <= AbsoluteTime[DateObject["' ~ %tiSpec<To> ~ '"]]'
    }

    # Separator
    method separator() { " \\[DoubleLongRightArrow]\n" }

    ##=====================================================
    ## TOP
    ##=====================================================
    method TOP($/) {
        make $/.values[0].made;
    }

    ##=====================================================
    ## Data query
    ##=====================================================
    method data-query-command($/) {
        die "Not implemented: data-query-command."
    }
    method location-spec($/) {
        make $.Str;
    }

    ##=====================================================
    ## Introspection
    ##=====================================================
    method introspection-query-command($/) {
        make $/.values[0].made;
    }

    ##-----------------------------------------------------
    method introspection-data-retrieval ($/) {

        my $tiPred = '';

        with $<time-interval-spec> {
            say $<time-interval-spec>.made;
            my %tiSpec = $<time-interval-spec>.made;
            $tiPred = self.make-time-interval-predicate(%tiSpec);
        };

        if $<introspection-action><analyze> or $<introspection-action><analyzed> {
            $tiPred ~= ($tiPred.chars > 0 ?? ' && ' !! ' ') ~ '#Action == "Analyze"'
        }

        with $<data-source-spec> {
            $tiPred ~= ($tiPred.chars > 0 ?? ' && ' !! ' ') ~ 'ToLowerCase[#Source] == "' ~ self.data-source-spec(
                    $<data-source-spec>, :!tag).lc ~ '"'
        }

        if $.userID.defined and $.userID.chars > 0 {
            my $userIDPred = '#UserID == "' ~ $.userID ~ '"';
            make 'dsTalentProcurment[Select[' ~ ($tiPred
                    .chars > 0 ?? $tiPred ~ ' && ' ~ $userIDPred !! $userIDPred) ~ '&]]'
        } else {
            make $tiPred.chars > 0 ?? 'dsTalentProcurment[Select[' ~ $tiPred ~ '&]]' !! 'dsTalentProcurment'
        }
    }

    ##-----------------------------------------------------
    method introspection-counts-query($/) {
        my $res = self.introspection-data-retrieval($/);
        make 'Length[' ~ $res ~ ']'
    }

    ##-----------------------------------------------------
    method introspection-profile-query ($/) {
        my $res = self.introspection-data-retrieval($/);
        make 'ResourceFunction["RecordsSummary"][' ~ $res ~ ']'
    }

    ##-----------------------------------------------------
    method introspection-last-time-query ($/) {
        my $res = self.introspection-data-retrieval($/);
        make $res ~ '[SortBy[-AbsoluteTime[#Timestamp]&]][1 ;; UpTo[3]]'
    }

    ##-----------------------------------------------------
    method introspection-when-query ($/) {
        my $res = self.introspection-data-retrieval($/);
        make 'SortBy[' ~ $res ~ ', #Timestamp&]'
    }

    ##-----------------------------------------------------
    method introspection-timeline-query ($/) {
        my $res = self.introspection-data-retrieval($/);
        make 'Block[{dsTemp=' ~ $res ~ '}, GroupBy[Normal@dsTemp, #UserID &, TimelinePlot[#Timestamp -> #DatasetID & /@ #, AspectRatio -> 1/4, ImageSize -> Large] &]]'
    }

    ##=====================================================
    ## Ingredient query
    ##=====================================================
    method ingredient-query-command($/) {
        die 'ingredient-query-command:: Not implemented yet !!!';
    }

    ##=====================================================
    ## Recommendations
    ##=====================================================
    method recommendations-command($/) {
        my $nrecs = '';
        my Str $actionPred = '';
        if $<acquire-phrase> { $actionPred = '"Action:Acquire"' }
        elsif $<analyze-phrase> { $actionPred = '"Action:Analyze"' }

        if $<top-nrecs-spec> {
            $nrecs = ', ' ~ $<top-nrecs-spec>.made;
        }

        my Str $prof =
                do if self.makeUserIDTag().chars > 0 && $actionPred.chars > 0 { '{' ~ (self.makeUserIDTag(),
                                                                                       $actionPred).join(',') ~ '}' }
                elsif self.makeUserIDTag().chars > 0 { self.makeUserIDTag() }
                elsif $actionPred.chars > 0 { $actionPred }
                else { '' }

        make 'smrHHG \[DoubleLongRightArrow] SMRMonRecommendByProfile[' ~ $prof ~ $nrecs ~ '] \[DoubleLongRightArrow] SMRMonJoinAcross["Warning"->False] \[DoubleLongRightArrow] SMRMonTakeValue[]';
    }

    ##=====================================================
    ## Recommendations by profile
    ##=====================================================
    method recommendations-by-profile-command($/) {
        make $/.values[0].made;
    }

    method recommendations-by-profile-opportunistic($/) {
        self.recommendations-by-profile-main($/);
    }

    method recommendations-by-profile-user-wants($/) {
        self.recommendations-by-profile-main($/);
    }

    method recommendations-by-profile-main($/) {
        my $nrecs = '';
        my Str $smrObj = 'smrHHGResumes';
        my Str @resProfile;

        if $<top-nrecs-spec> {
            $nrecs = ', ' ~ $<top-nrecs-spec>.made;
        }

        if $<data-quality-spec> {
            @resProfile.append($<data-quality-spec>.made)
        }

        if $<period-acquisition-spec> {
            @resProfile.append($<period-acquisition-spec>.made)
        }

        if $<period-spec> {
            @resProfile.append($<period-spec>.made)
        }

        if $<data-quality-spec-list> {
            @resProfile.append($<data-quality-spec-list>.made)
        }

        if $<data-with-quality-spec-list> {
            @resProfile.append($<data-with-quality-spec-list>.made)
        }

        if $<mixed-data-spec-list> {
            @resProfile.append($<mixed-data-spec-list>.made)
        }

        if $<data-source-spec> {
            @resProfile.append($<data-source-spec>.made)
        }

        if $<enhanced-ingredient-spec-list> {
            @resProfile.append($<enhanced-ingredient-spec-list>.made)
        }

        if $<ingredient-spec-list> {
            @resProfile.append($<ingredient-spec-list>.made)
        }

        if $<skill-spec-list> {
            @resProfile.append($<skill-spec-list>.made)
        }

        if $<job-title-spec-list> {
            @resProfile.append($<job-title-spec-list>.made)
        }

        if self.makeUserIDTag().chars > 0 {
            @resProfile = @resProfile.append(self.makeUserIDTag())
        }

        if $<recruiting-item-phrase><job-description-phrase> {
            $smrObj = 'smrHHGJobs'
        }

        #make to_DSL_code('USE TARGET SMRMon-R; use smrHHG; recommend by profile ' ~ @resProfile.join(', ') ~ '; echo pipeline value;');
        make $smrObj ~ ' \[DoubleLongRightArrow] SMRMonRecommendByProfile[ {' ~ @resProfile
                .join(', ') ~ '}' ~ $nrecs ~ '] \[DoubleLongRightArrow] SMRMonJoinAcross["Warning"->False] \[DoubleLongRightArrow] SMRMonTakeValue[]';
    }

    ##=====================================================
    ## Random data generation
    ##=====================================================
    method random-data-generation-command($/) {
        make $/.values[0].made;
    }

    method random-tabular-data-generation-command($/) {
        if $<random-tabular-dataset-arguments-list> {
            my %allArgs = $<random-tabular-dataset-arguments-list>.made;
            %allArgs = %( NumberOfRows => 'Automatic', NumberOfColumns => 'Automatic'), %allArgs;

            if %allArgs<ColumnNames>:exists { %allArgs = %allArgs, %( NumberOfColumns => '{' ~ %allArgs<ColumnNames> ~ '}') }
            my %opts = %allArgs;
            %opts<NumberOfColumns>:delete;
            %opts<NumberOfRows>:delete;
            %opts<ColumnNames>:delete;

            my $opts = %opts.elems == 0 ?? '' !! ', ' ~ %opts.values.join(', ');
            make 'ResourceFunction["RandomTabularDataset"][{' ~ %allArgs<NumberOfRows> ~ ', ' ~ %allArgs<NumberOfColumns> ~ '}' ~ $opts ~ ']';
        } else {
            make 'ResourceFunction["RandomTabularDataset"][]';
        }
    }

    method random-tabular-dataset-arguments-list($/) {
        make $<random-tabular-dataset-argument>>>.made;
    }
    method random-tabular-dataset-argument($/) {
        make $/.values[0].made;
    }

    method random-tabular-dataset-nrows-spec($/) {
        make %( NumberOfRows => $/.values[0].made);
    }

    method random-tabular-dataset-ncols-spec($/) {
        make %( NumberOfColumns => $/.values[0].made);
    }

    method random-tabular-dataset-colnames-spec($/) {
        make %( ColumnNames => ~$/.values[0].made);
    }

    method random-tabular-dataset-form-spec($/) {
        make %( Form => '"Form" -> "' ~ $/.values[0].made ~ '"');
    }

    method random-tabular-dataset-col-generators-spec($/) {
        make %( Generators => '"Generators" -> ' ~ $/.values[0].made);
    }

    method random-tabular-dataset-max-number-of-values-spec($/) {
        make %( MaxNumberOfValues => '"MaxNumberOfValues" -> ' ~ $/.values[0].made);
    }

    method random-tabular-dataset-min-number-of-values-spec($/) {
        make %( MinNumberOfValues => '"MinNumberOfValues" -> ' ~ $/.values[0].made);
    }

    ##=====================================================
    ## Fundamental tokens / rules
    ##=====================================================
    method top-nrecs-spec($/) {
        make $<integer-value>.made;
    }

    method data-source-spec($/, :$tag = True) {
        make $tag ?? '"DataCategory:' ~ $/.Str.trim.lc ~ '"' !! '"' ~ $/.Str.trim.lc ~ '"';
    }

    method period-acquisition-spec($/) {
        make '"PeriodAcquistion' ~ $/.values[0].made.substr(1, *- 1) ~ '"';
    }

    method period-spec($/) {
        make '"Period:' ~ $/.Str.lc ~ '"';
    }

    method mixed-data-spec-list($/) {
        make $/.values>>.made.flat;
    }

    method data-with-quality-spec-list($/) {
        make $/.values>>.made.flat;
    }

    method data-with-quality-spec($/) {
        make $/.values[0].made;
    }

    method data-quality-spec-list($/) {
        make $/.values>>.made.flat;
    }

    method data-quality-spec($/) {
        make $/.values[0].made;
    }

    method data-property-spec($/) {
        if $<entity-job-skill> {
            make '"Skill:' ~ $<entity-job-skill>.made.substr(1, *- 1) ~ '"';
        } elsif $<entity-job-title> {
            make '"Title:' ~ $<entity-job-title>.made.substr(1, *- 1) ~ '"';
        } else {
            make '"DataType:' ~ $/.Str.trim.lc ~ '"';
        }
    }

    method data-non-property-spec($/) {
        make 'Not[' ~ $/.values[0].made.substr ~ ']';
    }

    method enhanced-ingredient-spec-list($/) {
        make $/.values[0].made;
    }

    method skills-spec-list($/) {
        make $/.values>>.made;
    }

    method job-title-spec-list($/) {
        make $/.values>>.made;
    }

    method ingredient-spec-list($/) {
        make $/.values>>.made;
    }

    method ingredient-spec($/) {
        make $/.values[0].made;
    }

    method job-entity-spec($/) {
        make $/.values[0].made;
    }

    method entity-job-title($/) {
        my $ename = $!jobsActions.entity-job-title($/);
        make '"Title:' ~ $ename.substr(1, *- 1).subst(:g, ' ', '.') ~ '"';
    }

    method entity-job-skill($/) {
        my $ename = $!jobsActions.entity-job-skill($/);
        make '"Skill:' ~ $ename.substr(1, *- 1).subst(:g, ' ', '.') ~ '"';
    }

    ##-------------------------------------------------------
    ## Generic
    ##-------------------------------------------------------
    method word-value($/) {
        make $/.Str;
    }

    # Column specs
    method column-specs-list($/) {
        make $<column-spec>>>.made.join(', ');
    }
    method column-spec($/) {
        make $/.values[0].made;
    }
    method column-name-spec($/) {
        make '"' ~ $<mixed-quoted-variable-name>.made.subst(:g, '"', '') ~ '"';
    }

}
