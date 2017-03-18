







/* Global Style Sheet */

/* Styles for existing HTML elements */

BODY {
    background-color : #ffffff;
    font-size : 100%;
}
BODY, TD, TH, SELECT {
    font-family : tahoma, arial, helvetica, sans-serif;
    font-size : 11pt;
    color : #000000;
}
FIELDSET {
    border-style : groove;
    padding : 8px 8px 8px 8px;
}
LEGEND {
    color : #000000;
}
FIELDSET TABLE {
    margin-top : 3px;
}
PRE {
    font-size : 100%;
}
A {}

/***
 * The original link colors are reversed in sense from the
 * browser default link colors.
 * Commented out until and unless somebody wants control over the colors.

A:link {
    color : #330066;
}
A:visited {
    color : #003399;
}
A:hover {
    color : #99ccff;
    text-decoration : none;
}
A:active {
    color : #99ccff;
}
 ***/

/* Custom styles */

TABLE .dhtmlTreeStyle {
    padding : 0px;
}
TD .dhtmlTreeStyle {
    padding : 0px;
}

.jive-header TABLE {
    border : 1px #000000 solid;
    background-color : #336699;
}
.jive-header TD {
    font-family : trebuchet ms, arial, helvetica, sans-serif;
    font-size : 1.4em;
}
.jive-breadcrumbs, .jive-breadcrumbs A {
    background: transparent;
    vertical-align : top;
}
.jive-breadcrumbs A:hover {
    text-decoration : none;
    color : #660000 !important;
    background: transparent;
}
.jive-description {
    font-family : tahoma, arial, helvetica, san-serif;
    font-weight : normal;
    font-size : 11px !important;
}
.discussion-description {
    background-color : #DED;
    padding : 0.3em;
    font-family : tahoma, arial, helvetica, san-serif;
    font-weight : normal;
    font-size : 1.0em;
}

.jive-odd {
    background-color : #eeeeee;
    color : #000000;
}
.jive-even {
    background-color : #ffffff;
    color : #000000;
}

.jive-page-title {
    font-size : 1.2em;
    font-weight : bold;
}
.jive-bullet {
    text-align : center;
}
#jive-footer TABLE {
    border-top : #ccc 2px solid;
}
#jive-footer TD {
    font-size : 0.7em;
    font-weight : bold;
    text-align : center;
    border-top : 1px #cccccc solid;
    padding-top : 5px;
}
#jive-footer TD A {
    color : #666;
    background: transparent;
    text-decoration : none;
}
#jive-footer TD A:hover {
    text-decoration : underline;
}
.jive-error-text {
    color : #f00;
    background: transparent;
    font-weight : normal;
}
.jive-label, .jive-top-label, .jive-bold-label {
    text-align : right;
}
.jive-subject {
    font-weight : bold;
}
.jive-box {
/*    border : 1px #cccccc solid; */
}
#jive-category-list TH {
    font-weight : bold;
    text-align : center;
    background-color : #ddd;
    color : #000000;
}
.jive-recententry-box .jive-box TH,
.jive-popularentries-box .jive-box TH,
.jive-featuredentries-box .jive-box TH,
.jive-account-box .jive-box TH,
.jive-tools-box .jive-box TH,
.jive-related-box .jive-box TH,
.jive-attachment-box .jive-box TH,
.jive-referencing-box .jive-box TH,
.jive-popular-box .jive-box TH,
.jive-online-box .jive-box TH,
.jive-featured-box .jive-box TH,
.jive-search-box .jive-box TH,
.jive-sidebarsearch-box .jive-box TH,
.jive-header-style TH {
    text-align : left;
    padding-left: 6px;
    border-bottom: 1px #cccccc solid;
}
.jive-recententry-box .jive-box,
.jive-popularentries-box .jive-box,
.jive-featuredentries-box .jive-box,
.jive-account-box .jive-box,
.jive-tools-box .jive-box,
.jive-related-box .jive-box,
.jive-attachment-box .jive-box,
.jive-referencing-box .jive-box,
.jive-popular-box .jive-box,
.jive-online-box .jive-box,
.jive-featured-box .jive-box,
.jive-search-box .jive-box,
.jive-sidebarsearch-box .jive-box {

}
.jive-button .jive-button-label {
    padding-right : 5px;
}
.jive-info-text {
    color : #060;
    background: transparent;
}
.nobreak {
    white-space: nowrap;
}

/* tabs */
.jive-selected-tab {
    border-width : 1px 1px 0px 1px;
    background-color : #ff0;
    color : #000000;
}
.jive-tab {
    border-width : 2px 1px 1px 1px;
}
.jive-tab:hover {
    background-color : #eee;
    border-top : 2px #999 solid;
    color : #000000;
}
.jive-tab A:hover, .jive-selected-tab A:hover {
    text-decoration : none !important;
}
.jive-tab-spacer, .jive-tab-spring {
    border-width : 0px 0px 1px 0px;
}
.jive-selected-tab, .jive-tab, .jive-tab-spacer, .jive-tab-spring, .jive-tab-bar
{
    border-color : #bbb;
    border-style : solid;
}
.jive-tab, .jive-selected-tab {
    padding : 3px 10px 3px 10px;
    font-family : tahoma, sans-serif;
    font-size : 0.6em;
}
.jive-selected-tab A {
    color : #000 !important;
    background-color : #fff;
    text-decoration : none;

}
.jive-tab A {
    color : #333 !important;
    background-color : #ddd;
    text-decoration : none;

}
.jive-tab-breadcrumb A {
    color : #333 !important;
    text-decoration : none;

    font-size : 10px;
}
.jive-tab A:hover, .jive-selected-tab A:hover {
    text-decoration : underline;
}
.jive-tab {
    background-color : #ddd;
    color : #000000;
}
.jive-tab-bar {
    background-color : #fff;
    border-width : 0px 1px 1px 1px;
    color : #000000;
}
.jive-tab-bar TD {
    background-color : #fff;
    color : #000000;
    font-family : tahoma, sans-serif;

}
.jive-tab-bar A {
    font-weight : normal;
    font-family : verdana, sans-serif;
    font-size : 0.7em;
    color : #666;
    background-color : #fff;
    text-decoration : none;
}
.jive-tab-bar A:visited {
    color : #666;
    background-color : #fff;
}
.jive-tab-bar A:hover {
    color : #666;
    background-color : #fff;
    text-decoration : underline;
}
.jive-tab-section TD {
    font-weight : normal;
    font-family : verdana, sans-serif;
    font-size : 0.6em;
}
.jive-tab-section A {
    color : #333 !important;
    background-color : #fff;
    padding-right : 6px;
    font-weight : normal;
}
.jive-tab-spring {
    font-size : 0.7em;
}
.jive-tab-logout {
    font-size : 0.7em;
}

.jive-top-table, .jive-icon , .jive-top-label {

    vertical-align : top;
}
.jive-button-row {
    vertical-align : middle;
    padding : 5px 5px 5px 5px;
}
.jive-main-button { }
.jive-cancel-button, .jive-spell-button { }

.jive-main-button:hover, jive-main-button:active,
.jive-cancel-button:hover, jive-cancel-button:active { }

.jive-update-button, .jive-delete-button {
    background-color : #eee;
    color : #000000;
}

/* spell checking */
.jive-spell-highlight-first {
    font-weight : bold;
    background-color : #ff0;
    color : #000000;
}
.jive-spell-highlight {
    background-color : #ff0;
    color : #000000;
}
.jive-field { }

#jive-category-list .jive-category-header {
    font-weight : bold;
    text-align : left;
    vertical-align : top;
    background-color : #ffffff;
    color : #000000;
}
#jive-category-list .jive-icon {
    text-align : center;
}
#jive-category-list TD .description, #jive-category-list TD .info {
    font-weight : bold;
    color : #666;
    background: transparent;
}
#jive-category-list TD .info {
    font-size: 11px;
}
#jive-category-list .jive-entry {
    vertical-align : top;
}
.jive-category-name {
    font-weight: bold;
    font-size: 1.5em;
}
.jive-browse-category {
    font-weight : bold;
    font-size : 0.9em;
    color : #600;
    background: transparent;
    vertical-align : top;
}
.jive-category-header A {
    text-decoration : none;
}
.jive-category-header A:hover, .jive-category-header A:active {
    text-decoration : underline;
}
.jive-category-name {
    font-size : 13px !important;
    font-weight : bold;
}
.jive-sidebar-entry {
    vertical-align : top;
}
.jive-sidebar-entry UL {
    text-indent : 1px;
}
.jive-paginator .jive-current-page {
    background-color : #eee;
    color : #000000;
    text-decoration : none;
    font-weight : bold;
}
.jive-table-header {
    background-color : #ccc;
    color : #000000;
}
.jive-table-header TH {
    color : #333;
    font-weight : bold;
    font-size : 10px;
    text-decoration : none;
    font-family : tahoma, sans-serif;
}

.jive-entry-list A {
}
.jive-entry-list A:hover {
}
.jive-entry-list .jive-name {
    font-weight : bold;
}
.jive-entry-list {
    background-color : #eee;
    color : #000000;
}
.jive-moderate {
    background-color : #fcc;
    color : #000000;
}

.jive-moderate-link A {
    font-weight : bold;
    text-decoration : none;
}
.jive-moderate-link A:link {
    color : #f00;
    background: transparent;
}
.jive-moderate-link A:visited {
    color : #f00;
    background: transparent;
}
.jive-moderate-link A:hover {
    color : #f00;
    background: transparent;
}
.jive-moderate-link A:active {
    color : #f00;
    background: transparent;
}

#jive-entry {
    border-color : #cccccc;
    border-width : 1px;
    border-style : solid;
}
#jive-entry TH {
    text-align : left;
    font-weight : normal;
    background-color : #eee;
    color : #000000;
}
#jive-entry .jive-entry-text, .jive-entrypart, .jive-entrypart-text, .jive-comment .jive-comment-text {
    padding : 12px 12px 12px 12px;
}
.jive-entry-title {
    font-size : 1.2em;
    font-weight : bold;
}
#jive-entrypart {
    border-color : #cccccc;
    border-width : 1px;
    border-style : solid;
}
.jive-entrypart TH {
    text-align : left;
    font-weight : normal;
    background-color : #eee;
    color : #000000;
}
.jive-comment {
    border-color : #cccccc;
    border-width : 1px;
    border-style : solid;
}
.jive-comment TH {
    text-align : left;
    font-weight : normal;
    background-color : #eee;
    color : #000000;
}
.jive-new-content {
    color : #600;
    background: transparent;
}
.jive-old-content {
    color : #ccc;
    background: transparent;
}
.jive-page-title {
    font-size : 1.2em;
    font-weight : bold;
}
.jive-bold, .jive-bold-label {
    font-weight : bold;
}
.jive-search-term {
    background-color : #ff0;
    color : #000000;
    font-weight : bold;
}

.jive-mouse-over, .jive-selected-tab, .jive-tab {
    cursor: hand;
    voice-family: "\"}\"";
    voice-family: inherit;
    cursor: pointer;
}
.jive-small-font {
    font-family : tahoma, arial, helvetica, sans-serif;
    font-size : 0.6em;
}
.jive-category-header A {
    color : #000;
}
.jive-category-header A:visited {
    color : #000;
}


TABLE.calBgColor {
    padding : 0px;
}
td.cal {
    font-family : Arial,Helvetica,Sans-serif;
    font-size : 11px;
    color : #000000;
    background-color : #fff;
    padding : 0px;
}
select.month {
    font-family : Arial,Helvetica,Sans-serif;
    font-size : 11px;
    color : #000000;
    background: transparent;
    width : 85px;
}
input.year {
    font-family : Arial,Helvetica,Sans-serif;
    font-size : 11px;
    color : #000000;
    background: transparent;
    width : 30px;
}
td.calDaysColor {
    font-family : Arial,Helvetica,Sans-serif;
    font-size : 11px;
    color : #ffffff;
    background-color : #000000;
}
td.calWeekend {
    font-family : Arial,Helvetica,Sans-serif;
    font-size : 11px;
    color : #ffffff;
    background-color : #d3d3d3;
}
td.calBgColor {
    font-family : Arial,Helvetica,Sans-serif;
    font-size : 11px;
    color : #ffffff;
    background-color : #ffc;
}
.calBorderColor {
    font-family : Arial,Helvetica,Sans-serif;
    font-size : 11px;
    color : #ffffff;
    background-color : #a9a9a9;
}
td.calHighlightColor {
    font-family : Arial,Helvetica,Sans-serif;
    font-size : 11px;
    color : #ffffff;
    background-color : #ffffcc;
}
A.cal {
    font-family : Arial,Helvetica,Sans-serif;
    font-size : 11px;
    color : #000000;
    background: transparent;
    text-decoration : none;
}
A.cal:Hover {
    font-family : Arial,Helvetica,Sans-serif;
    font-size : 11px;
    color : #FF0000;
    background: transparent;
    text-decoration : none;
}
.calDisabled {
  font-family : Arial,Helvetica,Sans-serif;
  font-size : 11px;
  color : #808080;
  background: transparent;
  text-decoration : none;
}


.jive-list {
    border : 1px #cccccc solid;
}
.jive-list TH {
    background-color : #777777;
    color : #ffffff;
}

#jive-cat-forum-list .jive-forum-category-name {
    background-color : #f8f8f8;
}
#jive-cat-forum-list TH, .jive-list .jive-date, .jive-list .jive-author, #jive-reply-tree .jive-author
{
    white-space : nowrap;
}
#jive-cat-forum-list TH, .jive-list .jive-counts, .jive-list .jive-date, .jive-list .jive-author, #jive-reply-tree .jive-author
{
    padding-left : 6px;
    padding-right : 6px;
}
#jive-cat-forum-list .jive-even, #jive-cat-forum-list .jive-odd {
    background-color : #ffffff;
}
#jive-reply-tree .jive-bullet {
    padding-right : 5px;
}

/* ADDITION for new category pages. */
.jive-forum-category-name {
    font-weight : bold;
    font-size : 1.0em;
}
.jive-forum-category-info {
    font-size : 0.8em;
}

/* END ADDITION */

.jive-list .jive-counts {
    text-align : center;
}
.jive-message-list TH, .jive-message TH {
    background-color : #777777;
    text-align : left;
    color : #ffffff;
}
.jive-message-list .jive-odd, .jive-message {
    background-color : #eeeeee;
}
.jive-message-list .jive-even {
    background-color : #ffffff;
}
.jive-sidebar .jive-box TH {




}
.jive-sidebar .jive-box {

}
.jive-account-box .jive-box TD {
    padding-bottom : 6px;
}
.jive-account-form .jive-required {
    font-weight : bold;
}
.jive-account-form .jive-label {
    text-align : left;
}
.jive-last-post {
    font-family : verdana;
    font-weight : normal;
    font-size : 0.8em;
}


#jive-reply-tree .jive-odd {
    background-color : #eeeeee;
}
#jive-reply-tree .jive-even {
    background-color : #ffffff;
}
#jive-reply-tree .jive-current, #jive-reply-tree .jive-current A {
    background-color : #ffffcc;
    font-weight : bold;
}
#jive-reply-tree .jive-list {
    border : 1px #cccccc solid;
}
#jive-reply-tree TH {
    background-color : #777777;
    color : #ffffff;
}

.jive-message .jive-box {
    border : 1px #cccccc solid;
}
.jive-message .jive-box TD {
    background-color : #eee;
}

.jive-message-content .jive-subject-row {
    border-bottom : 1px #cccccc solid;
}

.jive-search-form TH {
    text-align : left;
    border-bottom : 1px #cccccc solid;
}
.jive-search-result .jive-info {
    color : #999;
    padding-left : 6px;
}
.jive-search-result .jive-body {
    padding : 6px;
}
.jive-search-result .jive-hilite {
    background-color : #ff0;
    font-weight : bold;
}
.jive-group-result {
    font-weight : bold;
}

/* add a little more space next to the by: of the last post */
#jive-topic-list .jive-last-post {
    padding-left : 5px;
}

/* Control Panel styles */
.jive-cp-formbox TABLE {
    padding-left : 25px;
}
.jive-cp-header {
    font-weight : bold;
}
.jive-cp-formbox .jive-label {
    text-align : left;
    padding-top : 5px;
}

/* Paginator styles */
.jive-paginator .jive-current, .jive-message-list-footer .jive-paginator .jive-current {
    background-color : #eee;
    text-decoration : none;
    font-weight : bold;
    color : #000 !important;
}
.jive-message-list .jive-paginator A {
    color : #fff;
}
jive-message-list .jive-footer .jive-paginator A {
    color : #000;
}
.jive-paginator-bottom .jive-paginator .jive-current {
    background-color : #eee;
    text-decoration : none;
    font-weight : bold;
    color : #000 !important;
}
.jive-paginator-bottom .jive-paginator A {
    color : #000 !important;
}

/* post form */
.jive-post-form .jive-font-buttons INPUT {
    background-color : #eee;
    font-size : 0.8em;
    font-family : verdana;
    height : 22px;
    border-width : 2px;
    border-top-color : #ddd;
    border-right-color : #ccc;
    border-bottom-color : #ccc;
    border-left-color : #ddd;
}

/* profile page */
.jive-profile TH {
    text-align : left;
    border-bottom : 1px #cccccc solid;
}
.jive-profile .jive-label {
    text-align : left;
}

/* watches page */
/*
.jive-watch-list TH {
    border-bottom : 1px #cccccc solid;
}
*/

.jive-watch-list .jive-name {
    text-align : left;
}
.jive-watch-list .jive-delete, .jive-watch-list .jive-delete-button {
    background-color : #eee;
}
.jive-watch-list .jive-even {
    background-color : #ffffff;
}
.jive-watch-list .jive-odd {
    background-color : #eeeeee;
}

/* help page */
.jive-faq-answer {
    font-weight : bold;
}

/* attachments */
.jive-attachment-list TD {
    font-size : 0.7em !important;
}
.jive-edit-attach-list TH {
    background-color : #777777;
    color : #ffffff;
    padding-left : 10px;
    padding-right : 10px;
}

/* spell checking */
.jive-spell-error-current, .jive-spell-error {
    color : #f00;
    background: transparent;
    border-bottom : #f00 2px dotted;
}
.jive-spell-error-current {
    background-color : #eee;
    font-weight : bold;
    color : #000000;
}
.jive-spell-form .jive-spell-button {
    background-color : #eee;
    font-size : 0.8em;
    font-family : verdana,arial,helvetica,sans-serif;
    padding : 2px 6px 2px 6px;
}
.jive-spell-form .jive-box TH {
    background-color : #777777;
    color : #ffffff;
}

/* Guest styles */
.jive-guest {
    font-style : italic !important;
}

/* lists of users */
.jive-top-users-box .jive-box TH {
    text-align : left;
    background-color : #777777;
    color : #ffffff;
}

/* salient special messages (such as downtime notices) */
.special-message {
  padding-top: 0.5em;
  color : #c00;
  font-weight: bold;
  font-size: 1.2em;
}
