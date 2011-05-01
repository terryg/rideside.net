UBIQUITY DRUPAL THEME

Theme design and CSS concepts by Attila Beregszaszi.
Website:   http://templates.m42.hu/

Contains but not built upon the ideas and concepts implemented in the
Drupal Zen project (http://drupal.org/project/zen)


ABOUT
=====
Ubiquity tries to implement a generic look found or sought by many webpage
owners. It is completely valid XHTML Strict 1.0 and CSS 2.0.
Using the 'anyorder columns' layout style it will make your pages search
engine friendly as the main content column comes first in the html.


REQUIREMENTS
============
- Drupal 6.2 or greater
- PHPTemplate theme engine (included in a standard Drupal-6.x package)


KNOWN ISSUES
============

misc/textarea.js needs to be patched in Drupal 5.1
--------------------------------------------------
Since Ubiquity uses floated elements such as the resizable textarea element,
it suffers from the infamous wrapping bug when using IE6 (not sure about IE7)

See http://drupal.org/node/101305#comment-195002
and apply the patch attached in the comment.

If you have trouble patching, simply open misc/textarea.js and replace line
7 with the following two lines:

    // When wrapping the text area, work around an IE margin bug.
    $(this).wrap('<div class="resizable-textarea"><span></span></div>')
