// ==UserScript==
// @name        twitter-followers-no
// @namespace   twitter
// @include     https://twitter.com/
// @version     1
// @require http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js
// 
// @grant       none
// ==/UserScript==
//
// This is a script that removes the number of followers from your main page
// (c) Spencer Krum 2016
// Apache 2 License

//alert('sup');

//<span class="ProfileCardStats-statValue" data-is-compact="false">574</span>
$(".ProfileCardStats-statValue").last().text("Be Happy")
