<?php
/**
 * Ubiquity Drupal theme
 * constructed by Attila Beregszaszi (http://templates.m42.hu/)
 */

/*  Page variables  */
function ubiquity_preprocess_page(&$vars) {
  global $theme;
  $body_classes = array($vars['body_classes']);
  if (!$vars['is_front']) {
    // Add unique classes for each page and website section
    $path = drupal_get_path_alias($_GET['q']);
    list($section, ) = explode('/', $path, 2);
  }

  $body_classes[] = ($vars['secondary_links']) ? 'withsecondary' : '';

  $vars['body_classes'] = implode(' ', $body_classes);
}


/*  Node variables  */
function phptemplate_preprocess_node(&$vars) {
  global $user;

  $node_classes = array();
  if ($vars['sticky']) {
    $node_classes[] = 'sticky';
  }
  if (!$vars['node']->status) {
    $node_classes[] = 'unpublished';
    $vars['unpublished'] = TRUE;
  }
  else {
    $vars['unpublished'] = FALSE;
  }
  if ($vars['teaser']) {
    // Node is displayed as teaser
    $node_classes[] = 'teaser';
  }
  $node_classes[] = 'type-'. $vars['node']->type;
  $vars['node_classes'] = implode(' ', $node_classes); // Concatenate with spaces
}


/*  Breadcrumb override  */
function ubiquity_breadcrumb($breadcrumb) {
  if (!empty($breadcrumb)) {
    return '<div class="breadcrumb">'. implode(' &raquo ', $breadcrumb) .'</div>';
  }
 }


/*  HTMLize links  */
function ubiquity_menu_item_link($link) {
  if (empty($link['localized_options'])) {
    $link['localized_options'] = array();
  }
  $link['title'] = '<span>'.$link['title'].'</span>'; // enclose link title with a span tag
  $link['localized_options']['html'] = TRUE; // set to html

  return l($link['title'], $link['href'], $link['localized_options']);
}


/*  Comment wrapper  */
function ubiquity_comment_wrapper($content, $node) {
  if (!$content) {
    return '';
  }
  else {
    return '<div id="comments">'. $content .'</div>';
  }
}


/*  Get IE-specific css files  */
function ubiquity_get_ie_stylesheets() {
  global $language;
  $css = '<link type="text/css" rel="stylesheet" media="all" href="'.base_path().path_to_theme().'/fix-ie.css" />';
  return $css;
}
