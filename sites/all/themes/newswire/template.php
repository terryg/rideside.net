<?php // $Id: template.php,v 1.9 2009/11/03 22:22:04 jmburnz Exp $
/**
 * @file 
 *  template.php
 */
/**
 * Sets a body-tag class.
 * Adds 'four-column', 'three-column', 'two-column' or 'one-column' class as needed.
 *
 * Do not use these classes to set the width of the main columns! 
 * See 'function newswire_col_width' and layout.css for setting the column widths.
 *
 * @param $left, $content, $right, $right_2
 *   The main column regions
 */
function newswire_column_count_class($left, $content, $right, $right_2) {
  if ($content && $left && $right && $right_2) {
    $class = 'four-column'; // all four columns active
  }
  else {
    if (($content && $left && $right) or ($content && $left && $right_2) or ($content && $right && $right_2)) {
      $class = 'three-column'; // three columns active
    }
    else {
      if (($content && $left) or ($content && $right) or ($content && $right_2)) {
        $class = 'two-column'; // two columns active
      }
      else {
        if ($content != '') {
          $class = 'one-column'; //one column (content itelf) active
        }
      }
    }
  }
  if (isset($class)) {
    print $class;
  }
}
/**
 * Set the width of the content region.
 *
 * Adds a width selector to $content depending on the cols are being used.
 * To change the widths see 'layout.css' and choose the selectors that match
 * the widths you require. Be careful not to exceed width-48-950 (960px) unless you
 * modify the #container width.
 *
 * @param $left, $content, $right, $right_2
 *   The main column regions
 */
function newswire_col_width($left, $content, $right, $right_2) {
  if ($content && $left && $right && $right_2) {
    $class = 'width-18-350'; //if 4 col, content will be 350px
  }
  else {
    if (($content && $left && $right) or ($content && $right && $right_2) or ($content && $left && $right_2)) {
      $class = 'width-28-550'; //if 3 col content will be 550px
    }
    else {
      if (($content && $left) or ($content && $right_2) or ($content && $right)) {
        $class = 'width-38-750'; //if 2 col content will be 750px
      }
      else {
        if ($content != '') {
          $class = 'width-48-950'; //if 1 col content will be 950px
        }
      }
    }
  }
  if (isset($class)) {
    print $class;
  }
}

/**
 * Initialize theme settings
 */
if (is_null(theme_get_setting('newswire_color_global'))) {  // <-- change this line
  global $theme_key;

  /*
   * The default values for the theme variables. Make sure $defaults exactly
   * matches the $defaults in the theme-settings.php file.
   */
  $defaults = array(             // <-- change this array
    'newswire_color_global'    => 'newswire_tan',
    'newswire_color_highlight' => 'newswire_red',
  );

  // Get default theme settings.
  $settings = theme_get_settings($theme_key);
  // Don't save the toggle_node_info_ variables.
  if (module_exists('node')) {
    foreach (node_get_types() as $type => $name) {
      unset($settings['toggle_node_info_'. $type]);
    }
  }
  // Save default theme settings.
  variable_set(
    str_replace('/', '_', 'theme_'. $theme_key .'_settings'),
    array_merge($defaults, $settings)
  );
  // Force refresh of Drupal internals.
  theme_get_setting('', TRUE);
}

$color_global = theme_get_setting('newswire_color_global');
$color_highlight = theme_get_setting('newswire_color_highlight');
// Add the style sheets.
drupal_add_css(drupal_get_path('theme', 'newswire') .'/css/'. $color_global .'.css', 'theme');
drupal_add_css(drupal_get_path('theme', 'newswire') .'/css/'. $color_highlight .'.css', 'theme');

/**
 * Override or insert preprocess variables into page templates.
 *
 * @param $vars
 *   A sequential array of variables to pass to the theme template.
 * @param $hook
 *   The name of the theme function being called ("page" in this case.)
 */
function newswire_preprocess_page(&$vars) {
  global $theme;

  // Modify the html for $logo and $site_name depending on the context.
  if ($vars['is_front']) {
    if ($vars['logo']) {
      $vars['logo'] = '<h1 class="brand"><a href="'. $vars['front_page'] .'" title="'. $vars['site_name'] .'"><img src="'. $vars['logo'] .'" alt="'. $vars['site_name'] .'" /></a></h1>'; 
    }
    elseif ($vars['site_name']) {
      $vars['site_name'] = '<h1 class="brand"><a href="'. $vars['front_page'] .'" title="'. $vars['site_name'] .'">'. $vars['site_name'] .'</a></h1>'; 
    }
  }
  else {
    if ($vars['logo']) {
      $vars['logo'] = '<div class="brand"><a href="'. $vars['front_page'] .'" title="'. $vars['site_name'] .'"><img src="'. $vars['logo'] .'" alt="'. $vars['site_name'] .'" /></a></div>'; 
    }
    elseif ($vars['site_name']) {
      $vars['site_name'] = '<div class="brand"><a href="'. $vars['front_page'] .'" title="'. $vars['site_name'] .'">'. $vars['site_name'] .'</a></div>'; 
    }
  }
  
  // Modify the html for $title depending on the context.
  if ($vars['title']) {
    if (arg(0) == 'taxonomy' && arg(1)=='term' && is_numeric(arg(2))) {
      $vars['title'] = '<h1 class="title category clearfix">'. $vars['feed_icons'] .'<span>'. $vars['title'] .'</span></h1>';
    }
    else {
      $vars['title'] = '<h1 class="title">'. $vars['title'] .'</h1>';
    }
  }
  
  // Don't display empty help from node_help().
  // @see http://drupal.org/project/zen
  if ($vars['help'] == "<div class=\"help\"><p></p>\n</div>") {
    $vars['help'] = '';
  }
  
  // Classes for body element. Allows advanced theming based on context
  // (home page, node of certain type, etc.)
  $body_class = array($vars['body_class']);
    if ($vars['content']) {
    // Add a class that tells us whether we're on the front page or not.
    $body_class[] = $vars['is_front'] ? 'front' : 'not-front';
    // Add a class that tells us whether the page is viewed by an authenticated user or not.
    $body_class[] = $vars['logged_in'] ? 'logged-in' : 'not-logged-in';
    }
    // If on an individual node page, add the node type.
    if (isset($vars['node']) && $vars['node']->type) {
      $body_class[] = 'node-type-'. newswire_id_safe($vars['node']->type);
    }
    if (!$vars['is_front']) {
    // Add unique class for each page and website section.
    // This is borrowed from the Zen theme http://drupal.org/project/zen.
    $path = drupal_get_path_alias($_GET['q']);
    list($section, ) = explode('/', $path, 2);
    $body_class[] = newswire_id_safe('page-'. $path);
    $body_class[] = newswire_id_safe('section-'. $section);
    if (arg(0) == 'node') {
      if (arg(1) == 'add') {
        if ($section == 'node') {
          array_pop($body_class); // Remove 'section-node'
        }
        $body_class[] = 'section-node-add'; // Add 'section-node-add'
      }
      elseif (is_numeric(arg(1)) && (arg(2) == 'edit' || arg(2) == 'delete')) {
        if ($section == 'node') {
          array_pop($body_class); // Remove 'section-node'
        }
        $body_class[] = 'section-node-'. arg(2); // Add 'section-node-edit' or 'section-node-delete'
      }
    }
  }
  $vars['body_class'] = implode(' ', $body_class); // Concatenate with spaces
}

/**
 * Override or insert preprocess variables into the node templates.
 *
 * @param $vars
 *   A sequential array of variables to pass to the theme template.
 * @param $hook
 *   The name of the theme function being called ("node" in this case.)
 *
 * @see http://drupal.org/project/zen
 */
function newswire_preprocess_node(&$vars) {
  global $user;

  // Special classes for nodes
  $node_classes = array();
  if ($vars['sticky']) {
    $node_classes[] = 'sticky';
  }
  if (!$vars['node']->status) {
    $node_classes[] = 'node-unpublished';
    $vars['unpublished'] = TRUE;
  }
  else {
    $vars['unpublished'] = FALSE;
  }
  if ($vars['node']->uid && $vars['node']->uid == $user->uid) {
    // Node is authored by current user
    $node_classes[] = 'node-mine';
  }
  if ($vars['teaser']) {
    // Node is displayed as teaser
    $node_classes[] = 'node-teaser';
  }
  // Class for node type: "node-type-page", "node-type-story", "node-type-my-custom-type", etc.
  $node_classes[] = 'node-type-'. $vars['node']->type;
  $vars['node_classes'] = implode(' ', $node_classes); // Concatenate with spaces
  
  // Add $node_region region to node.tpl.php
  $vars['node_region'] = theme('blocks', 'node_region');
}
/**
 * Override or insert preprocess variables into the comment templates.
 *
 * @param $vars
 *   A sequential array of variables to pass to the theme template.
 * @param $hook
 *   The name of the theme function being called ("comment" in this case.)
 *
 *  @see http://drupal.org/project/zen
 */
function newswire_preprocess_comment(&$vars) {
  global $user;

  // We load the node object that the current comment is attached to
  $node = node_load($vars['comment']->nid);
  // If the author of this comment is equal to the author of the node, we
  // set a variable so we can theme this comment uniquely.
  $vars['author_comment'] = $vars['comment']->uid == $node->uid ? TRUE : FALSE;

  $comment_classes = array();

  // Odd/even handling
  static $comment_odd = TRUE;
  $comment_classes[] = $comment_odd ? 'odd' : 'even';
  $comment_odd = !$comment_odd;

  if ($vars['comment']->status == COMMENT_NOT_PUBLISHED) {
    $comment_classes[] = 'comment-unpublished';
    $vars['unpublished'] = TRUE;
  }
  else {
    $vars['unpublished'] = FALSE;
  }
  if ($vars['author_comment']) {
    // Comment is by the node author
    $comment_classes[] = 'comment-by-author';
  }
  if ($vars['comment']->uid == 0) {
    // Comment is by an anonymous user
    $comment_classes[] = 'comment-by-anon';
  }
  if ($user->uid && $vars['comment']->uid == $user->uid) {
    // Comment was posted by current user
    $comment_classes[] = 'comment-mine';
  }
  $vars['comment_classes'] = implode(' ', $comment_classes);

  // If comment subjects are disabled, don't display 'em
  if (variable_get('comment_subject_field', 1) == 0) {
    $vars['title'] = '';
  }
  //dpm($vars['comment']);
}
/**
 * Override or insert PHPTemplate variables into the block templates.
 *
 * @param $vars
 *   A sequential array of variables to pass to the theme template.
 * @param $hook
 *   The name of the theme function being called ("block" in this case.)
 *
 * @see http://drupal.org/project/zen
 */
function newswire_preprocess_block(&$vars) {
  $block = $vars['block'];

  // Special classes for blocks
  $block_classes = array();
  $block_classes[] = 'block-'. $block->module;
  $block_classes[] = 'region-'. $vars['block_zebra'];
  $block_classes[] = $vars['zebra'];
  $block_classes[] = 'region-count-'. $vars['block_id'];
  $block_classes[] = 'count-'. $vars['id'];
  $vars['block_classes'] = implode(' ', $block_classes);

}
/**
 * Converts a string to a suitable html ID attribute.
 *
 * http://www.w3.org/TR/html4/struct/global.html#h-7.5.2 specifies what makes a
 * valid ID attribute in HTML. This function:
 *
 * - Ensure an ID starts with an alpha character by optionally adding an 'n'.
 * - Replaces any character except A-Z, numbers, and underscores with dashes.
 * - Converts entire string to lowercase.
 *
 * @param $string
 *   The string
 * @return
 *   The converted string
 *
 * @see http://drupal.org/project/zen
 */
function newswire_id_safe($string) {
  // Replace with dashes anything that isn't A-Z, numbers, dashes, or underscores.
  $string = strtolower(preg_replace('/[^a-zA-Z0-9_-]+/', '-', $string));
  // If the first character is not a-z, add 'n' in front.
  if (!ctype_lower($string{0})) { // Don't use ctype_alpha since its locale aware.
    $string = 'id'. $string;
  }
  return $string;
}
